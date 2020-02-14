#include <DynamixelWorkbench.h>

//intiate the dxl instance
DynamixelWorkbench dxl_wb;

//set up the variables to store the serial bytes
int high = -1;
int low = -1;
uint32_t get_data_1;
uint32_t get_data_2;

void setup() {
  //set ID for the Dynamixels
  uint8_t D1 = 1;

  //initialize the AX12's
  dxl_wb.init("1", 1000000); //always set this to be 1

  //ping the motors
  uint16_t model_number1 = 0;
  dxl_wb.ping(D1, &model_number1);

  Serial.begin(9600);
}

void loop(){

  //check to see if there's data in the buffer
  if(Serial.available() > 1)
  {
    low = Serial.read();
    high = Serial.read();

    //control the motor from serial communication
    dxl_wb.goalPosition(D1, (int32_t)(low+high*256));
    delay(2000);

    //check position of the dynamixel
    dxl_wb.readRegister(D1, (uint16_t)36, (uint16_t)1, &get_data_1);
    dxl_wb.readRegister(D1, (uint16_t)37, (uint16_t)1, &get_data_2);

    //write position back to serial
    Serial.write((uint8_t)get_data_1);
    Serial.write((uint8_t)get_data_2);
  }
}
