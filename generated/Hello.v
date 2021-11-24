module DataMemory(
  input         clock,
  input  [15:0] io_address,
  input         io_writeEnable,
  input         io_testerEnable,
  input  [15:0] io_testerAddress,
  output [31:0] io_testerDataRead,
  input         io_testerWriteEnable,
  input  [31:0] io_testerDataWrite
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] memory [0:65535]; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_addr; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_2_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_2_addr; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_1_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_1_addr; // @[DataMemory.scala 18:20]
  wire  memory__T_1_mask; // @[DataMemory.scala 18:20]
  wire  memory__T_1_en; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_3_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_3_addr; // @[DataMemory.scala 18:20]
  wire  memory__T_3_mask; // @[DataMemory.scala 18:20]
  wire  memory__T_3_en; // @[DataMemory.scala 18:20]
  wire [31:0] _GEN_5 = io_testerWriteEnable ? io_testerDataWrite : memory__T_data; // @[DataMemory.scala 27:32]
  assign memory__T_addr = io_testerAddress;
  assign memory__T_data = memory[memory__T_addr]; // @[DataMemory.scala 18:20]
  assign memory__T_2_addr = io_address;
  assign memory__T_2_data = memory[memory__T_2_addr]; // @[DataMemory.scala 18:20]
  assign memory__T_1_data = io_testerDataWrite;
  assign memory__T_1_addr = io_testerAddress;
  assign memory__T_1_mask = 1'h1;
  assign memory__T_1_en = io_testerEnable & io_testerWriteEnable;
  assign memory__T_3_data = 32'h0;
  assign memory__T_3_addr = io_address;
  assign memory__T_3_mask = 1'h1;
  assign memory__T_3_en = io_testerEnable ? 1'h0 : io_writeEnable;
  assign io_testerDataRead = io_testerEnable ? _GEN_5 : 32'h0; // @[DataMemory.scala 24:23 DataMemory.scala 30:25 DataMemory.scala 36:23]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 65536; initvar = initvar+1)
    memory[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(memory__T_1_en & memory__T_1_mask) begin
      memory[memory__T_1_addr] <= memory__T_1_data; // @[DataMemory.scala 18:20]
    end
    if(memory__T_3_en & memory__T_3_mask) begin
      memory[memory__T_3_addr] <= memory__T_3_data; // @[DataMemory.scala 18:20]
    end
  end
endmodule
module Hello(
  input         clock,
  input         reset,
  output        io_done,
  input         io_start,
  input         io_testerDataMemEnable,
  input  [15:0] io_testerDataMemAddress,
  output [31:0] io_testerDataMemDataRead,
  input         io_testerDataMemWriteEnable,
  input  [31:0] io_testerDataMemDataWrite
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  dataMemory_clock; // @[Hello.scala 33:26]
  wire [15:0] dataMemory_io_address; // @[Hello.scala 33:26]
  wire  dataMemory_io_writeEnable; // @[Hello.scala 33:26]
  wire  dataMemory_io_testerEnable; // @[Hello.scala 33:26]
  wire [15:0] dataMemory_io_testerAddress; // @[Hello.scala 33:26]
  wire [31:0] dataMemory_io_testerDataRead; // @[Hello.scala 33:26]
  wire  dataMemory_io_testerWriteEnable; // @[Hello.scala 33:26]
  wire [31:0] dataMemory_io_testerDataWrite; // @[Hello.scala 33:26]
  reg [1:0] stateReg; // @[Hello.scala 37:25]
  reg [15:0] addressReg; // @[Hello.scala 40:27]
  wire  _T = 2'h0 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_1 = 2'h1 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_2 = 2'h2 == stateReg; // @[Conditional.scala 37:30]
  wire [15:0] _T_4 = addressReg + 16'h190; // @[Hello.scala 65:43]
  wire [15:0] _T_6 = addressReg + 16'h1; // @[Hello.scala 67:32]
  wire  _T_7 = addressReg == 16'h18f; // @[Hello.scala 68:23]
  wire  _T_8 = 2'h3 == stateReg; // @[Conditional.scala 37:30]
  wire [15:0] _GEN_5 = _T_2 ? _T_4 : 16'h0; // @[Conditional.scala 39:67]
  wire  _GEN_9 = _T_2 ? 1'h0 : _T_8; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_10 = _T_1 ? addressReg : _GEN_5; // @[Conditional.scala 39:67]
  wire  _GEN_12 = _T_1 ? 1'h0 : _T_2; // @[Conditional.scala 39:67]
  wire  _GEN_14 = _T_1 ? 1'h0 : _GEN_9; // @[Conditional.scala 39:67]
  DataMemory dataMemory ( // @[Hello.scala 33:26]
    .clock(dataMemory_clock),
    .io_address(dataMemory_io_address),
    .io_writeEnable(dataMemory_io_writeEnable),
    .io_testerEnable(dataMemory_io_testerEnable),
    .io_testerAddress(dataMemory_io_testerAddress),
    .io_testerDataRead(dataMemory_io_testerDataRead),
    .io_testerWriteEnable(dataMemory_io_testerWriteEnable),
    .io_testerDataWrite(dataMemory_io_testerDataWrite)
  );
  assign io_done = _T ? 1'h0 : _GEN_14; // @[Hello.scala 47:11 Hello.scala 76:15]
  assign io_testerDataMemDataRead = dataMemory_io_testerDataRead; // @[Hello.scala 83:28]
  assign dataMemory_clock = clock;
  assign dataMemory_io_address = _T ? 16'h0 : _GEN_10; // @[Hello.scala 45:25 Hello.scala 59:29 Hello.scala 65:29]
  assign dataMemory_io_writeEnable = _T ? 1'h0 : _GEN_12; // @[Hello.scala 44:29 Hello.scala 66:33]
  assign dataMemory_io_testerEnable = io_testerDataMemEnable; // @[Hello.scala 85:30]
  assign dataMemory_io_testerAddress = io_testerDataMemAddress; // @[Hello.scala 82:31]
  assign dataMemory_io_testerWriteEnable = io_testerDataMemWriteEnable; // @[Hello.scala 86:35]
  assign dataMemory_io_testerDataWrite = io_testerDataMemDataWrite; // @[Hello.scala 84:33]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stateReg = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  addressReg = _RAND_1[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      stateReg <= 2'h0;
    end else if (_T) begin
      if (io_start) begin
        stateReg <= 2'h1;
      end
    end else if (_T_1) begin
      stateReg <= 2'h2;
    end else if (_T_2) begin
      if (_T_7) begin
        stateReg <= 2'h3;
      end else begin
        stateReg <= 2'h1;
      end
    end else if (_T_8) begin
      stateReg <= 2'h3;
    end
    if (reset) begin
      addressReg <= 16'h0;
    end else if (_T) begin
      if (io_start) begin
        addressReg <= 16'h0;
      end
    end else if (!(_T_1)) begin
      if (_T_2) begin
        addressReg <= _T_6;
      end
    end
  end
endmodule
