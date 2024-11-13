use crate::{
    ray::Ray,
    vec3::{Point3, Vec3},
};

/// Stores information about a ray-object intersection.
pub struct HitRecord {
    pub p: Point3,    // Point of intersection.
    pub normal: Vec3, // Surface normal of the intersection.
    pub t: f64,       // Ray parameter at intersection.
}

/// Defines a common interface for objects that can be hit by rays.
pub trait Hittable {
    fn hit(&self, ray: &Ray, ray_twin: f64, ray_tmax: f64, rec: &mut HitRecord) -> bool;
}
