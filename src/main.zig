const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // Image
    const image_width: i32 = 256;
    const image_height: i32 = 256;
    const width_float: f32 = @floatFromInt(image_width);
    const height_float: f32 = @floatFromInt(image_height);

    // Render
    try stdout.print("P3\n{d} {d}\n255\n", .{image_width, image_height});

    for (0..image_height) |j| {
        for (0..image_width) |i| {
            const r: f32 = @floatFromInt(i);
            const g: f32 = @floatFromInt(j);
            const b = 0.0;

            const ir: i32 = @intFromFloat(255.999 * (r / (width_float - 1)));
            const ig: i32 = @intFromFloat(255.999 * (g / (height_float - 1)));
            const ib: i32 =  @intFromFloat(255.999 * b);

            try stdout.print("{d} {d} {d}\n", .{ir, ig, ib});
        }
    }
}
