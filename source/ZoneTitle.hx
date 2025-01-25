package;

import flixel.text.FlxBitmapFont;
import flixel.text.FlxBitmapText;

class ZoneTitle extends FlxBitmapText {
	// static var bmFont = FlxBitmapFont.fromAngelCode(AssetPaths.font__png, AssetPaths.font__fnt);
	public function new(x:Float, y:Float, text:String, autoFade:Bool = true) {
		// super(x, y, text, bmFont);
		super();
	}

	public function fadeOut() {
		// flixel.FlxG.tweener.tween(this, { alpha: 0 }, 1, { onComplete: function() { this.kill(); } });
	}
}
