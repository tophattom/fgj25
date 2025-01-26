package;

import GameData.LogEntry;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import haxe.Timer;

class LogEntryState extends FlxSubState {
	var bg:FlxSprite;
	var textString:String;
	var text:FlxBitmapText;
	var sound:Null<String>;
	var soundDelay:Null<Float>;
	var soundVolume:Null<Float>;

	public function new(logEntry:LogEntry) {
		super();
		this.textString = logEntry.text;
		this.sound = logEntry.sound;
		this.soundDelay = logEntry.soundDelay;
		this.soundVolume = logEntry.soundVolume;
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

		if (sound != null) {
			Timer.delay(() -> FlxG.sound.play(sound, soundVolume == null ? 1.0 : soundVolume), soundDelay == null ? 0 : Std.int(soundDelay));
		}
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (FlxG.keys.anyJustPressed(Util.DOWN_KEYS) || FlxG.mouse.justPressed) {
			close();
		}
	}
}
