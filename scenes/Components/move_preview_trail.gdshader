shader_type canvas_item;

uniform vec4 color : source_color;

void fragment() {
	vec2 moving_uv = vec2(UV.x-(TIME*0.5), UV.y);
	vec4 in_tex = texture(TEXTURE, moving_uv);
	COLOR = in_tex*color;
}