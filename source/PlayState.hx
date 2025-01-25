package;

import Creature.Dir;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxContainer;
import flixel.group.FlxSpriteContainer;
import flixel.math.FlxPoint;
import flixel.system.scaleModes.PixelPerfectScaleMode;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import openfl.filters.ShaderFilter;

class PlayState extends FlxState {
	static inline var CAMERA_OFFSET = -Util.SCREEN_HEIGHT / 5;

	static inline var MIN_CAVE_WIDTH = 420;
	static inline var MAX_CAVE_WIDTH = 520;

	var walls:Array<Walls>;
	var creatureLayers:Array<CreatureLayer>;
	var bell:FlxSprite;

	var depthShader:DepthShader;

	var CREATURE_SPRITES:Array<FlxSprite>;

	override public function create() {
		super.create();

		FlxG.mouse.useSystemCursor = true;

		FlxG.scaleMode = new PixelPerfectScaleMode();
		FlxG.camera.bgColor = FlxColor.fromRGB(20, 20, 40);

		walls = [
			new Walls(AssetPaths.wall_3_left__png, AssetPaths.wall_3_right__png, 2),
			new Walls(AssetPaths.wall_2_left__png, AssetPaths.wall_2_right__png, 1),
			new Walls(AssetPaths.wall_left__png, AssetPaths.wall_right__png, 0),
		];

		creatureLayers = [new CreatureLayer(3), new CreatureLayer(2), new CreatureLayer(1),];

		bell = new FlxSprite(0, 0);
		bell.loadGraphic(AssetPaths.bell__png);
		bell.velocity.y = 10;

		// Add elements in order from back to front
		add(creatureLayers[0]);
		add(walls[0]);
		add(creatureLayers[1]);
		add(walls[1]);
		add(creatureLayers[2]);
		add(walls[2]);
		add(bell);

		FlxG.camera.follow(bell, FlxCameraFollowStyle.LOCKON);
		FlxG.camera.targetOffset.set(0, CAMERA_OFFSET);

		depthShader = new DepthShader();
		FlxG.camera.filters = [new ShaderFilter(depthShader)];
		FlxG.camera.filtersEnabled = false;

		// Creature sprites setup
		var medusa = new FlxSprite();
		medusa.loadGraphic(AssetPaths.medusa__png, true, 56, 92);
		medusa.animation.add('swim', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 5);
		medusa.animation.play('swim');

		var perch = new FlxSprite();
		perch.loadGraphic(AssetPaths.ahven__png, true, 32, 32);
		perch.animation.add('swim', [0, 1, 2, 3, 4, 5, 6], 5);
		perch.animation.play('swim');

		var swordfish = new FlxSprite();
		swordfish.loadGraphic(AssetPaths.swordfish__png, true, 64, 64);
		swordfish.animation.add('swim', [0, 1, 2, 3, 4, 5], 5);
		swordfish.animation.play('swim');

		CREATURE_SPRITES = [medusa, perch, swordfish];
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		var caveWidth = getCaveWidth(bell.y);
		for (w in walls) {
			w.setCaveWidth(caveWidth);
		}

		if (FlxG.keys.justPressed.SPACE) {
			FlxTween.tween(bell, { "velocity.y": 0 }, 3, { ease: FlxEase.sineOut });
		}

		depthShader.setDepth(Math.abs(bell.y));

		for (layer in creatureLayers) {
			if (Math.random() < 0.01) {
				spawnCreature(layer);
			}
		}
	}

	private function getCaveWidth(y:Float):Float {
		// TODO: Make it narrower the deeper we go
		return MAX_CAVE_WIDTH;
	}

	private function spawnCreature(layer:CreatureLayer) {
		var type = Util.randomChoice(CREATURE_SPRITES);
		var dir = Math.random() <= 0.5 ? Dir.RIGHT : Dir.LEFT;
		var x = dir == Dir.RIGHT ? FlxG.camera.viewLeft - 10 : FlxG.camera.viewRight + 10;
		var y = FlxG.camera.viewTop + Math.random() * Util.SCREEN_HEIGHT;

		var creature = new Creature(x, y, new FlxPoint(10, 0), dir);
		creature.loadGraphicFromSprite(type);

		var scale = layer.getScale();
		creature.scale.set(scale, scale);

		layer.add(creature);
	}
}
