# 16bit YRV-Plus RISC-V CPU for OMDAZZ board with VGA PS/2 keyboard and Serial port

## Scripts description
In  Plus/boards/omdazz/ run
```
  01_clean.bash                   Clean project
  05_synthesize_for_fpga.bash     Synthesize project and load ro FPGA
  06_configure_fpga.bash          Load project to FPGA
  07_upload_soft_to_fpga.bash     Upload binary using UART
  
```
You need USB-to-Serial adapter for loading binary to the FPGA Board.


## Programs Description
```
  01_hello_text        Serial port example
  01_tetris            ASCII based tetris game
```

After build you copy  _code_demo.mem16_ to the _Plus/design_ directory

You can run ./07_upload_soft_to_fpga.bash directly form source folder

## Toolchain 

Toolchain shoul be installed in:  _/opt/riscv_native

Minimal version of GCC should be 12.1.0

## Tetris game 
![ASCII Tetris game](/tetris.jpg "Tetris")

## Serial port:
Original serial port https://github.com/fpga-logi/logi-pong-chu-examples/tree/master/pong-chu-logi-edu-examples-verilog
https://onlinelibrary.wiley.com/doi/epdf/10.1002/9780470374283.ch8
https://www.youtube.com/shorts/iWDif9F_Z_U

## Related books:
"Inside An Open-Source Processor" ISBN 978-3-89576-443-1 Author, Monte Dalrymple

"Modern C." Manning, 2019, 9781617295812. ffhal-02383654 Jens Gustedt. 

FPGA Prototyping by Verilog Examples Author(s):Pong P. Chu First published:11 June 2008
