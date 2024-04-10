shader_type canvas_item;

uniform vec4 replaceColor : source_color;
uniform vec4 replacedColor : source_color;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	if (distance(COLOR, replaceColor) < 0.1) {
		col = replacedColor;
	}
	COLOR = col;
}
