shader_type canvas_item;

uniform vec4 color;

void fragment() {
	COLOR = color;
}

void _draw(){
	draw_texture(texture, Vector2(0,0));
}
