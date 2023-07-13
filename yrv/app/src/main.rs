#![no_std]
#![no_main]

extern crate panic_halt;
extern crate riscv_rt;
mod vga_buffer;
use riscv_rt::entry;



// use `main` as the entry point of this application
// `main` is not allowed to return
#[entry]
fn main() -> ! {
    // vga_buffer::print_something();

    vga_buffer::clean();
    println!("YRV CPU");
    vga_buffer::print_something();
    loop { }
}

#[export_name = "_mp_hook"]
pub extern "Rust" fn mp_hook(_hartid: usize) -> bool {
    true
}