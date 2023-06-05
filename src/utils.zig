const std = @import("std");

const C = @import("constants.zig");

pub fn nextSBits(field: usize, n: usize, offset: usize) C.qword {
    return ((@intCast(C.qword, field) >> @intCast(u6, offset)) &
        ((@intCast(C.qword, 1) << @intCast(u6, n)) - 1));
}

pub fn firstNBits(field: usize, n: usize) C.qword {
    return nextSBits(field, n, 0);
}

pub fn hiBytes(field: usize, bytes: usize) C.qword {
    return nextSBits(@intCast(C.qword, field), bytes * 8, bytes * 8);
}

pub fn loBytes(field: usize, bytes: usize) C.qword {
    return firstNBits(@intCast(C.qword, field), bytes * 8);
}

pub fn byDWord(n: [4]usize) C.dword {
    var result: C.dword = 0;

    inline for (n, 0..) |value, index| {
        result |= @intCast(C.dword, value) << (index * 8);
    }

    return result;
}

test "test_nextSBits" {
    const testing = std.testing;
    var field: usize = 0x04030201;
    var result = nextSBits(field, 16, 16);
    try testing.expectEqual(result, 0x0403);
}

test "test_firstNBits" {
    const testing = std.testing;
    var field: usize = 0x04030201;
    var result = firstNBits(field, 16);
    try testing.expectEqual(result, 0x0201);
}

test "test_hiBytes" {
    const testing = std.testing;
    var field: usize = 0x04030201;
    var result = hiBytes(field, 2);
    try testing.expectEqual(result, 0x0403);
}

test "test_loBytes" {
    const testing = std.testing;
    var field: usize = 0x04030201;
    var result = loBytes(field, 2);
    try testing.expectEqual(result, 0x0201);
}
test "test_byDWord" {
    const testing = std.testing;
    var n: [4]usize = .{ 0x01, 0x02, 0x03, 0x04 };
    var result = byDWord(n);
    try testing.expectEqual(result, 0x04030201);
}
