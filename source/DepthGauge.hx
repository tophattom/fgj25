package;

import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;

class DepthGauge extends FlxTypedSpriteContainer<NumberDisplay> {
	var thousands:NumberDisplay;
	var hundreds:NumberDisplay;
	var tens:NumberDisplay;
	var ones:NumberDisplay;

	public function new(x:Float, y:Float, number:Int) {
		super(x, y);

		thousands = new NumberDisplay(0, 0, 0);
		hundreds = new NumberDisplay(7, 0, 0);
		tens = new NumberDisplay(14, 0, 0);
		ones = new NumberDisplay(21, 0, 0);

		add(thousands);
		add(hundreds);
		add(tens);
		add(ones);
	}

	public function set(number:Int) {
		var safeNumber = Math.max(Math.min(number, 9999), 0);
		thousands.set(Std.int(safeNumber / 1000));
		hundreds.set(Std.int((safeNumber % 1000) / 100));
		tens.set(Std.int((safeNumber % 100) / 10));
		ones.set(Std.int(safeNumber % 10));
	}
}
