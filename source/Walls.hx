package;

import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;

class Walls extends FlxTypedSpriteContainer<FlxBackdrop> {
	var wallLeft:FlxBackdrop;
	var wallRight:FlxBackdrop;

	var xOffset:Float;

	public function new(depth:Float) {
		super();

		this.xOffset = depth * 10;
		this.scrollFactor.y = 1 - depth / 5;

		wallLeft = new FlxBackdrop(AssetPaths.wall_left__png, Y);
		wallLeft.y = depth * 123;
		add(wallLeft);

		wallRight = new FlxBackdrop(AssetPaths.wall_right__png, Y);
		wallRight.y = depth * 123;
		add(wallRight);
	}

	public function setCaveWidth(width:Float) {
		wallLeft.x = -width / 2 + 32 + xOffset;
		wallRight.x = width / 2 - 128 - xOffset;
	}
}
