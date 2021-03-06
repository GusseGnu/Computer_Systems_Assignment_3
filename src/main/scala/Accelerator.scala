import chisel3._
import chisel3.util._

class Accelerator extends Module {
  val io = IO(new Bundle {
    val start = Input(Bool())
    val done = Output(Bool())

    val address = Output(UInt(16.W))
    val dataRead = Input(UInt(32.W))
    val writeEnable = Output(Bool())
    val dataWrite = Output(UInt(32.W))

  })

  //State enum and register
  val idle :: read :: checkUp :: checkDown :: checkLeft :: checkRight :: write :: done :: Nil = Enum(8)
  val stateReg = RegInit(idle)

  //Support registers
  val addressReg = RegInit(0.U(16.W))
  val dataReg = RegInit(0.U(32.W))
  val counter = RegInit(0.U(32.W))

  // Default values
  io.writeEnable := false.B
  io.address := 0.U(16.W)
  io.dataWrite := dataReg
  io.done := false.B

  // FSMD switch
  switch(stateReg) {
    is(idle) {
      when(io.start) {
        stateReg := read
        addressReg := 0.U(16.W)
      }
    }

    is(read) {
      io.address := addressReg
      // Check borders from: Up - Down - Left - Right
      // Check if pixel is black
      when(addressReg < 20.U || addressReg > 379.U || counter === 19.U || counter === 0.U || io.dataRead(7, 0) === 0.U) {
        // Pixel is black
        dataReg := 0.U
        stateReg := write
      }.otherwise{
        // Pixel is white
        stateReg := checkUp
      }
    }

    // Check if any neighbour pixels are black
    // In the order: Up - Down - Left - Right
    is(checkUp) {
      io.address := addressReg - 20.U
      when(io.dataRead(7, 0) === 0.U) {
        dataReg := 0.U
        stateReg := write
      }.otherwise {
        stateReg := checkDown
      }
    }

    is(checkDown) {
      io.address := addressReg + 20.U
      when(io.dataRead(7, 0) === 0.U) {
        dataReg := 0.U
        stateReg := write
      }.otherwise {
        stateReg := checkLeft
      }
    }

    is(checkLeft) {
      io.address := addressReg - 1.U
      when(io.dataRead(7, 0) === 0.U) {
        dataReg := 0.U
        stateReg := write
      }.otherwise {
        stateReg := checkRight
      }
    }

    is(checkRight) {
      io.address := addressReg + 1.U
      when(io.dataRead(7, 0) === 0.U) {
        dataReg := 0.U
        stateReg := write
      }.otherwise {
        dataReg := 255.U
        stateReg := write
      }
    }

    is(write) {
      io.address := addressReg + 400.U(16.W)
      io.writeEnable := true.B
      // Increment address
      addressReg := addressReg + 1.U(16.W)
      // Increment counter by 1 or reset to 0
      when(counter === 19.U){
        counter := 0.U(32.W)
      }.otherwise{
        counter := counter + 1.U(32.W)
      }

      when(addressReg === 399.U(16.W)) {
        stateReg := done
      }.otherwise {
        stateReg := read
      }
    }

    is(done) {
      io.done := true.B
      stateReg := done
    }
  }

}
