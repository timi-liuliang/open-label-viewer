<?xml version="1.0" encoding="utf-8"?>
<res class="ShaderProgram" Type="glsl" VertexShader="#version 450&#10;&#10;// uniforms&#10;layout(binding = 0) uniform UBO&#10;{&#10;    mat4 u_WorldMatrix;&#10;    mat4 u_ViewProjMatrix;&#10;} vs_ubo;&#10;&#10;// inputs&#10;layout(location = 0) in vec3 a_Position;&#10;&#10;// outputs&#10;layout(location = 0) out vec3 v_Position;&#10;&#10;#ifdef HAS_NORMALS&#10;layout(location = 1) in vec3 a_Normal;&#10;layout(location = 1) out vec3 v_Normal;&#10;#endif&#10;&#10;void main(void)&#10;{&#10;    vec4 position = vec4(a_Position, 1.0);&#10;    position = vs_ubo.u_WorldMatrix * position;&#10;&#10;    gl_Position = vs_ubo.u_ViewProjMatrix * position;&#10;&#10;    v_Position  = position.xyz / position.w;&#10;&#10;#ifdef HAS_NORMALS&#10;	v_Normal = normalize(vec3(vs_ubo.u_WorldMatrix * vec4(a_Normal.xyz, 0.0)));&#10;#endif&#10;}&#10;" FragmentShader="#version 450&#10;&#10;// inputs&#10;layout(location = 0) in vec3  v_Position;&#10;&#10;#ifdef HAS_NORMALS&#10;layout(location = 1) in vec3 v_Normal;&#10;#endif&#10;&#10;// outputs&#10;layout(location = 0) out vec4 o_FragColor;&#10;&#10;// functions&#10;#define SRGB_FAST_APPROXIMATION&#10;&#10;vec3 SRgbToLinear(vec3 srgbIn)&#10;{&#10;#ifdef SRGB_FAST_APPROXIMATION&#10;    return pow(srgbIn,vec3(2.2));&#10;#else&#10;    return srgbIn;&#10;#endif&#10;}&#10;&#10;vec3 LinearToSRgb(vec3 linearIn)&#10;{&#10;#ifdef SRGB_FAST_APPROXIMATION&#10;    return pow(linearIn,vec3(1.0/2.2));&#10;#else&#10;    return srgbIn;&#10;#endif&#10;}&#10;&#10;void main(void)&#10;{&#10;	vec3 __BaseColor = SRgbToLinear(vec3(0.75));&#10;&#10;#ifdef HAS_NORMALS&#10;    vec3 _lightDir = normalize(vec3(1.0, 1.0, 1.0));&#10;    vec3 _lightColor = SRgbToLinear(vec3(1.2, 1.2, 1.2));&#10;    vec3 _AmbientColor = SRgbToLinear(vec3(0.4, 0.4, 0.4));&#10;    __BaseColor = max(dot(normalize(v_Normal), _lightDir), 0.0) * _lightColor * __BaseColor + _AmbientColor;&#10;#endif&#10;&#10;    o_FragColor = vec4(LinearToSRgb(__BaseColor.rgb), 1.0);&#10;}&#10;" Graph="" CullMode="CULL_BACK" BlendMode="Opaque">
	<property name="DepthStencilState">
		<obj class="DepthStencilState" DepthEnable="true" WriteDepth="true" />
	</property>
</res>