// pub const Self = @This();

pub const pk_length = 25;

pub const null_terminator = 1;

pub const field_bytes = 48;

pub const field_bits = field_bytes * 8;

pub const field_bytes_2003 = 64;

pub const field_bits_2003 = field_bytes_2003 * 8;

pub const sha_msg_length_xp = (4 + 2 * field_bytes);

pub const sha_msg_length_2003 = (4 + 2 * field_bytes_2003);

pub const byte = u8;
pub const word = u16;
pub const dword = u32;
pub const qword = u64;
