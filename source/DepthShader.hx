package;

import flixel.system.FlxAssets.FlxShader;

class DepthShader extends FlxShader {
	@:glFragmentSource('
    #pragma header

    #define MAX_DEPTH 100.0

    uniform float depth;

    float easeInCubic(float x) {
      return x * x * x;
    }

    float easeInExpo(float x) {
      if (x == 0.0) {
        return 0.0;
      }

      return pow(2.0, 10.0 * x - 10.0);
    }

    void main()
    {
        vec2 st = openfl_TextureCoordv.xy;  // Note, already normalized

        vec4 color = flixel_texture2D(bitmap, st);
        float normalizedDepth = depth / MAX_DEPTH;
        float d = 1.0 - easeInExpo(normalizedDepth);
        gl_FragColor = color * vec4(0.8, 0.9, 1.0, 1) * d;
    }
    ')
	public function new() {
		super();

		depth.value = [0.0];
	}

	public function update(elapsed:Float) {}

	public function setDepth(d:Float) {
		depth.value[0] = d;
	}
}
