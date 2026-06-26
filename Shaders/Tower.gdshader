shader_type canvas_item;
render_mode unshaded;

void fragment() {
    // Snap UVs to the pixel grid
    vec2 pixel_size = 1.0 / TEXTURE_PIXEL_SIZE;
    vec2 snapped_uv = floor(UV * pixel_size) / pixel_size;
    
    COLOR = texture(TEXTURE, snapped_uv);
}