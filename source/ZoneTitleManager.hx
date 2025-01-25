package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;

class ZoneTitleManager extends FlxTypedSpriteContainer<FlxSprite> {
	var currentZone:Int = 0;

	public function new() {
		super();
		newTitle(0);
	}

	function newTitle(pixelY:Float) {
		var zoneTitle = ZoneTitle.create(pixelY + 72, GameData.Zones[currentZone].title);
		zoneTitle.screenCenter(X);
		zoneTitle.x = zoneTitle.x - Util.SCREEN_WIDTH / 2 + 64 / 2;
		zoneTitle.scale.set(2, 2);
		add(zoneTitle);
	}

	public function setDepth(depth:Float, pixelY:Float) {
		var zoneIndex = GameData.getZoneIndex(depth);
		if (zoneIndex != currentZone) {
			currentZone = zoneIndex;
			newTitle(pixelY);
		}
	}
}
