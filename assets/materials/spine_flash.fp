varying mediump vec2 var_texcoord0;
varying lowp vec4 var_color;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 tint;
uniform lowp vec4 flash;
void main()
{
    // Pre-multiply alpha since var_color and all runtime textures already are
    lowp vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
    lowp vec4 color_pm = var_color * tint_pm;
    vec4 color = texture2D(DIFFUSE_TEXTURE, var_texcoord0.xy)*color_pm;
    gl_FragColor.rgb = (vec3(1.0) * flash.x + color.rgb * (1.0 - flash.x))*color.a;
    gl_FragColor.a   = color.a;
}
