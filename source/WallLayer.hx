package;

import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;
import flixel.system.FlxAssets.FlxGraphicAsset;

class WallLayer extends FlxTypedSpriteContainer<FlxBackdrop> {
	var wallLeft:FlxBackdrop;
	var wallRight:FlxBackdrop;

	var xOffset:Float;

	public function new(left_asset:FlxGraphicAsset, right_asset:FlxGraphicAsset, depth:Float) {
		super();

		this.xOffset = Math.pow(depth, 1.5) * 25;
		this.scrollFactor.y = 1 - depth / 5;

		wallLeft = new FlxBackdrop(left_asset, Y);
		wallLeft.y = depth * 123;
		add(wallLeft);

		wallRight = new FlxBackdrop(right_asset, Y);
		wallRight.y = depth * 123;
		add(wallRight);
	}

	public function setCaveWidth(width:Float) {
		wallLeft.x = -width / 2 + 32 + xOffset;
		wallRight.x = width / 2 - 128 - xOffset;
	}
}
