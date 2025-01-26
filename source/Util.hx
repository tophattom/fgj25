package;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxColor;

class Util {
	public static inline var SCREEN_WIDTH = 320;
	public static inline var SCREEN_HEIGHT = 180;

	public static inline var FADE_DURATION = 0.33;

	public static var DOWN_KEYS = [S, DOWN];

	// Random integer between 0 (inclusive) and max (exclusive)
	public static function randomInt(max:Int):Int {
		return Math.floor(max * Math.random());
	}

	public static function randomBetween(min:Float, max:Float):Float {
		return min + Math.random() * (max - min);
	}

	public static function randomChoice<T>(arr:Array<T>):T {
		return arr[randomInt(arr.length)];
	}

	public static function randomBool():Bool {
		return Math.random() < 0.5;
	}

	public static function cameraFadeOut(duration:Float = FADE_DURATION, ?onComplete:() -> Void = null) {
		FlxG.camera.fade(FlxColor.BLACK, duration, false, onComplete);
	}

	public static function cameraFadeIn(duration:Float = FADE_DURATION) {
		FlxG.camera.fade(FlxColor.BLACK, duration, true);
	}
}
