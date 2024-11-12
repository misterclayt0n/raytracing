const Vec3 = @import("vec3.zig").Vec3;
const Point3 = @import("vec3.zig").Point3;

pub const Ray = struct {
    orig: Point3,
    dir: Vec3,

    pub fn init(origin: Point3, direction: Vec3) Ray {
        return Ray{
            .orig = origin,
            .dir = direction
        };
    }

    pub fn at(self: Ray, t: f64) Point3 {
        return self.orig.add(self.dir.mult_scalar(t));
    }
};
