#version 330 core

uniform mat4 Projection;
uniform mat4 ModelView;

// params for selection
// flag: 0 == normal, 1 == selection, 2 == absolute coloring (manipulators)
uniform int flag;
uniform int selectionColorR;
uniform int selectionColorG;
uniform int selectionColorB;
uniform int selectionColorA;

in vec4 VertexColor;
in vec4 VertexNormal;
in vec4 VertexPosition;

mat3 NormalMatrix;

out vec4 Color;
out vec3 Normal;
flat out int fFlag;

void main()
{
	NormalMatrix = mat3(transpose(inverse(ModelView)));
	Normal = vec3(normalize(NormalMatrix * VertexNormal.xyz));
	gl_Position = Projection * ModelView * VertexPosition;

	fFlag = flag;

	if(flag == 0) {
		Color = vec4(Normal, 1.);
	} 
	else if(flag == 1) {
		Color.r = float(selectionColorR)/float(255);
		Color.g = float(selectionColorG)/float(255);
		Color.b = float(selectionColorB)/float(255);
		Color.a = float(selectionColorA)/float(255);
	}
	else if(flag == 2) {
		Color = VertexColor;
	}
}