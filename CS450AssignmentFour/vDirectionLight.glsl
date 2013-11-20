#version 330 core

uniform mat4 MVPMatrix;
uniform mat4 MVMatrix;

in vec4 VertexColor;
in vec3 VertexNormal;
in vec4 VertexPosition;

mat3 NormalMatrix;

out vec4 Color;
out vec3 Normal;

void main()
{
	Color = VertexColor;
	NormalMatrix = mat3(transpose(inverse(MVMatrix)));
	Normal = normalize(NormalMatrix * VertexNormal);
	gl_Position = MVPMatrix * VertexPosition;
}