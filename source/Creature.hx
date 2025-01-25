package;

import flixel.FlxSprite;
import flixel.math.FlxPoint;

enum Dir {
	LEFT;
	RIGHT;
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
}
