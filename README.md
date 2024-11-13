# Raytracing
Just following the "Raytracing in One Weekend" series in Rust.

This is a learning based project.

### How raytracing works
In simple terms:
- **Camera and Rays**: For each pixel in the image, a ray is cast from the camera into the scene.
- **Intersection Tests**: The ray is tested for intersection with objects in the scene(like spheres, planes, etc).
- **Shading**: If the ray hits an object, calculations are performed to determine the color of the point of intersection based on lighting, material properties, or any arbitrary selection of reasons.
- **Background**: If the ray doesn't hit any object, a background color is assigned.
