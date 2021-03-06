#version 400

uniform mat4 u_mvp;
uniform mat4 u_skin[30];

layout(location = 0) in vec3 in_vertex;
layout(location = 1) in vec3 in_normal;
layout(location = 2) in vec3 in_color;
layout(location = 4) in uvec4 in_joints;
layout(location = 5) in vec4 in_weights;

out vec3 o_normal;
out vec3 o_color;

void main(void)
{
	vec3 skin_vert;
	for (int i = 0; i < 4; ++i)
	{
		vec4 temp = vec4(in_vertex, 1.0) * u_skin[in_joints[i]];
		skin_vert += temp.xyz * vec3(in_weights[i], in_weights[i], in_weights[i]);
	}
	
	gl_Position = vec4(skin_vert, 1.0) * u_mvp;
	o_normal = in_normal;
	o_color = in_color;
}