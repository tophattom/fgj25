package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;
import flixel.text.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText;

class LogEntry extends FlxTypedSpriteContainer<FlxSprite> {
	var bg:FlxSprite;
	var text:FlxBitmapText;

	public function new(textString:String) {
		super();
		this.scrollFactor.set(0, 0);

		var bmFont = FlxBitmapFont.fromAngelCode(AssetPaths.notjamoldstyle11__png, AssetPaths.notjamoldstyle11__fnt);
		text = new FlxBitmapText(0, 24, textString);
		text.color = Colors.TEXT_COLOR_DARK;
		text.fieldWidth = 160;
		text.wrap = WORD(LINE_WIDTH);
		text.screenCenter(X);

		bg = new FlxSprite(0, 0);
		bg.loadGraphic(AssetPaths.log_bg__png);

		add(bg);
		add(text);
	}
}
