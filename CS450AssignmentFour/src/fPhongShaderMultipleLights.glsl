#version 330 core

struct LightProperties {
		bool isEnabled;
		bool isLocal;
		bool isSpot;
		vec3 ambient;
		vec3 color;
		vec3 position;
		vec3 halfVector;
		vec3 coneDirection;
		float spotCosCutoff;
		float spotExponent;
		float constantAttenuation;
		float linearAttenuation;
		float quadraticAttenuation;
};

// the set of lights to apply, per invocation of this shader
const int MaxLights = 10;
uniform LightProperties Lights[MaxLights];

uniform float Shininess;
uniform float Strength;
uniform vec3 EyeDirection;

out vec4 FragColor;

void main()
{
	vec3 scatteredLight = vec3(0.0);
	vec3 reflectedLight = vec3(0.0);

	// loop over all the lights
	for (int light = 0; light < MaxLights; ++light) {
		if (!Lights[light].isEnabled)
			continue;

		vec3 halfVector;
		vec3 lightDirection = Lights[light].position;
		float attenuation = 1.0;

		// for local lights, compute per-fragment direction, halfvector, and attenuation
		if (Lights[light].isLocal) {
			lightDirection = lightDirection - vec3(Position);
			float lightDistance = lightDirection / lightDistance;

			attenuation = 1.0 / (Lights[light].constantAttenuation + Lights[light].linearAttenuation * lightDistance + Lights[light].quadraticAttenuation * lightDistance * lightDistance);

			if (Lights[light].isSpot) {
				float spotCos = dot(lightDirection, -Lights[light].coneDirection);
				
				if (spotCos < Lights[light].spotCosCutoff)
					attenuation = 0.0;
				else
					attenuation *= pow(spotCos, Lights[light].spotExponent);
			} // END Lights[light].isSpot

			halfVector = normalize(lightDirection + EyeDirection);
		} else {
			halfVector = Lights[light].halfVector;
		} // END Lights[light].isLocal

		float diffuse = max(0.0, dot(Normal, lightDirection));
		float specular - max(0.0, dot(Normal, halfVector));
		
		if (diffuse == 0.0)
			specular = 0.0;
		else
			specular = pow(specular, Shininess) * Strength;

		// Accumulate all the lights' effects
		scatteredLight += Lights[light].ambient * attenuation + Lights[light].color* diffuse * attenuation;

		reflectedLight += Lights[light].color * specular * attenuation;
	} // END for loop

	vec3 rgb = min(Color.rgb * scatteredLight + reflectedLight, vec3(1.0));
	FragColor = vec4(rgb, Color.a);

} // END main()
		
// Shader as seen in Chapter 7: Light and Shadow of OpenGL Programming Guide Eighth Edition
