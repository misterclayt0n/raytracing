const std = @import("std");
const Vec3 = @import("vec3.zig").Vec3;
const vec_lib = @import("vec3.zig");
const Color = @import("color.zig").Color;
const color_lib = @import("color.zig");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const vec = Vec3.zero();
    try vec_lib.print_vec3(stdout, vec);

    const image_width = 256;
    const image_height = 256;
    const width_float: f32 = @floatFromInt(image_width);
    const height_float: f32 = @floatFromInt(image_height);

    try stdout.print("P3\n{d} {d}\n255\n", .{image_width, image_height});

    for (0..image_height) |j| {
        for (0..image_width) |i| {
            // I really don't understand Zig's casting system.
            const float_i: f32 = @floatFromInt(i);
            const float_j: f32 = @floatFromInt(j);

            const e0: f32 = float_i / width_float - 1;
            const e1: f32 = float_j / height_float - 1;
            const e2 = 0.0;

            const pixel_color = Color.init(e0, e1, e2);
            try color_lib.write_color(stdout, pixel_color);
        }
    }
}
