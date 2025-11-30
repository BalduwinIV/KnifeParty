shader_type canvas_item;

// --- Configurable Properties ---
uniform sampler2D grain_texture : filter_nearest, repeat_enable; // The noise image
uniform float grain_strength : hint_range(0.0, 1.0) = 0.3;       // How dirty it looks
uniform float jitter_amount : hint_range(0.0, 5.0) = 0.5;        // How much it shakes
uniform float jitter_speed : hint_range(0.0, 20.0) = 10.0;       // How fast it shakes
uniform vec4 tint_color : source_color = vec4(0.4, 0.3, 0.2, 1.0); // Rusty/Industrial tint

// --- Vertex Shader (Shape Instability) ---
void vertex() {
	// Calculate a random-looking offset based on Time
	float time_step = TIME * jitter_speed;
	vec2 shake = vec2(sin(time_step), cos(time_step * 0.8));
	
	// Apply the shake to the vertices
	VERTEX += shake * jitter_amount;
}

// --- Fragment Shader (Texture and Color) ---
void fragment() {
	// 1. Get the base color of your Polygon2D
	vec4 input_color = COLOR;
	
	// 2. Sample the noise texture
	// We use UV * vector to scale the noise so it's not huge
	vec4 noise = texture(grain_texture, UV * 3.0);
	
	// 3. Blend the Noise: Multiply mode makes it look like dirt
	vec4 gritty_color = input_color * mix(vec4(1.0), noise, grain_strength);
	
	// 4. Apply the Industrial Tint (mix original with rust color)
	// This desaturates the object slightly and unifies the palette
	vec4 final_color = mix(gritty_color, tint_color * gritty_color, 0.3);
	
	// Maintain the original alpha of the polygon
	final_color.a = input_color.a;
	
	COLOR = final_color;
}