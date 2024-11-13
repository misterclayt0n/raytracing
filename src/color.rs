use crate::vec3::Vec3;
use std::io;
use std::io::Write;

pub type Color = Vec3;

pub fn write_color<W>(writer: &mut W, pixel_color: Color) -> io::Result<()>
where
    W: Write,
{
    let r = pixel_color.x();
    let g = pixel_color.y();
    let b = pixel_color.z();

    // Clamp the color values to [0.0, 1.0].
    let r = r.clamp(0.0, 1.0);
    let g = g.clamp(0.0, 1.0);
    let b = b.clamp(0.0, 1.0);

    // Translate the [0,1] component values to the byte range [0,255].
    let ir = (255.999 * r) as u8;
    let ig = (255.999 * g) as u8;
    let ib = (255.999 * b) as u8;

    writeln!(writer, "{} {} {}", ir, ig, ib)
}
