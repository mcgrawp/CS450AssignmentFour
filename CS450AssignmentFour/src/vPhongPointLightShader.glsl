#version 330 core

uniform mat4 MVPMatrix;
uniform mat4 MVMatrix;

uniform vec3 LightPosition;
uniform vec3 EyeDirection;

uniform float ConstantAttenuation;
uniform float LinearAttenuation;
uniform float QuadraticAttenuation;

// params for selection
// flag: 0 == normal, 1 == selection, 2 == absolute coloring (manipulators)
uniform int flag;
uniform int selectionColorR;
uniform int selectionColorG;
uniform int selectionColorB;
uniform int selectionColorA;

in vec4 VertexColor;
in vec3 VertexNormal;
in vec4 VertexPosition;

mat3 NormalMatrix;

out vec4 Position;
out vec4 Color;
out vec3 Normal;
out vec3 LightDirection;
out vec3 HalfVector;
out float Attenuation;

void main()
{
	Color = VertexColor;

	NormalMatrix = mat3(transpose(inverse(MVMatrix)));
	Normal = normalize(NormalMatrix * VertexNormal);

	LightDirection = LightPosition - vec3(VertexPosition);
	float lightDistance = length(LightDirection);

	LightDirection = LightDirection / lightDistance;

	Attenuation = 1.0 / (ConstantAttenuation + LinearAttenuation * lightDistance + QuadraticAttenuation * lightDistance * lightDistance);
	
	HalfVector = normalize(LightDirection + EyeDirection);
	
	Position = MVMatrix * VertexPosition;
}