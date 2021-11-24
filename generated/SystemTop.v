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
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] stateReg; // @[Accelerator.scala 18:25]
  reg [15:0] addressReg; // @[Accelerator.scala 21:27]
  reg [31:0] dataReg; // @[Accelerator.scala 22:24]
  reg [31:0] counter; // @[Accelerator.scala 23:24]
  reg [31:0] neighbour; // @[Accelerator.scala 24:26]
  wire  _T = 4'h0 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_1 = 4'h1 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_2 = counter == 32'h13; // @[Accelerator.scala 43:20]
  wire  _T_3 = counter == 32'h0; // @[Accelerator.scala 48:20]
  wire [31:0] _T_5 = counter + 32'h1; // @[Accelerator.scala 50:28]
  wire  _T_8 = 4'h2 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_9 = addressReg < 16'h14; // @[Accelerator.scala 59:23]
  wire  _T_10 = addressReg > 16'h17b; // @[Accelerator.scala 59:44]
  wire  _T_11 = _T_9 | _T_10; // @[Accelerator.scala 59:30]
  wire  _T_13 = io_dataRead[7:0] == 8'h0; // @[Accelerator.scala 64:30]
  wire  _T_14 = 4'h3 == stateReg; // @[Conditional.scala 37:30]
  wire [15:0] _T_16 = addressReg - 16'h14; // @[Accelerator.scala 73:32]
  wire  _T_18 = neighbour == 32'h0; // @[Accelerator.scala 75:22]
  wire  _T_19 = 4'h4 == stateReg; // @[Conditional.scala 37:30]
  wire [15:0] _T_21 = addressReg + 16'h14; // @[Accelerator.scala 83:32]
  wire  _T_24 = 4'h5 == stateReg; // @[Conditional.scala 37:30]
  wire [15:0] _T_26 = addressReg - 16'h1; // @[Accelerator.scala 93:32]
  wire  _T_29 = 4'h6 == stateReg; // @[Conditional.scala 37:30]
  wire [15:0] _T_31 = addressReg + 16'h1; // @[Accelerator.scala 103:32]
  wire [7:0] _GEN_18 = _T_18 ? 8'h0 : 8'hff; // @[Accelerator.scala 105:31]
  wire  _T_34 = 4'h7 == stateReg; // @[Conditional.scala 37:30]
  wire [15:0] _T_36 = addressReg + 16'h190; // @[Accelerator.scala 115:32]
  wire  _T_41 = addressReg == 16'h18f; // @[Accelerator.scala 120:23]
  wire  _T_42 = 4'h8 == stateReg; // @[Conditional.scala 37:30]
  wire [15:0] _GEN_23 = _T_34 ? _T_36 : 16'h0; // @[Conditional.scala 39:67]
  wire  _GEN_28 = _T_34 ? 1'h0 : _T_42; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_29 = _T_29 ? _T_31 : _GEN_23; // @[Conditional.scala 39:67]
  wire  _GEN_33 = _T_29 ? 1'h0 : _T_34; // @[Conditional.scala 39:67]
  wire  _GEN_36 = _T_29 ? 1'h0 : _GEN_28; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_37 = _T_24 ? _T_26 : _GEN_29; // @[Conditional.scala 39:67]
  wire  _GEN_41 = _T_24 ? 1'h0 : _GEN_33; // @[Conditional.scala 39:67]
  wire  _GEN_44 = _T_24 ? 1'h0 : _GEN_36; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_45 = _T_19 ? _T_21 : _GEN_37; // @[Conditional.scala 39:67]
  wire  _GEN_49 = _T_19 ? 1'h0 : _GEN_41; // @[Conditional.scala 39:67]
  wire  _GEN_52 = _T_19 ? 1'h0 : _GEN_44; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_53 = _T_14 ? _T_16 : _GEN_45; // @[Conditional.scala 39:67]
  wire  _GEN_57 = _T_14 ? 1'h0 : _GEN_49; // @[Conditional.scala 39:67]
  wire  _GEN_60 = _T_14 ? 1'h0 : _GEN_52; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_63 = _T_8 ? 16'h0 : _GEN_53; // @[Conditional.scala 39:67]
  wire  _GEN_65 = _T_8 ? 1'h0 : _GEN_57; // @[Conditional.scala 39:67]
  wire  _GEN_68 = _T_8 ? 1'h0 : _GEN_60; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_69 = _T_1 ? addressReg : _GEN_63; // @[Conditional.scala 39:67]
  wire  _GEN_74 = _T_1 ? 1'h0 : _GEN_65; // @[Conditional.scala 39:67]
  wire  _GEN_76 = _T_1 ? 1'h0 : _GEN_68; // @[Conditional.scala 39:67]
  assign io_done = _T ? 1'h0 : _GEN_76; // @[Accelerator.scala 30:11 Accelerator.scala 128:15]
  assign io_address = _T ? 16'h0 : _GEN_69; // @[Accelerator.scala 28:14 Accelerator.scala 42:18 Accelerator.scala 73:18 Accelerator.scala 83:18 Accelerator.scala 93:18 Accelerator.scala 103:18 Accelerator.scala 115:18]
  assign io_writeEnable = _T ? 1'h0 : _GEN_74; // @[Accelerator.scala 27:18 Accelerator.scala 116:22]
  assign io_dataWrite = dataReg; // @[Accelerator.scala 29:16]
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
  stateReg = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  addressReg = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  dataReg = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  counter = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  neighbour = _RAND_4[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      stateReg <= 4'h0;
    end else if (_T) begin
      if (io_start) begin
        stateReg <= 4'h1;
      end
    end else if (_T_1) begin
      stateReg <= 4'h2;
    end else if (_T_8) begin
      stateReg <= 4'h3;
    end else if (_T_14) begin
      if (_T_18) begin
        stateReg <= 4'h7;
      end else begin
        stateReg <= 4'h4;
      end
    end else if (_T_19) begin
      if (_T_18) begin
        stateReg <= 4'h7;
      end else begin
        stateReg <= 4'h5;
      end
    end else if (_T_24) begin
      if (_T_18) begin
        stateReg <= 4'h7;
      end else begin
        stateReg <= 4'h6;
      end
    end else if (_T_29) begin
      stateReg <= 4'h7;
    end else if (_T_34) begin
      if (_T_41) begin
        stateReg <= 4'h8;
      end else begin
        stateReg <= 4'h1;
      end
    end else if (_T_42) begin
      stateReg <= 4'h8;
    end
    if (reset) begin
      addressReg <= 16'h0;
    end else if (_T) begin
      if (io_start) begin
        addressReg <= 16'h0;
      end
    end else if (!(_T_1)) begin
      if (!(_T_8)) begin
        if (!(_T_14)) begin
          if (!(_T_19)) begin
            if (!(_T_24)) begin
              if (!(_T_29)) begin
                if (_T_34) begin
                  addressReg <= _T_31;
                end
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
        if (_T_3) begin
          dataReg <= 32'h0;
        end else if (_T_2) begin
          dataReg <= 32'h0;
        end
      end else if (_T_8) begin
        if (_T_13) begin
          dataReg <= 32'h0;
        end else if (_T_11) begin
          dataReg <= 32'h0;
        end
      end else if (_T_14) begin
        if (_T_18) begin
          dataReg <= 32'h0;
        end
      end else if (_T_19) begin
        if (_T_18) begin
          dataReg <= 32'h0;
        end
      end else if (_T_24) begin
        if (_T_18) begin
          dataReg <= 32'h0;
        end
      end else if (_T_29) begin
        dataReg <= {{24'd0}, _GEN_18};
      end
    end
    if (reset) begin
      counter <= 32'h0;
    end else if (!(_T)) begin
      if (_T_1) begin
        counter <= _T_5;
      end else if (!(_T_8)) begin
        if (!(_T_14)) begin
          if (!(_T_19)) begin
            if (!(_T_24)) begin
              if (!(_T_29)) begin
                if (_T_34) begin
                  counter <= _T_5;
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      neighbour <= 32'h0;
    end else if (!(_T)) begin
      if (!(_T_1)) begin
        if (!(_T_8)) begin
          if (_T_14) begin
            neighbour <= {{24'd0}, io_dataRead[7:0]};
          end else if (_T_19) begin
            neighbour <= {{24'd0}, io_dataRead[7:0]};
          end else if (_T_24) begin
            neighbour <= {{24'd0}, io_dataRead[7:0]};
          end else if (_T_29) begin
            neighbour <= {{24'd0}, io_dataRead[7:0]};
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
