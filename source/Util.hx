package;

class Util {
	public static inline var SCREEN_WIDTH = 320;
	public static inline var SCREEN_HEIGHT = 180;

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
}
