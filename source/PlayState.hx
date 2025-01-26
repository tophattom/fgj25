package;

import Creature.CreatureType;
import Creature.Dir;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.input.mouse.FlxMouseEvent;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.sound.FlxSound;
import flixel.system.scaleModes.PixelPerfectScaleMode;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import haxe.Timer;
import openfl.filters.ShaderFilter;

class PlayState extends FlxState {
	static inline var MIN_CAVE_WIDTH = 420;
	static inline var MAX_CAVE_WIDTH = 520;

	static inline var BELL_MAX_SPEED = 10;
	static inline var BELL_ACCELERATION = 10;

	var previousPixelY = 0.0;
	var depth = 0.0;

	var ascendDialogOpen = false;
	var ascending = false;

	var wallLayers:Array<WallLayer>;
	var creatureLayers:Array<CreatureLayer>;

	var titleManager:ZoneTitleManager;

	var bell:FlxSprite;
	var tether:FlxSprite;

	var ui:UI;

	var radioBubble:RadioBubble;

	var defaultCamera:FlxCamera;
	var uiCamera:FlxCamera;

	var depthShader:DepthShader;

	var CREATURE_TYPES:Array<CreatureType>;

	var music:FlxSound;
	var winchSound:FlxSound;

	override public function create() {
		super.create();

		FlxG.mouse.useSystemCursor = true;

		FlxG.scaleMode = new PixelPerfectScaleMode();

		defaultCamera = new FlxCamera();
		defaultCamera.bgColor = FlxColor.fromRGB(20, 20, 40);
		FlxG.cameras.add(defaultCamera);

		uiCamera = new FlxCamera(0, 0, Util.SCREEN_WIDTH, Util.SCREEN_HEIGHT);
		uiCamera.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(uiCamera, false);

		FlxG.camera = defaultCamera;

		wallLayers = [
			new WallLayer(AssetPaths.wall_3_left__png, AssetPaths.wall_3_right__png, 2),
			new WallLayer(AssetPaths.wall_2_left__png, AssetPaths.wall_2_right__png, 1),
			new WallLayer(AssetPaths.wall_left__png, AssetPaths.wall_right__png, 0),
		];

		creatureLayers = [new CreatureLayer(3), new CreatureLayer(2), new CreatureLayer(1),];

		titleManager = new ZoneTitleManager();

		bell = new FlxSprite(0, 0);
		bell.loadGraphic(AssetPaths.bell__png);
		bell.maxVelocity.set(0, BELL_MAX_SPEED);
		bell.drag.set(0, BELL_ACCELERATION);

		tether = new FlxSprite(0, 0);
		tether.loadGraphic(AssetPaths.tether__png);

		ui = new UI();
		ui.camera = uiCamera;

		radioBubble = new RadioBubble(216, 26);
		radioBubble.camera = uiCamera;

		// Add elements in order from back to front
		add(creatureLayers[0]);
		add(wallLayers[0]);
		add(creatureLayers[1]);
		add(wallLayers[1]);
		add(creatureLayers[2]);
		add(wallLayers[2]);
		placeLogEntries();
		add(titleManager);
		add(tether);
		add(bell);
		add(ui);
		add(radioBubble);

		FlxG.camera.follow(bell, FlxCameraFollowStyle.NO_DEAD_ZONE);
		FlxG.camera.targetOffset.set(0, 24);

		depthShader = new DepthShader();
		FlxG.camera.filters = [new ShaderFilter(depthShader)];
		FlxG.camera.filtersEnabled = true;

		CREATURE_TYPES = Creature.getCreatureTypes();

		if (music == null) {
			music = FlxG.sound.play(AssetPaths.ambientloop__ogg, 0.0, true);
			music.fadeIn(300, 0, 100);
		}

		if (winchSound == null) {
			winchSound = FlxG.sound.play(AssetPaths.winchloop__ogg, 0.0, true);
		}

		Util.cameraFadeIn();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		var depth = getDepth(bell.y);

		if (FlxG.keys.justPressed.SPACE) {
			openLogEntry(GameData.getZone(depth).logs[0]);
		}

		if (FlxG.keys.anyPressed(Util.DOWN_KEYS) && depth < GameData.MaxDepth && !ascending) {
			bell.acceleration.set(0, BELL_ACCELERATION);
		} else if (!ascending || (ascending && bell.y <= 0)) {
			bell.acceleration.set(0, 0);
		}

		if (FlxG.keys.anyJustPressed(Util.DOWN_KEYS) && !ascending) {
			winchSound.fadeIn(1.0);
		} else if (FlxG.keys.anyJustReleased(Util.DOWN_KEYS) && !ascending) {
			winchSound.fadeOut(1.0);
		}

		if (FlxG.keys.anyJustPressed([W, UP]) && !ascending) {
			radioBubble.show(depth);
			ascendDialogOpen = true;
		}

		if (ascendDialogOpen && FlxG.keys.firstJustPressed() != -1 && FlxG.keys.firstJustPressed() != W && FlxG.keys.firstJustPressed() != UP) {
			radioBubble.hide();
			ascendDialogOpen = false;
			if (FlxG.keys.justPressed.Y) {
				trace('asd');
				ascending = true;
				bell.acceleration.set(0, -BELL_ACCELERATION);
				bell.maxVelocity.set(0, 2 * BELL_MAX_SPEED);
				winchSound.fadeIn(1.0);
				Timer.delay(() -> {
					winchSound.fadeOut(1.0);
					music.fadeOut(1.0);

					Util.cameraFadeOut(1.0, () -> {
						FlxG.switchState(new EndGameState());
					});
				}, 4000);
			}
		}

		titleManager.setDepth(depth, bell.y);

		tether.y = bell.y - 150;

		ui.setDepth(depth);

		var caveWidth = getCaveWidth(depth);
		for (w in wallLayers) {
			w.setCaveWidth(caveWidth);
		}

		depthShader.setDepth(depth);

		for (layer in creatureLayers) {
			if (Math.random() < 0.006) {
				spawnCreature(layer, depth);
			}
		}
	}

	private function getCaveWidth(d:Float):Float {
		var ratio = d / GameData.MaxDepth;
		return FlxMath.lerp(MAX_CAVE_WIDTH, MIN_CAVE_WIDTH, FlxEase.cubeIn(ratio));
	}

	private function spawnCreature(layer:CreatureLayer, depth:Float) {
		var p = Math.random();
		var type = Util.randomChoice(CREATURE_TYPES.filter((t) -> depth >= t.min_depth && depth <= t.max_depth && p <= t.probability));

		if (type == null) {
			return;
		}

		var dir = Math.random() <= 0.5 ? Dir.RIGHT : Dir.LEFT;
		var xOffset = dir == Dir.RIGHT ? -Util.SCREEN_WIDTH / 2 - type.sprite.width : Util.SCREEN_WIDTH / 2 + type.sprite.width;
		var y = bell.y + Math.random() * Util.SCREEN_HEIGHT;
		var speed = Util.randomBetween(type.speed_min, type.speed_max);

		var creature = new Creature(bell.x + xOffset, y, new FlxPoint(speed, 0), dir);
		creature.loadGraphicFromSprite(type.sprite);
		creature.alpha = type.alpha;

		layer.add(creature);
	}

	private function getDepth(y:Float):Float {
		var zoneIndex = GameData.getZoneIndexByY(y);
		if (zoneIndex == -1) {
			return GameData.MaxDepth;
		}

		var zone = GameData.Zones[zoneIndex];
		var limits = GameData.ZonePixelLimits[zoneIndex];
		var yDiff = y - limits.min;
		return zone.depth + yDiff * zone.depthMultiplier;
	}

	private function openLogEntry(text:String) {
		var entry = new LogEntryState(text);
		entry.camera = uiCamera;
		openSubState(entry);
	}

	private function placeLogEntries() {
		for (i in 0...GameData.Zones.length) {
			var zone = GameData.Zones[i];
			var yLimits = GameData.ZonePixelLimits[i];
			var entryCount = zone.logs.length;
			var spacing = (yLimits.max - yLimits.min) / (entryCount + 1);

			for (j in 0...zone.logs.length) {
				var y = yLimits.min + j * spacing + Util.SCREEN_HEIGHT / 2;
				var caveWidth = getCaveWidth(getDepth(y));

				var xMin = -caveWidth / 2 + 32 + 160;
				var xMax = caveWidth / 2 - 128;
				var x = Util.randomBetween(xMin, xMax);

				var sprite = new FlxSprite(x, y);
				sprite.loadGraphic(AssetPaths.page__png, true, 32, 32);
				sprite.animation.add('idle', [0, 1, 2, 3, 4, 5], 4 + Util.randomInt(3), true, Util.randomBool(), Util.randomBool());
				sprite.animation.play('idle', false, false, -1);
				FlxMouseEvent.add(sprite, (_) -> openLogEntry(zone.logs[j]));
				add(sprite);
			}
		}
	}
}
