import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;

enum MenuVariant {
	START;
	GAME_OVER;
	GAME_WIN;
}

class MenuState extends FlxState {
	var started = false;
	var variant:MenuVariant;

	public function new(variantChoice:MenuVariant) {
		super();

		variant = variantChoice;
	}

	override function create() {
		super.create();

		FlxG.mouse.useSystemCursor = true;

		var bg = new FlxSprite(0, 0);

		var button = new FlxButton(240 - 8, 160 - 8, "Start", () -> {
			if (started) {
				return;
			}

			start();
		});

		switch (variant) {
			case START:
				bg.loadGraphic(AssetPaths.desktop1__png);
			case GAME_OVER:
				bg.loadGraphic(AssetPaths.desktop2__png);
				button.text = "Play Again";
			case GAME_WIN:
				bg.loadGraphic(AssetPaths.desktop3__png);
				button.text = "Play Again";
		}

		bg.screenCenter();
		add(bg);
		add(button);

		Util.cameraFadeIn(1.0);
	}

	function start() {
		started = true;
		Util.cameraFadeOut(Util.FADE_DURATION, () -> {
			FlxG.switchState(new PlayState());
		});
	}
}
