OUTPUT_ARCH( "riscv" )
ENTRY(_start)
MEMORY
{
  BRAM     (rx) : ORIGIN = 0x00000000, LENGTH = 16K
}
_TRAP_ACK = 0x040;
_NMI_VECT = 0x100;
_DBG_VEC =  0x140;
_DEX_VEC =  0x1c0;
_RST_BASE = 0x200;

 SECTIONS
 {

 PROVIDE(__stack_top = ORIGIN(BRAM) + LENGTH(BRAM));
 PROVIDE(__pre_init = default_pre_init);
 PROVIDE(_mp_hook = default_mp_hook);

 .text :
 {
    *(.text.eset_led)
    . = _TRAP_ACK;
    *(.text.trap_ack)
    . = _NMI_VECT;
    *(.text.nmi_vec)
    . = _DBG_VEC;
    *(.text.dbg_vec)
    . = _DEX_VEC;
    *(.text.dex_vec)
    . = _RST_BASE;
    *(.text.init)
    *(.text.init.rust)
    *(.text)
 }>BRAM 

 .rodata :
 {  
    . = ALIGN(4);
    *(.rodata)
 }> BRAM

 .data :
 {  _sidata = LOADADDR(.data);
    _sdata = .;
    *(.data)
    _edata = .;
 }> BRAM

 .sdata :
 {  
    . = ALIGN(4);
    PROVIDE( __global_pointer$ = . + 0x800);
    *(.sdata)
 }> BRAM

 .bss :
 {  _sbss = .;
    . = ALIGN(4);
    *(.bss)
    _ebss = .;
 }> BRAM

 .sbss :
 {  
    . = ALIGN(4);
    *(.sbss)
 }> BRAM


 
  /DISCARD/ :
  {
    *(.note.gnu.build-id)
    *(.riscv.attributes)
    *(.comment)
  }
 

_end = .;
 }