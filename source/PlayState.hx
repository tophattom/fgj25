package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.system.scaleModes.PixelPerfectScaleMode;
import flixel.util.FlxColor;

class PlayState extends FlxState {
	override public function create() {
		super.create();

		FlxG.scaleMode = new PixelPerfectScaleMode();
		bgColor = FlxColor.fromRGB(20, 20, 40);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
