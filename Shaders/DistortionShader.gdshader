shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, repeat_disable, filter_linear_mipmap;
uniform sampler2D distortionTexture;
uniform float strength : hint_range(0.0, 0.1, 0.01) = 0.05;

void fragment(){
	vec2 distortedUV = SCREEN_UV + texture(distortionTexture, UV).r * strength;
	vec4 screenColor = texture(SCREEN_TEXTURE, distortedUV);
	COLOR = screenColor;
}