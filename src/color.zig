const std = @import("std");
const Vec3 = @import("vec3.zig").Vec3;
pub const Color = Vec3;

pub fn write_color(w: anytype, pixel_color: Color) !void {
    const r = pixel_color.e[0];
    const g = pixel_color.e[1];
    const b = pixel_color.e[2];

    // Translate the [0, 1] component values to the byte range [0, 255].
    const rbyte: i32 = @intFromFloat(255.999 * r);
    const gbyte: i32 = @intFromFloat(255.999 * g);
    const bbyte: i32 = @intFromFloat(255.999 * b);

    try w.print("{d} {d} {d}\n", .{rbyte, gbyte, bbyte});
}
