package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;

class CreatureLayer extends FlxTypedSpriteContainer<FlxSprite> {
	var depth:Float;

	public function new(depth:Float) {
		super();

		this.depth = depth;
		this.scrollFactor.y = 1 - depth / 5;
	}

	public function getScale():Float {
		return 1 - this.depth / 4;
	}
}
