import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class SplashState extends FlxState {
	static inline var MAX_SCALE = 1.1;

	var started = false;

	override function create() {
		super.create();

		// var bg = new FlxSprite(0, 0, AssetPaths.menu_bg__png);
		// bg.screenCenter();
		// add(bg);

		var title = new FlxText(0, 16, 0, 'BENTHIC');
		title.setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		title.screenCenter(X);
		add(title);

		var credits = new FlxText(0, 42, 200, 'Credits:\nJaakko Rinta-Filppula: Dev\nMika Kuitunen: Graphics & Dev\nKonsta Leinonen: Graphics & Music');
		credits.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		credits.screenCenter(X);
		add(credits);

		var continueText = new FlxText(0, 144, 0, "Press any key to continue...");
		continueText.setFormat(null, 8, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		continueText.screenCenter(X);
		add(continueText);

		FlxTween.tween(continueText, { "scale.x": MAX_SCALE, "scale.y": MAX_SCALE }, 1, { type: PINGPONG, ease: FlxEase.sineInOut });
	}

	override function update(elapsed:Float) {
		if (started) {
			return;
		}

		if (FlxG.keys.firstJustPressed() != -1 || FlxG.mouse.justPressed) {
			start();
		}
		super.update(elapsed);
	}

	function start() {
		started = true;
		Util.cameraFadeOut(Util.FADE_DURATION, () -> {
			FlxG.switchState(new PlayState());
		});
	}
}
