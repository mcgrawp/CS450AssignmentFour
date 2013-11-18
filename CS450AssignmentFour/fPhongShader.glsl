#version 330 core

struct LightProperties {
		vec3 ambient;
		vec3 color;
		vec3 position;
		float spotCosCutoff;
		float spotExponent;
		float constantAttenuation;
		float linearAttenuation;
		float quadraticAttenuation;
};

uniform LightProperties Light;
uniform float Shininess;
uniform float Strength;
uniform vec3 EyeDirection;

out vec4 FragColor;

void main()
{
	vec3 scatteredLight = vec3(0.0);
	vec3 reflectedLight = vec3(0.0);

	if (!Lights[light].isEnabled)
			continue;

	vec3 halfVector;
	vec3 lightDirection = Light.position;
	float attenuation = 1.0;
	
	lightDirection = lightDirection - vec3(Position);
	float lightDistance = lightDirection / lightDistance;
	attenuation = 1.0 / (Light.constantAttenuation + Light.linearAttenuation * lightDistance + Light.quadraticAttenuation * lightDistance * lightDistance);
	halfVector = normalize(lightDirection + EyeDirection);

	float diffuse = max(0.0, dot(Normal, lightDirection));
	float specular - max(0.0, dot(Normal, halfVector));
		
	if (diffuse == 0.0)
		specular = 0.0;
	else
		specular = pow(specular, Shininess) * Strength;

	// Accumulate all the lights' effects
	scatteredLight += Light.ambient * attenuation + Light.color* diffuse * attenuation;

	reflectedLight += Lights.color * specular * attenuation;
	vec3 rgb = min(Color.rgb * scatteredLight + reflectedLight, vec3(1.0));
	FragColor = vec4(rgb, Color.a);

} // END main()
		