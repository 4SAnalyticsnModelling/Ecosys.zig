const std = @import("std");

pub fn flatIndex(comptime N: usize, indices: [N]usize, dims: [N]usize) usize {
    var idx: usize = 0;
    var stride: usize = 1;

    var i: usize = N;
    while (i > 0) : (i -= 1) {
        idx += indices[i] * stride;
        stride *= dims[i];
    }
    return idx;
}
