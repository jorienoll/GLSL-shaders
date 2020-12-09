// Custom Vertex Shader

// utilities for color change
uniform float time;
vec3 colorA = vec3(0.149,0.141,0.912);
vec3 colorB = vec3(1.000,0.833,0.224);

void main(){

	// mixes colors using a sin wave with values 0-1
	vec3 color = vec3(0.0);
	float pct = abs(sin(time));
	color = mix(colorA, colorB, pct);

	// light diffusions
	vec3 v, light, normal;	

 	// calculate ambience
	vec4 ambient = gl_FrontMaterial.ambient * gl_LightSource[0].ambient;
	vec4 global = gl_FrontMaterial.ambient * gl_LightModel.ambient;

	 // transform coords
	v = vec3(gl_Vertex * gl_ModelViewMatrix);

	// transform normal and normalize
	normal = normalize(gl_Normal * gl_NormalMatrix);

	// get vector to light
	light = normalize(gl_LightSource[0].position.xyz - v);
	float dotL = max(dot(normal, light), 0.0);
	vec4 diffuse = gl_FrontMaterial.diffuse * dotL * gl_LightSource[0].diffuse;
	vec4 specular = vec4(0.0,0.0,0.0,1.0);
	vec3 view = normalize(-v);
	vec3 H = normalize(view + light);

	// check if NdotL is greater than 0
	if (dotL > 0.0){
		float dotHV = max(dot(normal, H),0.0);
		specular = gl_LightSource[0].specular * pow(dotHV,gl_FrontMaterial.shininess) * gl_FrontMaterial.specular;
	}

	// uses color and light diffusions to create an oscilating color object with illumination and shading
	gl_FrontColor = vec4(color, 1.0) + diffuse + specular + global + ambient;
	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
}
