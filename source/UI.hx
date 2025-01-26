package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;
import flixel.sound.FlxSound;

class UI extends FlxTypedSpriteContainer<FlxSprite> {
	var bg:FlxSprite;
	var o2:FlxSprite;
	var depthGauge:DepthGauge;
	var alarmSound:FlxSound;

	public function new() {
		super();
		this.scrollFactor.set(0, 0);

		bg = new FlxSprite(0, 0);
		bg.loadGraphic(AssetPaths.ui__png);

		o2 = new FlxSprite(46, 141);
		o2.loadGraphic(AssetPaths.o2_alarm__png, true, 16, 16);
		o2.animation.add('idle', [0], 0);
		o2.animation.add('alarm', [0, 1], 2);
		o2.animation.play('idle');

		depthGauge = new DepthGauge(7, 162, 0);

		add(bg);
		add(o2);
		add(depthGauge);

		alarmSound = FlxG.sound.load(AssetPaths.alarmloop__mp3, 1.0, true);
	}

	public function setO2Alarm(alarm:Bool) {
		if (alarm) {
			o2.animation.play('alarm');
			alarmSound.play();
		} else {
			o2.animation.play('idle');
			alarmSound.stop();
		}
	}

	public function setDepth(depth:Float) {
		depthGauge.set(Std.int(depth));
	}
}
