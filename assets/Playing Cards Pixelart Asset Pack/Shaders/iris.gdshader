shader_type canvas_item;

uniform float radius = 2.5;              // 2.5 = tela livre, negativo = tela coberta
uniform vec2 center = vec2(0.5, 0.5);    // centro do círculo (0 a 1)
uniform float softness = 0.15;           // suavidade da borda
uniform vec4 color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
	float aspect = SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x; // corrige para o círculo não virar elipse
	vec2 d = (SCREEN_UV - center) * vec2(aspect, 1.0);
	float a = smoothstep(radius, radius + softness, length(d));
	COLOR = vec4(color.rgb, a * color.a);
}