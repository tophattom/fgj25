package;

import flixel.FlxSprite;
import flixel.text.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import haxe.Timer;

class ZoneTitle {
	public static inline var FADE_DELAY = 4000;
	public static inline var FADE_DURATION = 4000 / 1000;

	public static function create(y:Float, text:String, autoFade:Bool = true):FlxSprite {
		var bmFont = FlxBitmapFont.fromAngelCode(AssetPaths.notjamuicondensed19__png, AssetPaths.notjamuicondensed19__fnt);
		var textObj = new FlxBitmapText(0, 0, text, bmFont);
		textObj.color = Colors.TEXT_COLOR;
		textObj.borderStyle = OUTLINE;
		textObj.drawFrame(true);

		var sprite = new FlxSprite(0, y);
		sprite.loadGraphic(textObj.framePixels);

		if (autoFade) {
			Timer.delay(() -> {
				FlxTween.tween(sprite, { alpha: 0 }, FADE_DURATION, {
					ease: FlxEase.quadInOut,
					onComplete: (_) -> {
						sprite.destroy();
					}
				});
			}, FADE_DELAY);
		}

		return sprite;
	}
}
