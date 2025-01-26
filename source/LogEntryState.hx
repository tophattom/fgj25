package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxBitmapFont;
import flixel.text.FlxBitmapText;

class LogEntryState extends FlxSubState {
	var bg:FlxSprite;
	var textString:String;
	var text:FlxBitmapText;

	public function new(textString:String) {
		super();
		this.textString = textString;
	}

	override function create() {
		super.create();

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

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (FlxG.keys.anyJustPressed(Util.DOWN_KEYS) || FlxG.mouse.justPressed) {
			close();
		}
	}
}
