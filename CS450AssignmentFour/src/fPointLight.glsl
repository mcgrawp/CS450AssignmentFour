#version 330 core

uniform vec3 Ambient;
uniform vec3 LightColor;
uniform vec3 LightPosition;
uniform float Shininess;
uniform float Strength;

uniform vec3 EyePosition;
uniform float ConstantAttenuation;
uniform float LinearAttenuation;
uniform float QuadraticAttenuation;

uniform int flag;

in vec4 Color;
in vec3 Normal;
in vec4 Position;

out vec4 FragColor;

void main()
{
	vec3 lightDirection = LightPosition - vec3(Position); // For som reason this must be inverted to how it is in the book. Something to do with how the light position is used.
	float lightDistance = length(lightDirection);
	lightDirection = lightDirection / lightDistance;
	
	vec3 eyeDirection = EyePosition - vec3(Position);
	float eyeDistance = length(eyeDirection);
	eyeDirection = eyeDirection / eyeDistance;

	float attenuation = 1.0 / (ConstantAttenuation + (LinearAttenuation * lightDistance) + (QuadraticAttenuation * lightDistance * lightDistance));

	vec3 halfVector = normalize(lightDirection + eyeDirection);

	float diffuse = max(0.0, dot(Normal, lightDirection));
	float specular = max(0.0, dot(Normal, halfVector));
	if(diffuse == 0.0) {
		specular = 0.0;
	} else {
		specular = pow(specular, Shininess) * Strength;
	}
	vec3 scatteredLight = Ambient + LightColor * diffuse * attenuation;
	vec3 reflectedLight = LightColor * specular * attenuation;

	vec3 rgb = min(Color.rgb * scatteredLight + reflectedLight, vec3(1.0));


	if(flag == 0) {
		FragColor = vec4(rgb, Color.a);
	} 
	else {
		FragColor = Color;
	}
}