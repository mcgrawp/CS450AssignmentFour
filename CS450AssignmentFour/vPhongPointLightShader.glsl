#version 330 core

uniform mat4 MVPMatrix;
uniform mat3 NormalMatrix;

uniform vec3 LightPosition;
uniform vec3 EyeDirection;
uniform float ConstantAttenuation;
uniform float LinearAttenuation;
uniform float QuadraticAttenuation;

in vec4 VertexColor;
in vec3 VertexNormal;
in vec4 VertexPosition;

out vec4 Position;
out vec4 Color;
out vec3 Normal;
out vec3 LightDirection;
out vec3 HalfVector;
out float Attenuation;

void main()
{
	Color = VertexColor;
	Normal = normalize(NormalMatrix * VertexNormal);

	LightDirection = LightPosition - vec3(VertexPosition);
	float lightDistance = length(LightDirection);

	LightDirection = LightDirection / lightDistance;

	Attenuation = 1.0 / (ConstantAttenuation + LinearAttenuation * lightDistance + QuadraticAttenuation * lightDistance * lightDistance);
	Position = MVMatrix * VertexPosition;
}