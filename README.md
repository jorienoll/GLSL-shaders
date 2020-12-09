# GLSL-shaders

This program helped me to learn the empirical illumination model and the OpenGL Shading Language (GLSL).

First, I wrote a vertex and fragment shader that implemented the Gouraud shading method. I did this by applying the illumination model on a subset of surface points, and then interpolating the intensity of the remaining points on the surface.

Next, I wrote a vertex and fragment shader that implemented the Phong shading method. I did this by applying the illumination model to every point, on a surface normal that is linearly interpolated across polygonal facets.

Next, I modified my Phong shader to compute the specular component with the Blinn variation. I did this by altering the illumination model to compute the specular using halfway vector H, which is multiplied by N to optimize the shininess effect. The closer the halfway vector aligns with the normal vector, the higher the specular (and higher the shininess). This creates an effect in which the specular highlight changes as the viewing angle changes. The Blinn-Phong specular component is sharper and shinier in comparison with Phong.

Finally, I designed my own custom shader for a unique rendering effect. I modified my Gouraud code to create a shader that uses Gouraud shading, however the color of the object is constantly oscillating colors; the subject will change colors and simultaneously follow the rules of the illumination model (highlights, shadows, shininess, etc.). The color oscillates by mixing two colors using a sin wave to create variation.
