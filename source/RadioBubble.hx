package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;
import flixel.text.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText;

class RadioBubble extends FlxTypedSpriteContainer<FlxSprite> {
	var bubble:FlxSprite;
	var bubbleSmall:FlxSprite;
	var text:FlxText;

	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
		bubble = new FlxSprite();
		bubble.loadGraphic(AssetPaths.radiobubble__png, false);

		bubbleSmall = new FlxSprite();
		bubbleSmall.loadGraphic(AssetPaths.radiobubblesmall__png, false);

		// var bmFont = FlxBitmapFont.fromAngelCode(AssetPaths.notjamchunkysans6__png, AssetPaths.notjamchunkysans6__fnt);
		text = new FlxText(8, 8);
		text.color = Colors.TEXT_COLOR_DARK;

		add(bubble);
		add(bubbleSmall);
		add(text);

		bubble.alpha = 0;
		bubbleSmall.alpha = 0;
		text.alpha = 0;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		if (FlxG.keys.firstJustPressed() != -1) {
			bubble.alpha = 0;
			bubbleSmall.alpha = 0;
			text.alpha = 0;
		}
	}

	public function show(depth:Float) {
		var zone = GameData.getZone(depth);
		var radioResponse = zone.radioResponse;

		if (radioResponse == "") {
			bubble.alpha = 0;
			bubbleSmall.alpha = 1;
			text.alpha = 0;
		} else {
			text.text = zone.radioResponse;
			bubble.alpha = 1;
			bubbleSmall.alpha = 0;
			text.alpha = 1;
		}

		visible = true;
	}
}
