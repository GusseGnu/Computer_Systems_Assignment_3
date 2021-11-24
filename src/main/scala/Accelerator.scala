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
  val idle :: read :: checkBlackPixel :: checkUp :: checkDown :: checkLeft :: checkRight :: write :: done :: Nil = Enum(9)
  val stateReg = RegInit(idle)

  //Support registers
  val addressReg = RegInit(0.U(16.W))
  val dataReg = RegInit(0.U(32.W))
  var counter = RegInit(0.U(32.W))
  var neighbour = RegInit(0.U(32.W))

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
      when(counter === 19.U) {
        dataReg := 0.U
        counter := 0.U
        stateReg := write
      }
      when(counter === 0.U) {
        dataReg := 0.U
        counter := counter + 1.U
        stateReg := write
      }
      counter := counter + 1.U
      stateReg := checkBlackPixel
    }

    is(checkBlackPixel) {
      // check borders
      when(addressReg < 20.U || addressReg > 379.U) {
        dataReg := 0.U
        stateReg := write
      }
      // Check if pixel is black
      when(io.dataRead(7, 0) === 0.U) {
        dataReg := 0.U
        stateReg := write
      }
      // Pixel is white
      stateReg := checkUp
    }

    is(checkUp) {
      io.address := addressReg - 20.U
      neighbour := io.dataRead(7, 0)
      when(neighbour === 0.U) {
        dataReg := 0.U
        stateReg := write
      }.otherwise {
        stateReg := checkDown
      }
    }
    is(checkDown) {
      io.address := addressReg + 20.U
      neighbour := io.dataRead(7, 0)
      when(neighbour === 0.U) {
        dataReg := 0.U
        stateReg := write
      }.otherwise {
        stateReg := checkLeft
      }
    }
    is(checkLeft) {
      io.address := addressReg - 1.U
      neighbour := io.dataRead(7, 0)
      when(neighbour === 0.U) {
        dataReg := 0.U
        stateReg := write
      }.otherwise {
        stateReg := checkRight
      }
    }
    is(checkRight) {
      io.address := addressReg + 1.U
      neighbour := io.dataRead(7, 0)
      when(neighbour === 0.U) {
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
      counter := counter + 1.U(32.W)
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
