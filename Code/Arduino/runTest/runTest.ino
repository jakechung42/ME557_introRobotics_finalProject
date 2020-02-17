#include <DynamixelWorkbench.h>

//intiate the dxl instance
DynamixelWorkbench dxl_wb;

void setup() {
  //set ID for the Dynamixels
  uint8_t D1 = 3;

  //initialize the AX12's
  dxl_wb.init("1", 1000000); //always set this to be 1

  //ping the motors
  uint16_t model_number1 = 0;
  dxl_wb.ping(D1, &model_number1);
    
  //center the motors
  dxl_wb.goalPosition(D1, (int32_t)512);
  delay(500);
}

void loop() {
  //Serial.begin(9600);
  //while(!Serial);  
  //Command the motors to run


}
