use crate::{
    hittable::Hittable,
    vec3::{Point3, Vec3},
};

pub struct Sphere {
    pub center: Point3,
    pub radius: f64,
}

impl Sphere {
    pub fn new(center: Point3, radius: f64) -> Self {
        Self { center, radius }
    }
}

impl Hittable for Sphere {
    fn hit(
        &self,
        ray: &crate::ray::Ray,
        ray_tmin: f64,
        ray_tmax: f64,
        rec: &mut crate::hittable::HitRecord,
    ) -> bool {
        let oc = ray.orig - self.center;
        let a = ray.dir.length_squared();
        let h = Vec3::dot(&oc, &ray.dir);
        let c = oc.length_squared() - self.radius * self.radius;
        let discriminant = h * h - a * c;

        if discriminant < 0.0 {
            return false; // No real roots; ray doesn't hit the sphere
        }

        let sqrtd = discriminant.sqrt();

        // Find the nearest root that lies in the acceptable range.
        let mut root = (-h - sqrtd) / a;
        if root < ray_tmin || ray_tmax < root {
            root = (-h + sqrtd) / a;
            if root < ray_tmin || ray_tmax < root {
                return false; // No valid root in range
            }
        }

        rec.t = root;
        rec.p = ray.at(rec.t);
        rec.normal = (rec.p - self.center) / self.radius;

        return true;
    }
}
