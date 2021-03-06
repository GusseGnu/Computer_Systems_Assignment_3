;buildInfoPackage: chisel3, version: 3.3.2, scalaVersion: 2.12.11, sbtVersion: 1.3.10
circuit SystemTop : 
  module DataMemory : 
    input clock : Clock
    input reset : Reset
    output io : {flip address : UInt<16>, dataRead : UInt<32>, flip writeEnable : UInt<1>, flip dataWrite : UInt<32>, flip testerEnable : UInt<1>, flip testerAddress : UInt<16>, testerDataRead : UInt<32>, flip testerWriteEnable : UInt<1>, flip testerDataWrite : UInt<32>}
    
    cmem memory : UInt<32>[65536] @[DataMemory.scala 18:20]
    when io.testerEnable : @[DataMemory.scala 22:24]
      read mport _T = memory[io.testerAddress], clock @[DataMemory.scala 24:37]
      io.testerDataRead <= _T @[DataMemory.scala 24:23]
      io.dataRead <= UInt<32>("h00") @[DataMemory.scala 26:17]
      when io.testerWriteEnable : @[DataMemory.scala 27:32]
        write mport _T_1 = memory[io.testerAddress], clock
        _T_1 <= io.testerDataWrite
        io.testerDataRead <= io.testerDataWrite @[DataMemory.scala 30:25]
        skip @[DataMemory.scala 27:32]
      skip @[DataMemory.scala 22:24]
    else : @[DataMemory.scala 32:16]
      read mport _T_2 = memory[io.address], clock @[DataMemory.scala 34:31]
      io.dataRead <= _T_2 @[DataMemory.scala 34:17]
      io.testerDataRead <= UInt<32>("h00") @[DataMemory.scala 36:23]
      when io.writeEnable : @[DataMemory.scala 37:26]
        write mport _T_3 = memory[io.address], clock
        _T_3 <= io.dataWrite
        io.dataRead <= io.dataWrite @[DataMemory.scala 40:19]
        skip @[DataMemory.scala 37:26]
      skip @[DataMemory.scala 32:16]
    
  module Accelerator : 
    input clock : Clock
    input reset : Reset
    output io : {flip start : UInt<1>, done : UInt<1>, address : UInt<16>, flip dataRead : UInt<32>, writeEnable : UInt<1>, dataWrite : UInt<32>}
    
    reg stateReg : UInt<3>, clock with : (reset => (reset, UInt<3>("h00"))) @[Accelerator.scala 18:25]
    reg addressReg : UInt<16>, clock with : (reset => (reset, UInt<16>("h00"))) @[Accelerator.scala 21:27]
    reg dataReg : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[Accelerator.scala 22:24]
    reg counter : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[Accelerator.scala 23:24]
    io.writeEnable <= UInt<1>("h00") @[Accelerator.scala 26:18]
    io.address <= UInt<16>("h00") @[Accelerator.scala 27:14]
    io.dataWrite <= dataReg @[Accelerator.scala 28:16]
    io.done <= UInt<1>("h00") @[Accelerator.scala 29:11]
    node _T = eq(UInt<3>("h00"), stateReg) @[Conditional.scala 37:30]
    when _T : @[Conditional.scala 40:58]
      when io.start : @[Accelerator.scala 34:22]
        stateReg <= UInt<3>("h01") @[Accelerator.scala 35:18]
        addressReg <= UInt<16>("h00") @[Accelerator.scala 36:20]
        skip @[Accelerator.scala 34:22]
      skip @[Conditional.scala 40:58]
    else : @[Conditional.scala 39:67]
      node _T_1 = eq(UInt<3>("h01"), stateReg) @[Conditional.scala 37:30]
      when _T_1 : @[Conditional.scala 39:67]
        io.address <= addressReg @[Accelerator.scala 41:18]
        node _T_2 = lt(addressReg, UInt<5>("h014")) @[Accelerator.scala 44:23]
        node _T_3 = gt(addressReg, UInt<9>("h017b")) @[Accelerator.scala 44:44]
        node _T_4 = or(_T_2, _T_3) @[Accelerator.scala 44:30]
        node _T_5 = eq(counter, UInt<5>("h013")) @[Accelerator.scala 44:63]
        node _T_6 = or(_T_4, _T_5) @[Accelerator.scala 44:52]
        node _T_7 = eq(counter, UInt<1>("h00")) @[Accelerator.scala 44:83]
        node _T_8 = or(_T_6, _T_7) @[Accelerator.scala 44:72]
        node _T_9 = bits(io.dataRead, 7, 0) @[Accelerator.scala 44:105]
        node _T_10 = eq(_T_9, UInt<1>("h00")) @[Accelerator.scala 44:112]
        node _T_11 = or(_T_8, _T_10) @[Accelerator.scala 44:91]
        when _T_11 : @[Accelerator.scala 44:121]
          dataReg <= UInt<1>("h00") @[Accelerator.scala 46:17]
          stateReg <= UInt<3>("h06") @[Accelerator.scala 47:18]
          skip @[Accelerator.scala 44:121]
        else : @[Accelerator.scala 48:18]
          stateReg <= UInt<3>("h02") @[Accelerator.scala 50:18]
          skip @[Accelerator.scala 48:18]
        skip @[Conditional.scala 39:67]
      else : @[Conditional.scala 39:67]
        node _T_12 = eq(UInt<3>("h02"), stateReg) @[Conditional.scala 37:30]
        when _T_12 : @[Conditional.scala 39:67]
          node _T_13 = sub(addressReg, UInt<5>("h014")) @[Accelerator.scala 57:32]
          node _T_14 = tail(_T_13, 1) @[Accelerator.scala 57:32]
          io.address <= _T_14 @[Accelerator.scala 57:18]
          node _T_15 = bits(io.dataRead, 7, 0) @[Accelerator.scala 58:23]
          node _T_16 = eq(_T_15, UInt<1>("h00")) @[Accelerator.scala 58:30]
          when _T_16 : @[Accelerator.scala 58:39]
            dataReg <= UInt<1>("h00") @[Accelerator.scala 59:17]
            stateReg <= UInt<3>("h06") @[Accelerator.scala 60:18]
            skip @[Accelerator.scala 58:39]
          else : @[Accelerator.scala 61:19]
            stateReg <= UInt<3>("h03") @[Accelerator.scala 62:18]
            skip @[Accelerator.scala 61:19]
          skip @[Conditional.scala 39:67]
        else : @[Conditional.scala 39:67]
          node _T_17 = eq(UInt<3>("h03"), stateReg) @[Conditional.scala 37:30]
          when _T_17 : @[Conditional.scala 39:67]
            node _T_18 = add(addressReg, UInt<5>("h014")) @[Accelerator.scala 67:32]
            node _T_19 = tail(_T_18, 1) @[Accelerator.scala 67:32]
            io.address <= _T_19 @[Accelerator.scala 67:18]
            node _T_20 = bits(io.dataRead, 7, 0) @[Accelerator.scala 68:23]
            node _T_21 = eq(_T_20, UInt<1>("h00")) @[Accelerator.scala 68:30]
            when _T_21 : @[Accelerator.scala 68:39]
              dataReg <= UInt<1>("h00") @[Accelerator.scala 69:17]
              stateReg <= UInt<3>("h06") @[Accelerator.scala 70:18]
              skip @[Accelerator.scala 68:39]
            else : @[Accelerator.scala 71:19]
              stateReg <= UInt<3>("h04") @[Accelerator.scala 72:18]
              skip @[Accelerator.scala 71:19]
            skip @[Conditional.scala 39:67]
          else : @[Conditional.scala 39:67]
            node _T_22 = eq(UInt<3>("h04"), stateReg) @[Conditional.scala 37:30]
            when _T_22 : @[Conditional.scala 39:67]
              node _T_23 = sub(addressReg, UInt<1>("h01")) @[Accelerator.scala 77:32]
              node _T_24 = tail(_T_23, 1) @[Accelerator.scala 77:32]
              io.address <= _T_24 @[Accelerator.scala 77:18]
              node _T_25 = bits(io.dataRead, 7, 0) @[Accelerator.scala 78:23]
              node _T_26 = eq(_T_25, UInt<1>("h00")) @[Accelerator.scala 78:30]
              when _T_26 : @[Accelerator.scala 78:39]
                dataReg <= UInt<1>("h00") @[Accelerator.scala 79:17]
                stateReg <= UInt<3>("h06") @[Accelerator.scala 80:18]
                skip @[Accelerator.scala 78:39]
              else : @[Accelerator.scala 81:19]
                stateReg <= UInt<3>("h05") @[Accelerator.scala 82:18]
                skip @[Accelerator.scala 81:19]
              skip @[Conditional.scala 39:67]
            else : @[Conditional.scala 39:67]
              node _T_27 = eq(UInt<3>("h05"), stateReg) @[Conditional.scala 37:30]
              when _T_27 : @[Conditional.scala 39:67]
                node _T_28 = add(addressReg, UInt<1>("h01")) @[Accelerator.scala 87:32]
                node _T_29 = tail(_T_28, 1) @[Accelerator.scala 87:32]
                io.address <= _T_29 @[Accelerator.scala 87:18]
                node _T_30 = bits(io.dataRead, 7, 0) @[Accelerator.scala 88:23]
                node _T_31 = eq(_T_30, UInt<1>("h00")) @[Accelerator.scala 88:30]
                when _T_31 : @[Accelerator.scala 88:39]
                  dataReg <= UInt<1>("h00") @[Accelerator.scala 89:17]
                  stateReg <= UInt<3>("h06") @[Accelerator.scala 90:18]
                  skip @[Accelerator.scala 88:39]
                else : @[Accelerator.scala 91:19]
                  dataReg <= UInt<8>("h0ff") @[Accelerator.scala 92:17]
                  stateReg <= UInt<3>("h06") @[Accelerator.scala 93:18]
                  skip @[Accelerator.scala 91:19]
                skip @[Conditional.scala 39:67]
              else : @[Conditional.scala 39:67]
                node _T_32 = eq(UInt<3>("h06"), stateReg) @[Conditional.scala 37:30]
                when _T_32 : @[Conditional.scala 39:67]
                  node _T_33 = add(addressReg, UInt<16>("h0190")) @[Accelerator.scala 98:32]
                  node _T_34 = tail(_T_33, 1) @[Accelerator.scala 98:32]
                  io.address <= _T_34 @[Accelerator.scala 98:18]
                  io.writeEnable <= UInt<1>("h01") @[Accelerator.scala 99:22]
                  node _T_35 = add(addressReg, UInt<16>("h01")) @[Accelerator.scala 101:32]
                  node _T_36 = tail(_T_35, 1) @[Accelerator.scala 101:32]
                  addressReg <= _T_36 @[Accelerator.scala 101:18]
                  node _T_37 = eq(counter, UInt<5>("h013")) @[Accelerator.scala 103:20]
                  when _T_37 : @[Accelerator.scala 103:29]
                    counter <= UInt<32>("h00") @[Accelerator.scala 104:17]
                    skip @[Accelerator.scala 103:29]
                  else : @[Accelerator.scala 105:18]
                    node _T_38 = add(counter, UInt<32>("h01")) @[Accelerator.scala 106:28]
                    node _T_39 = tail(_T_38, 1) @[Accelerator.scala 106:28]
                    counter <= _T_39 @[Accelerator.scala 106:17]
                    skip @[Accelerator.scala 105:18]
                  node _T_40 = eq(addressReg, UInt<16>("h018f")) @[Accelerator.scala 109:23]
                  when _T_40 : @[Accelerator.scala 109:40]
                    stateReg <= UInt<3>("h07") @[Accelerator.scala 110:18]
                    skip @[Accelerator.scala 109:40]
                  else : @[Accelerator.scala 111:19]
                    stateReg <= UInt<3>("h01") @[Accelerator.scala 112:18]
                    skip @[Accelerator.scala 111:19]
                  skip @[Conditional.scala 39:67]
                else : @[Conditional.scala 39:67]
                  node _T_41 = eq(UInt<3>("h07"), stateReg) @[Conditional.scala 37:30]
                  when _T_41 : @[Conditional.scala 39:67]
                    io.done <= UInt<1>("h01") @[Accelerator.scala 117:15]
                    stateReg <= UInt<3>("h07") @[Accelerator.scala 118:16]
                    skip @[Conditional.scala 39:67]
    
  module SystemTop : 
    input clock : Clock
    input reset : UInt<1>
    output io : {done : UInt<1>, flip start : UInt<1>, flip testerDataMemEnable : UInt<1>, flip testerDataMemAddress : UInt<16>, testerDataMemDataRead : UInt<32>, flip testerDataMemWriteEnable : UInt<1>, flip testerDataMemDataWrite : UInt<32>}
    
    inst dataMemory of DataMemory @[SystemTop.scala 18:26]
    dataMemory.clock <= clock
    dataMemory.reset <= reset
    inst accelerator of Accelerator @[SystemTop.scala 19:27]
    accelerator.clock <= clock
    accelerator.reset <= reset
    io.done <= accelerator.io.done @[SystemTop.scala 23:11]
    accelerator.io.start <= io.start @[SystemTop.scala 24:24]
    accelerator.io.dataRead <= dataMemory.io.dataRead @[SystemTop.scala 27:27]
    dataMemory.io.address <= accelerator.io.address @[SystemTop.scala 28:25]
    dataMemory.io.dataWrite <= accelerator.io.dataWrite @[SystemTop.scala 29:27]
    dataMemory.io.writeEnable <= accelerator.io.writeEnable @[SystemTop.scala 30:29]
    dataMemory.io.testerAddress <= io.testerDataMemAddress @[SystemTop.scala 33:31]
    io.testerDataMemDataRead <= dataMemory.io.testerDataRead @[SystemTop.scala 34:28]
    dataMemory.io.testerDataWrite <= io.testerDataMemDataWrite @[SystemTop.scala 35:33]
    dataMemory.io.testerEnable <= io.testerDataMemEnable @[SystemTop.scala 36:30]
    dataMemory.io.testerWriteEnable <= io.testerDataMemWriteEnable @[SystemTop.scala 37:35]
    
