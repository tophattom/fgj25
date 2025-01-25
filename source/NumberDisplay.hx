package;

import flixel.FlxSprite;

class NumberDisplay extends FlxSprite {
	public function new(x:Float, y:Float, number:Int) {
		super(x, y);

		loadGraphic(AssetPaths.number__png, true, 6, 11);
		animation.add('0', [0], 0);
		animation.add('1', [1], 0);
		animation.add('2', [2], 0);
		animation.add('3', [3], 0);
		animation.add('4', [4], 0);
		animation.add('5', [5], 0);
		animation.add('6', [6], 0);
		animation.add('7', [7], 0);
		animation.add('8', [8], 0);
		animation.add('9', [9], 0);
		animation.play(Std.string(number));
	}

	public function set(number:Int) {
		animation.play(Std.string(number));
	}
}
