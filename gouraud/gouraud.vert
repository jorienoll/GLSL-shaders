// Gouraud Vertex Shader

void main(){

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

	gl_FrontColor = gl_FrontMaterial.emission + diffuse + specular + global + ambient;
	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
}
