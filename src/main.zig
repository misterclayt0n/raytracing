const std = @import("std");
const Vec3 = @import("vec3.zig").Vec3;
const vec_lib = @import("vec3.zig");
const Color = @import("color.zig").Color;
const color_lib = @import("color.zig");
const ray_lib = @import("ray.zig");

fn color_ray(ray: ray_lib.Ray) Color {
    const unit_direction = Vec3.unit_vector(ray.dir);
    const a: f64 = 0.5*(unit_direction.e[1] + 1.0);
    return Color.init(1.0, 1.0, 1.0).mult_scalar(1.0 - a).add(
        Color.init(0.5, 0.7, 1.0).mult_scalar(a)
    );
}

pub fn main() !void {
    // Image.
    const aspect_ratio: f64 = 16.0 / 9.0;
    const image_width: f64 = 400;

    // Calculate the image height, and ensure that it's at least 1.
    var image_height: f64 = image_width / aspect_ratio;
    if (image_height < 1.0) {
        image_height = 1.0;
    }

    // Camera.
    const focal_length: f64 = 1.0;
    const viewport_height: f64 = 2.0;
    const viewport_width: f64 = viewport_height * (image_width / image_height);
    const camera_center = vec_lib.Point3.zero();

    // Calculate the vectors acrross the horizontal and down the vertical viewport edges.
    const viewport_u = Vec3.init(viewport_width, 0.0, 0.0);
    const viewport_v = Vec3.init(0.0, -viewport_height, 0.0);

    // Calculate the horizontal and vertical delta vectors from pixel to pixel.
    const pixel_delta_u = viewport_u.div_scalar(image_width);
    const pixel_delta_v = viewport_v.div_scalar(image_height);

    // Calculate the location of the upper left pixel.
    const viewport_upper_left = camera_center.sub(Vec3.init(0.0, 0.0, focal_length).sub(viewport_u.div_scalar(2).sub(viewport_v.div_scalar(2))));
    const pixel00_loc = viewport_upper_left.add(pixel_delta_u.mult_scalar(0.5).add(pixel_delta_v.mult_scalar(0.5)));

    const stdout = std.io.getStdOut().writer();
    const image_height_int: i32 = @intFromFloat(image_height);
    const image_width_int: i32 = @intFromFloat(image_width);
    try stdout.print("P3\n{d} {d}\n255\n", .{ image_width_int, image_height_int });

    for (0..@intFromFloat(image_height)) |j| {
        for (0..image_width) |i| {
            const pixel_center = pixel00_loc.add(pixel_delta_u.mult_scalar(@floatFromInt(i))).add(pixel_delta_v.mult_scalar(@floatFromInt(j)));
            const ray_direction = pixel_center.sub(camera_center);
            const r = ray_lib.Ray.init(camera_center, ray_direction);

            const pixel_color = color_ray(r);
            try color_lib.write_color(stdout, pixel_color);
        }
    }
}
