package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;
import flixel.sound.FlxSound;
import haxe.Timer;

class ZoneTitleManager extends FlxTypedSpriteContainer<FlxSprite> {
	var currentZone:Int = 0;

	var sound:FlxSound;

	public function new() {
		super();

		sound = FlxG.sound.load(AssetPaths.newzone__ogg);
		sound.volume = 10;

		newTitle(0);
	}

	function newTitle(pixelY:Float) {
		var zoneTitle = ZoneTitle.create(pixelY + 96, GameData.Zones[currentZone].title);
		zoneTitle.screenCenter(X);
		zoneTitle.x = zoneTitle.x - Util.SCREEN_WIDTH / 2 + 64 / 2;
		zoneTitle.scale.set(2, 2);

		sound.play(true);
		Timer.delay(() -> add(zoneTitle), 2200);
	}

	public function setDepth(depth:Float, pixelY:Float) {
		var zoneIndex = GameData.getZoneIndex(depth);
		if (zoneIndex != currentZone) {
			currentZone = zoneIndex;
			newTitle(pixelY);
		}
	}
}
