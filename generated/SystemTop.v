module DataMemory(
  input         clock,
  input  [15:0] io_address,
  output [31:0] io_dataRead,
  input         io_writeEnable,
  input  [31:0] io_dataWrite,
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
  wire [31:0] _GEN_11 = io_writeEnable ? io_dataWrite : memory__T_2_data; // @[DataMemory.scala 37:26]
  assign memory__T_addr = io_testerAddress;
  assign memory__T_data = memory[memory__T_addr]; // @[DataMemory.scala 18:20]
  assign memory__T_2_addr = io_address;
  assign memory__T_2_data = memory[memory__T_2_addr]; // @[DataMemory.scala 18:20]
  assign memory__T_1_data = io_testerDataWrite;
  assign memory__T_1_addr = io_testerAddress;
  assign memory__T_1_mask = 1'h1;
  assign memory__T_1_en = io_testerEnable & io_testerWriteEnable;
  assign memory__T_3_data = io_dataWrite;
  assign memory__T_3_addr = io_address;
  assign memory__T_3_mask = 1'h1;
  assign memory__T_3_en = io_testerEnable ? 1'h0 : io_writeEnable;
  assign io_dataRead = io_testerEnable ? 32'h0 : _GEN_11; // @[DataMemory.scala 26:17 DataMemory.scala 34:17 DataMemory.scala 40:19]
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
module Accelerator(
  input         clock,
  input         reset,
  input         io_start,
  output        io_done,
  output [15:0] io_address,
  input  [31:0] io_dataRead,
  output        io_writeEnable,
  output [31:0] io_dataWrite
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] stateReg; // @[Accelerator.scala 18:25]
  reg [15:0] addressReg; // @[Accelerator.scala 21:27]
  reg [31:0] dataReg; // @[Accelerator.scala 22:24]
  reg [31:0] counter; // @[Accelerator.scala 23:24]
  wire  _T = 3'h0 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_1 = 3'h1 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_2 = addressReg < 16'h14; // @[Accelerator.scala 44:23]
  wire  _T_3 = addressReg > 16'h17b; // @[Accelerator.scala 44:44]
  wire  _T_4 = _T_2 | _T_3; // @[Accelerator.scala 44:30]
  wire  _T_5 = counter == 32'h13; // @[Accelerator.scala 44:63]
  wire  _T_6 = _T_4 | _T_5; // @[Accelerator.scala 44:52]
  wire  _T_7 = counter == 32'h0; // @[Accelerator.scala 44:83]
  wire  _T_8 = _T_6 | _T_7; // @[Accelerator.scala 44:72]
  wire  _T_10 = io_dataRead[7:0] == 8'h0; // @[Accelerator.scala 44:112]
  wire  _T_11 = _T_8 | _T_10; // @[Accelerator.scala 44:91]
  wire  _T_12 = 3'h2 == stateReg; // @[Conditional.scala 37:30]
  wire [15:0] _T_14 = addressReg - 16'h14; // @[Accelerator.scala 57:32]
  wire  _T_17 = 3'h3 == stateReg; // @[Conditional.scala 37:30]
  wire [15:0] _T_19 = addressReg + 16'h14; // @[Accelerator.scala 67:32]
  wire  _T_22 = 3'h4 == stateReg; // @[Conditional.scala 37:30]
  wire [15:0] _T_24 = addressReg - 16'h1; // @[Accelerator.scala 77:32]
  wire  _T_27 = 3'h5 == stateReg; // @[Conditional.scala 37:30]
  wire [15:0] _T_29 = addressReg + 16'h1; // @[Accelerator.scala 87:32]
  wire [7:0] _GEN_10 = _T_10 ? 8'h0 : 8'hff; // @[Accelerator.scala 88:39]
  wire  _T_32 = 3'h6 == stateReg; // @[Conditional.scala 37:30]
  wire [15:0] _T_34 = addressReg + 16'h190; // @[Accelerator.scala 98:32]
  wire [31:0] _T_39 = counter + 32'h1; // @[Accelerator.scala 106:28]
  wire  _T_40 = addressReg == 16'h18f; // @[Accelerator.scala 109:23]
  wire  _T_41 = 3'h7 == stateReg; // @[Conditional.scala 37:30]
  wire [15:0] _GEN_16 = _T_32 ? _T_34 : 16'h0; // @[Conditional.scala 39:67]
  wire  _GEN_21 = _T_32 ? 1'h0 : _T_41; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_22 = _T_27 ? _T_29 : _GEN_16; // @[Conditional.scala 39:67]
  wire  _GEN_25 = _T_27 ? 1'h0 : _T_32; // @[Conditional.scala 39:67]
  wire  _GEN_28 = _T_27 ? 1'h0 : _GEN_21; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_29 = _T_22 ? _T_24 : _GEN_22; // @[Conditional.scala 39:67]
  wire  _GEN_32 = _T_22 ? 1'h0 : _GEN_25; // @[Conditional.scala 39:67]
  wire  _GEN_35 = _T_22 ? 1'h0 : _GEN_28; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_36 = _T_17 ? _T_19 : _GEN_29; // @[Conditional.scala 39:67]
  wire  _GEN_39 = _T_17 ? 1'h0 : _GEN_32; // @[Conditional.scala 39:67]
  wire  _GEN_42 = _T_17 ? 1'h0 : _GEN_35; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_43 = _T_12 ? _T_14 : _GEN_36; // @[Conditional.scala 39:67]
  wire  _GEN_46 = _T_12 ? 1'h0 : _GEN_39; // @[Conditional.scala 39:67]
  wire  _GEN_49 = _T_12 ? 1'h0 : _GEN_42; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_50 = _T_1 ? addressReg : _GEN_43; // @[Conditional.scala 39:67]
  wire  _GEN_53 = _T_1 ? 1'h0 : _GEN_46; // @[Conditional.scala 39:67]
  wire  _GEN_56 = _T_1 ? 1'h0 : _GEN_49; // @[Conditional.scala 39:67]
  assign io_done = _T ? 1'h0 : _GEN_56; // @[Accelerator.scala 29:11 Accelerator.scala 117:15]
  assign io_address = _T ? 16'h0 : _GEN_50; // @[Accelerator.scala 27:14 Accelerator.scala 41:18 Accelerator.scala 57:18 Accelerator.scala 67:18 Accelerator.scala 77:18 Accelerator.scala 87:18 Accelerator.scala 98:18]
  assign io_writeEnable = _T ? 1'h0 : _GEN_53; // @[Accelerator.scala 26:18 Accelerator.scala 99:22]
  assign io_dataWrite = dataReg; // @[Accelerator.scala 28:16]
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
  stateReg = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  addressReg = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  dataReg = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  counter = _RAND_3[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      stateReg <= 3'h0;
    end else if (_T) begin
      if (io_start) begin
        stateReg <= 3'h1;
      end
    end else if (_T_1) begin
      if (_T_11) begin
        stateReg <= 3'h6;
      end else begin
        stateReg <= 3'h2;
      end
    end else if (_T_12) begin
      if (_T_10) begin
        stateReg <= 3'h6;
      end else begin
        stateReg <= 3'h3;
      end
    end else if (_T_17) begin
      if (_T_10) begin
        stateReg <= 3'h6;
      end else begin
        stateReg <= 3'h4;
      end
    end else if (_T_22) begin
      if (_T_10) begin
        stateReg <= 3'h6;
      end else begin
        stateReg <= 3'h5;
      end
    end else if (_T_27) begin
      stateReg <= 3'h6;
    end else if (_T_32) begin
      if (_T_40) begin
        stateReg <= 3'h7;
      end else begin
        stateReg <= 3'h1;
      end
    end else if (_T_41) begin
      stateReg <= 3'h7;
    end
    if (reset) begin
      addressReg <= 16'h0;
    end else if (_T) begin
      if (io_start) begin
        addressReg <= 16'h0;
      end
    end else if (!(_T_1)) begin
      if (!(_T_12)) begin
        if (!(_T_17)) begin
          if (!(_T_22)) begin
            if (!(_T_27)) begin
              if (_T_32) begin
                addressReg <= _T_29;
              end
            end
          end
        end
      end
    end
    if (reset) begin
      dataReg <= 32'h0;
    end else if (!(_T)) begin
      if (_T_1) begin
        if (_T_11) begin
          dataReg <= 32'h0;
        end
      end else if (_T_12) begin
        if (_T_10) begin
          dataReg <= 32'h0;
        end
      end else if (_T_17) begin
        if (_T_10) begin
          dataReg <= 32'h0;
        end
      end else if (_T_22) begin
        if (_T_10) begin
          dataReg <= 32'h0;
        end
      end else if (_T_27) begin
        dataReg <= {{24'd0}, _GEN_10};
      end
    end
    if (reset) begin
      counter <= 32'h0;
    end else if (!(_T)) begin
      if (!(_T_1)) begin
        if (!(_T_12)) begin
          if (!(_T_17)) begin
            if (!(_T_22)) begin
              if (!(_T_27)) begin
                if (_T_32) begin
                  if (_T_5) begin
                    counter <= 32'h0;
                  end else begin
                    counter <= _T_39;
                  end
                end
              end
            end
          end
        end
      end
    end
  end
endmodule
module SystemTop(
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
  wire  dataMemory_clock; // @[SystemTop.scala 18:26]
  wire [15:0] dataMemory_io_address; // @[SystemTop.scala 18:26]
  wire [31:0] dataMemory_io_dataRead; // @[SystemTop.scala 18:26]
  wire  dataMemory_io_writeEnable; // @[SystemTop.scala 18:26]
  wire [31:0] dataMemory_io_dataWrite; // @[SystemTop.scala 18:26]
  wire  dataMemory_io_testerEnable; // @[SystemTop.scala 18:26]
  wire [15:0] dataMemory_io_testerAddress; // @[SystemTop.scala 18:26]
  wire [31:0] dataMemory_io_testerDataRead; // @[SystemTop.scala 18:26]
  wire  dataMemory_io_testerWriteEnable; // @[SystemTop.scala 18:26]
  wire [31:0] dataMemory_io_testerDataWrite; // @[SystemTop.scala 18:26]
  wire  accelerator_clock; // @[SystemTop.scala 19:27]
  wire  accelerator_reset; // @[SystemTop.scala 19:27]
  wire  accelerator_io_start; // @[SystemTop.scala 19:27]
  wire  accelerator_io_done; // @[SystemTop.scala 19:27]
  wire [15:0] accelerator_io_address; // @[SystemTop.scala 19:27]
  wire [31:0] accelerator_io_dataRead; // @[SystemTop.scala 19:27]
  wire  accelerator_io_writeEnable; // @[SystemTop.scala 19:27]
  wire [31:0] accelerator_io_dataWrite; // @[SystemTop.scala 19:27]
  DataMemory dataMemory ( // @[SystemTop.scala 18:26]
    .clock(dataMemory_clock),
    .io_address(dataMemory_io_address),
    .io_dataRead(dataMemory_io_dataRead),
    .io_writeEnable(dataMemory_io_writeEnable),
    .io_dataWrite(dataMemory_io_dataWrite),
    .io_testerEnable(dataMemory_io_testerEnable),
    .io_testerAddress(dataMemory_io_testerAddress),
    .io_testerDataRead(dataMemory_io_testerDataRead),
    .io_testerWriteEnable(dataMemory_io_testerWriteEnable),
    .io_testerDataWrite(dataMemory_io_testerDataWrite)
  );
  Accelerator accelerator ( // @[SystemTop.scala 19:27]
    .clock(accelerator_clock),
    .reset(accelerator_reset),
    .io_start(accelerator_io_start),
    .io_done(accelerator_io_done),
    .io_address(accelerator_io_address),
    .io_dataRead(accelerator_io_dataRead),
    .io_writeEnable(accelerator_io_writeEnable),
    .io_dataWrite(accelerator_io_dataWrite)
  );
  assign io_done = accelerator_io_done; // @[SystemTop.scala 23:11]
  assign io_testerDataMemDataRead = dataMemory_io_testerDataRead; // @[SystemTop.scala 34:28]
  assign dataMemory_clock = clock;
  assign dataMemory_io_address = accelerator_io_address; // @[SystemTop.scala 28:25]
  assign dataMemory_io_writeEnable = accelerator_io_writeEnable; // @[SystemTop.scala 30:29]
  assign dataMemory_io_dataWrite = accelerator_io_dataWrite; // @[SystemTop.scala 29:27]
  assign dataMemory_io_testerEnable = io_testerDataMemEnable; // @[SystemTop.scala 36:30]
  assign dataMemory_io_testerAddress = io_testerDataMemAddress; // @[SystemTop.scala 33:31]
  assign dataMemory_io_testerWriteEnable = io_testerDataMemWriteEnable; // @[SystemTop.scala 37:35]
  assign dataMemory_io_testerDataWrite = io_testerDataMemDataWrite; // @[SystemTop.scala 35:33]
  assign accelerator_clock = clock;
  assign accelerator_reset = reset;
  assign accelerator_io_start = io_start; // @[SystemTop.scala 24:24]
  assign accelerator_io_dataRead = dataMemory_io_dataRead; // @[SystemTop.scala 27:27]
endmodule
