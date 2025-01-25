package;

import Creature.CreatureType;
import Creature.Dir;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.sound.FlxSound;
import flixel.system.scaleModes.PixelPerfectScaleMode;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import openfl.filters.ShaderFilter;

class PlayState extends FlxState {
	static inline var MIN_CAVE_WIDTH = 420;
	static inline var MAX_CAVE_WIDTH = 520;

	static inline var BELL_MAX_SPEED = 10;
	static inline var BELL_ACCELERATION = 10;

	var previousPixelY = 0.0;
	var depth = 0.0;

	var wallLayers:Array<WallLayer>;
	var creatureLayers:Array<CreatureLayer>;

	var titleManager:ZoneTitleManager;

	var bell:FlxSprite;
	var tether:FlxSprite;

	var ui:UI;

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

		// Add elements in order from back to front
		add(creatureLayers[0]);
		add(wallLayers[0]);
		add(creatureLayers[1]);
		add(wallLayers[1]);
		add(creatureLayers[2]);
		add(wallLayers[2]);
		add(titleManager);
		add(tether);
		add(bell);
		add(ui);

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
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		if (FlxG.keys.justPressed.SPACE) {
			openLogEntry(GameData.getZone(depth).logs[0]);
		}

		updateDepth();

		if (FlxG.keys.anyPressed([S, DOWN]) && depth < GameData.MaxDepth) {
			bell.acceleration.set(0, BELL_ACCELERATION);
		} else {
			bell.acceleration.set(0, 0);
		}

		if (FlxG.keys.anyJustPressed([S, DOWN])) {
			winchSound.fadeIn(1.0);
		} else if (FlxG.keys.anyJustReleased([S, DOWN])) {
			winchSound.fadeOut(1.0);
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

	// Depth in meters
	private function updateDepth() {
		var pixelY = bell.y;
		var currentMultiplier = GameData.getZone(depth).depthMultiplier;
		depth = Math.min(depth + (pixelY - previousPixelY) * currentMultiplier, GameData.MaxDepth);
		previousPixelY = pixelY;
	}

	private function openLogEntry(text:String) {
		var entry = new LogEntry(text);
		entry.camera = uiCamera;
		openSubState(entry);
	}
}
