shader_type canvas_item;

uniform bool active = false;
uniform vec3 flash_color: source_color = vec3(1.0);

void fragment() {
	if (active) {
		vec4 color = texture(TEXTURE, UV);
		COLOR = vec4(flash_color, color.a);
	}
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
