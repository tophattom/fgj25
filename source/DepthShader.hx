package;

import flixel.system.FlxAssets.FlxShader;

class DepthShader extends FlxShader {
	@:glFragmentSource('
    #pragma header

    #define MAX_DEPTH 8740.0

    uniform float depth;

    float easeInQuad(float x) {
      return x * x;
    }

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

        float r = 1.0 - easeInQuad(normalizedDepth);
        float g = 1.0 - easeInCubic(normalizedDepth);
        float b = 1.0 - easeInExpo(normalizedDepth);

        gl_FragColor = color * vec4(0.8 * r, 0.9 * g, 1.0 * b, color.a);
    }
    ')
	public function new(d:Float = 0.0) {
		super();

		depth.value = [d];
	}

	public function update(elapsed:Float) {}

	public function setDepth(d:Float) {
		depth.value[0] = d;
	}
}
