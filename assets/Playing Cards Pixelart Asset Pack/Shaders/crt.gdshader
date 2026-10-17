shader_type canvas_item;

uniform sampler2D screen_tex : hint_screen_texture, filter_linear_mipmap;

uniform float scanline_count : hint_range(50.0, 800.0) = 160.0;
uniform float scanline_intensity : hint_range(0.0, 1.0) = 0.25;
uniform float vignette_intensity : hint_range(0.0, 1.0) = 0.25;
// Faixa clara que desce pela tela (0 = desligada)
uniform float roll_speed : hint_range(0.0, 1.0) = 0.0;
uniform float roll_intensity : hint_range(0.0, 0.3) = 0.05;

void fragment() {
	vec4 col = texture(screen_tex, SCREEN_UV);

	// linhas horizontais
	float line = sin(SCREEN_UV.y * scanline_count * PI * 2.0) * 0.5 + 0.5;
	col.rgb *= 1.0 - line * scanline_intensity;

	// escurecimento nas bordas
	vec2 uv = SCREEN_UV * 2.0 - 1.0;
	col.rgb *= 1.0 - dot(uv, uv) * vignette_intensity * 0.5;

	// faixa que rola (opcional)
	float band = pow(1.0 - fract(SCREEN_UV.y - TIME * roll_speed), 8.0);
	col.rgb += band * roll_intensity;

	COLOR = col;
}