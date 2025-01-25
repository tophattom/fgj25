package;

import Creature.CreatureType;
import Creature.Dir;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.system.scaleModes.PixelPerfectScaleMode;
import flixel.util.FlxColor;
import openfl.filters.ShaderFilter;

class PlayState extends FlxState {
	static inline var MIN_CAVE_WIDTH = 420;
	static inline var MAX_CAVE_WIDTH = 520;

	static inline var BELL_SPEED = 10;

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
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		updateDepth();

		if (FlxG.keys.anyPressed([S, DOWN]) && depth < GameData.MaxDepth) {
			bell.velocity.y = BELL_SPEED;
		} else {
			bell.velocity.y = 0;
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

	private function getCaveWidth(y:Float):Float {
		// TODO: Make it narrower the deeper we go
		return MAX_CAVE_WIDTH;
	}

	private function spawnCreature(layer:CreatureLayer, depth:Float) {
		var p = Math.random();
		var type = Util.randomChoice(CREATURE_TYPES.filter((t) -> depth >= t.min_depth && p <= t.probability));

		if (type == null) {
			return;
		}

		var dir = Math.random() <= 0.5 ? Dir.RIGHT : Dir.LEFT;
		var x = dir == Dir.RIGHT ? FlxG.camera.viewLeft - 10 : FlxG.camera.viewRight + 10;
		var y = FlxG.camera.viewTop + Math.random() * Util.SCREEN_HEIGHT;
		var speed = Util.randomBetween(type.speed_min, type.speed_max);

		var creature = new Creature(x, y, new FlxPoint(speed, 0), dir);
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
}
