// Phong Vertex Shader

// send v and N output to fragment shader
varying vec3 N;
varying vec3 v;

void main(){

	// send point and normal to fragment shader to be interpolated
	v = vec3(gl_ModelViewMatrix * gl_Vertex);
	N = normalize(gl_NormalMatrix * gl_Normal);

	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
}
