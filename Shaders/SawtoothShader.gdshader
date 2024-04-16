shader_type canvas_item;
render_mode blend_premul_alpha;

uniform float saw_period = 2.;

void fragment() {
	float x = UV.x / saw_period;
	float y = UV.y * 1.4 - .2;
	float saw = 2. * (x - floor(x + .5));
	saw *= sign(saw);
	saw = smoothstep(.8, 1., 1.0 - distance(saw, y));
	COLOR = vec4(2. * COLOR.rgb * saw, 2. * saw);
}