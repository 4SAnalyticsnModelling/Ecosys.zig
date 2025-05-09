const std = @import("std");

pub fn powf(base: f32, exponent: f32) f32 {
    return @exp(exponent * @log(base));
}
