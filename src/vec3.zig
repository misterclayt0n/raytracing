const std = @import("std");

pub const Vec3 = struct {
    e: [3]f64,

    //
    // Constructors
    //

    pub fn init(e0: f64, e1: f64, e2: f64) Vec3 {
        return Vec3{ .e = .{ e0, e1, e2 } };
    }

    pub fn zero() Vec3 {
        return Vec3{ .e = .{ 0.0, 0.0, 0.0 } };
    }

    //
    // Modify
    //

    pub fn add(self: Vec3, other: Vec3) Vec3 {
        return Vec3{.e{
            self.e[0] + other.e[0],
            self.e[1] + other.e[1],
            self.e[2] + other.e[2],
        }};
    }

    pub fn sub(self: Vec3, other: Vec3) Vec3 {
        return Vec3{.e{
            self.e[0] - other.e[0],
            self.e[1] - other.e[1],
            self.e[2] - other.e[2],
        }};
    }

    pub fn mult_scalar(self: Vec3, t: f64) Vec3 {
        return Vec3{.e{
            self.e[0] * t,
            self.e[1] * t,
            self.e[2] * t,
        }};
    }

    pub fn div_scalar(self: Vec3, t: f64) Vec3 {
        return self.mult_scalar(1.0 / t);
    }

    pub fn length(self: Vec3) f64 {
        return std.math.sqrt(self.length_squared());
    }

    pub fn length_squared(self: Vec3) f64 {
        return self.e[0] * self.e[0] + self.e[1] * self.e[1] + self.e[2] * self.e[2];
    }

    pub fn unit_vector(self: Vec3) Vec3 {
        return self.div_scalar(self.length());
    }
};

// Semantic aliases
pub const Point3 = Vec3;

// Unary subtraction
pub fn neg(v: Vec3) Vec3 {
    return Vec3{
        .e {
            -v.e[0],
            -v.e[1],
            -v.e[2],
        }
    };
}

//
// Binary operations
//

pub fn add(u: Vec3, v: Vec3) Vec3 {
    return u.add(v);
}

pub fn sub(u: Vec3, v: Vec3) Vec3 {
    return u.sub(v);
}

pub fn mult(u: Vec3, v: Vec3) Vec3 {
    return Vec3 {
        .e {
            u.e[0] * v.e[0],
            u.e[1] * v.e[1],
            u.e[2] * v.e[2],
        }
    };
}

pub fn mult_scalar(t: f64, v: Vec3) Vec3 {
    return v.mult_scalar(t);
}

pub fn mult_vec3_scalar(v: Vec3, t: f64) Vec3 {
    return mult_scalar(t, v);
}

pub fn div_scalar(v: Vec3, t: f64) Vec3 {
    return v.div_scalar(t);
}

// Dot product
pub fn dot(u: Vec3, v: Vec3) f64 {
    return u.e[0] * v.e[0] + u.e[1] * v.e[1] + u.e[2] * v.e[2];
}

// Cross product
pub fn cross(u: Vec3, v: Vec3) Vec3 {
    return Vec3{
        .e = .{
            u.e[1] * v.e[2] - u.e[2] * v.e[1],
            u.e[2] * v.e[0] - u.e[0] * v.e[2],
            u.e[0] * v.e[1] - u.e[1] * v.e[0],
        },
    };
}

// Print the mf
//
// Pass some sort of stdout here, anything that can have a print function
pub fn print_vec3(w: anytype, v: Vec3) !void {
    try w.print("{d} {d} {d}\n", .{v.e[0], v.e[1], v.e[2]});
}
