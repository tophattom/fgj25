package;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxContainer;
import flixel.system.scaleModes.PixelPerfectScaleMode;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class PlayState extends FlxState {
	static inline var CAMERA_OFFSET = -Util.SCREEN_HEIGHT / 5;

	static inline var MIN_CAVE_WIDTH = 390;
	static inline var MAX_CAVE_WIDTH = 520;

	var walls:FlxTypedContainer<Walls>;

	var bell:FlxSprite;

	override public function create() {
		super.create();

		FlxG.mouse.useSystemCursor = true;

		FlxG.scaleMode = new PixelPerfectScaleMode();
		FlxG.camera.bgColor = FlxColor.fromRGB(20, 20, 40);

		walls = new FlxTypedContainer();
		for (i in 0...3) {
			walls.add(new Walls(2 - i));
		}
		add(walls);

		bell = new FlxSprite(0, 0);
		bell.loadGraphic(AssetPaths.bell__png);
		bell.velocity.y = 10;
		add(bell);

		FlxG.camera.follow(bell, FlxCameraFollowStyle.LOCKON);
		FlxG.camera.targetOffset.set(0, CAMERA_OFFSET);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		var caveWidth = getCaveWidth(bell.y);
		for (w in walls.members) {
			w.setCaveWidth(caveWidth);
		}

		if (FlxG.keys.justPressed.SPACE) {
			FlxTween.tween(bell, { "velocity.y": 0 }, 3, { ease: FlxEase.sineOut });
		}
	}

	private function getCaveWidth(y:Float):Float {
		return MAX_CAVE_WIDTH;
	}
}
