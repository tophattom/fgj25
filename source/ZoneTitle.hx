package;

import flixel.text.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText.FlxTextAlign;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import haxe.Timer;

class ZoneTitle extends FlxBitmapText {
	public static inline var FADE_DELAY = 1000;
	public static inline var FADE_DURATION = 2000 / 1000;

	public function new(bellY:Float, text:String, autoFade:Bool = true) {
		var bmFont = FlxBitmapFont.fromAngelCode(AssetPaths.notjamuicondensed19__png, AssetPaths.notjamuicondensed19__fnt);
		super(0, bellY + 80, text, bmFont);
		this.color = 0xe9dfda;
		this.alignment = FlxTextAlign.CENTER;
		this.background = true;
		this.backgroundColor = 0xFF0000;
		trace(this.x, this.y);

		if (autoFade) {
			Timer.delay(fadeOut, FADE_DELAY);
		}
	}

	public function fadeOut() {
		FlxTween.tween(this, { alpha: 0 }, FADE_DURATION, {
			ease: FlxEase.quadInOut,
			onComplete: (_) -> {
				this.destroy();
			}
		});
	}
}
