#![no_std]

pub static mut FOOBAR: i64 = 0;

pub mod barbaz {
    pub static mut FOOBAR: i64 = 0;
}

#[inline(never)]
#[no_mangle]
pub fn add2(base: i64) -> i64 {
	if base > 22 {
	  unsafe { core::ptr::write_volatile(&mut FOOBAR, base) };
	}
	return base + 2;
}

