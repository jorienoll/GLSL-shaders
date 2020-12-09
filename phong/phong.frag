// Phong Fragment Shader

// input v and N from vertex shader output
varying vec3 N;
varying vec3 v;

void main (void){ 

	// calculate light diffusion
	vec3 light = normalize(gl_LightSource[0].position.xyz - v); 
	vec3 view = normalize(-v); 
	vec3 normal = normalize(N); 

	// calculate ambience
	vec4 ambient = gl_FrontLightProduct[0].ambient;
	vec4 global = gl_FrontMaterial.ambient * gl_LightModel.ambient;

	// get vector to light
	vec4 diffuse = gl_FrontLightProduct[0].diffuse * max(dot(N, light), 0.0);
	diffuse = clamp(diffuse, 0.0, 1.0);

	// Phong specular calculation
	vec3 reflectDir = reflect(-light, normal);
	float spec = pow(max(dot(view, reflectDir), 0.0), gl_FrontMaterial.shininess * 0.1);

	vec4 specular = gl_FrontLightProduct[0].specular * spec;
	specular = clamp(specular, 0.0, 1.0);

	// do calculations on every fragment
	gl_FragColor = global + ambient + diffuse + specular;
}
