import chisel3._
import chisel3.util._

class Accelerator extends Module {
  val io = IO(new Bundle {
    val start = Input(Bool())
    val done = Output(Bool())

    val address = Output(UInt (16.W))
    val dataRead = Input(UInt (32.W))
    val writeEnable = Output(Bool ())
    val dataWrite = Output(UInt (32.W))

  })

  //Creating components
  val dataMemory = Module(new DataMemory())

  //State enum and register
  val idle :: read :: checkBlackPixel :: checkNeighbours :: blackPixel :: whitePixel :: write :: done :: Nil = Enum (8)
  val stateReg = RegInit(idle)

  //Support registers
  val addressReg = RegInit(0.U(16.W))
  val dataReg = RegInit(0.U(32.W))

  // Wires for Neighbour pixels
  var center = RegInit(0.U(32.W))
  var left = RegInit(0.U(32.W))
  var right = RegInit(0.U(32.W))
  var up = RegInit(0.U(32.W))
  var down = RegInit(0.U(32.W))

  //Default values
  dataMemory.io.writeEnable := false.B
  dataMemory.io.address := 0.U(16.W)
  dataMemory.io.dataWrite := dataReg
  io.done := false.B

  //FSMD switch
  switch(stateReg) {
    is(idle) {
      when(io.start) {
        stateReg := read
        addressReg := 0.U(16.W)
      }
    }

    is(read) {
      dataMemory.io.address := addressReg
      stateReg := checkBlackPixel
    }

    is(checkBlackPixel) {
      // check borders
      when(addressReg % 19.U === 0.U){
        dataMemory.io.dataWrite := 0.U
        stateReg := write
      }
      when(addressReg % 20.U === 0.U){
        dataMemory.io.dataWrite := 0.U
        stateReg := write
      }
      when(addressReg < 20.U & addressReg > 379.U){
        dataMemory.io.dataWrite := 0.U
        stateReg := write
      }
      // Check if pixel is black
      when(dataMemory.io.dataRead(7,0) === 0.U){
        dataMemory.io.dataWrite := 0.U
        stateReg := write
      }
      // Pixel is white
      stateReg := checkNeighbours
    }

    is(checkNeighbours) {
      // left
      dataMemory.io.address := addressReg - 1.U
      left := dataMemory.io.dataRead(7,0)
      // right
      dataMemory.io.address := addressReg + 1.U
      right := dataMemory.io.dataRead(7,0)
      // up
      dataMemory.io.address := addressReg - 20.U
      up := dataMemory.io.dataRead(7,0)
      // down
      dataMemory.io.address := dataMemory.io.address + 20.U
      down := dataMemory.io.dataRead(7,0)

      // Assigns color of output pixel
      when(left === 255.U & right === 255.U & up === 255.U & down === 255.U){
        dataMemory.io.dataWrite := 255.U
        stateReg := write
      } .otherwise{
        dataMemory.io.dataWrite := 0.U
        stateReg := write
      }
    }

    is(write) {
      dataMemory.io.address := addressReg + 400.U(16.W)
      dataMemory.io.writeEnable := true.B
      // Increment address
      addressReg := addressReg + 1.U(16.W)
      when(addressReg === 399.U(16.W)) {
        stateReg := done
      } .otherwise{
        stateReg := read
      }
    }

    is(done) {
      io.done := true.B
      stateReg := done
    }
  }


}
