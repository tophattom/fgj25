package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;

class CreatureLayer extends FlxTypedSpriteContainer<FlxSprite> {
	var depth:Float;

	var depthShader:DepthShader;

	public function new(depth:Float) {
		super();

		this.depth = depth;
		this.scrollFactor.y = 1 - depth / 5;

		this.depthShader = new DepthShader(depth * 350);
	}

	override function add(Sprite:FlxSprite):FlxSprite {
		var scale = 1 - this.depth / 4;
		Sprite.scale.set(scale, scale);
		Sprite.shader = this.depthShader;

		return super.add(Sprite);
	}
}
