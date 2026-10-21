shader_type canvas_item;

uniform vec4 line_color : source_color = vec4(0.0, 0.0, 0.0, 0.15);
uniform float line_spacing : hint_range(1.0, 10.0) = 4.0;

void fragment() {
    // Cria uma linha horizontal baseada na coordenada Y da tela
    if (mod(FRAGCOORD.y, line_spacing) < 1.0) {
        COLOR = line_color;
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0);
    }
}