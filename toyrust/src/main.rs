#![no_std]

pub static mut FOOBAR: u64 = 0;

pub mod barbaz {
    pub static mut FOOBAR: u64 = 0;
}

#[inline(never)]
#[no_mangle]
pub fn add2(base: i64) -> i64 {
	return base + 2;
}

