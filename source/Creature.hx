package;

import flixel.FlxSprite;
import flixel.math.FlxPoint;

enum Dir {
	LEFT;
	RIGHT;
}

typedef CreatureType = {
	var sprite:FlxSprite;
	var speed_min:Float;
	var speed_max:Float;
	var min_depth:Float;
	var max_depth:Float;
	var probability:Float;
	var alpha:Float;
}

class Creature extends FlxSprite {
	public function new(x:Float, y:Float, vel:FlxPoint, dir:Dir) {
		super(x, y);

		this.velocity = vel;

		if (dir == LEFT) {
			this.flipX = true;
			this.velocity.x *= -1;
		}
	}

	public static function getCreatureTypes():Array<CreatureType> {
		var medusa = new FlxSprite();
		medusa.loadGraphic(AssetPaths.medusa__png, true, 56, 92);
		medusa.animation.add('swim', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 5);
		medusa.animation.play('swim');

		var perch = new FlxSprite();
		perch.loadGraphic(AssetPaths.ahven__png, true, 32, 32);
		perch.animation.add('swim', [0, 1, 2, 3, 4, 5, 6], 5);
		perch.animation.play('swim');

		var swordfish = new FlxSprite();
		swordfish.loadGraphic(AssetPaths.swordfish__png, true, 64, 64);
		swordfish.animation.add('swim', [0, 1, 2, 3, 4, 5], 5);
		swordfish.animation.play('swim');

		var whale = new FlxSprite();
		whale.loadGraphic(AssetPaths.whale__png, true, 192, 128);
		whale.animation.add('swim', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 5);
		whale.animation.play('swim');

		var translucent = new FlxSprite();
		translucent.loadGraphic(AssetPaths.translucentboi__png, true, 64, 64);
		translucent.animation.add('swim', [0, 1, 2, 3, 4], 5);
		translucent.animation.play('swim');

		var leviathan = new FlxSprite();
		leviathan.loadGraphic(AssetPaths.leviathan__png, true, 270, 200);
		leviathan.animation.add('swim', [0, 1, 2, 3, 4, 5, 6, 7], 5);
		leviathan.animation.play('swim');

		return [
			{
				sprite: medusa,
				speed_min: 7,
				speed_max: 12,
				min_depth: 0,
				max_depth: 3000,
				probability: 0.5,
				alpha: 0.85,
			},
			{
				sprite: perch,
				speed_min: 10,
				speed_max: 20,
				min_depth: 0,
				max_depth: 1000,
				probability: 1.0,
				alpha: 1.0,
			},
			{
				sprite: swordfish,
				speed_min: 15,
				speed_max: 20,
				min_depth: 0,
				max_depth: 1500,
				probability: 0.7,
				alpha: 1.0,
			},
			{
				sprite: whale,
				speed_min: 5,
				speed_max: 8,
				min_depth: 500,
				max_depth: 4000,
				probability: 0.3,
				alpha: 1.0,
			},
			{
				sprite: translucent,
				speed_min: 10,
				speed_max: 15,
				min_depth: 2000,
				max_depth: 6000,
				probability: 0.6,
				alpha: 0.9,
			},
			{
				sprite: leviathan,
				speed_min: 3,
				speed_max: 5,
				min_depth: 0,
				max_depth: 6000,
				probability: 0.3,
				alpha: 1.0,
			}
		];
	}
}
