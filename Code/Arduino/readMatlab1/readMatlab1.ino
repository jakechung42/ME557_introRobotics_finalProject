#include <DynamixelWorkbench.h>

//intiate the dxl instance
DynamixelWorkbench dxl_wb;

//set up the variables to store the serial bytes
int high = -1;
int low = -1;
uint8_t id;
uint32_t get_data_1;
uint32_t get_data_2;

void setup() {
  //set ID for the Dynamixels
  uint8_t D1 = 1;
  uint8_t D2 = 2;
  uint8_t D3 = 3;
  uint8_t D4 = 4;
  uint8_t D5 = 5;

  //initialize the AX12's
  dxl_wb.init("1", 1000000); //always set this to be 1

  //ping the motors
  uint16_t model_number1 = 0;
  dxl_wb.ping(D1, &model_number1);

  uint16_t model_number2 = 0;
  dxl_wb.ping(D2, &model_number2);

  uint16_t model_number3= 0;
  dxl_wb.ping(D3, &model_number3);

  uint16_t model_number4 = 0;
  dxl_wb.ping(D4, &model_number4);

  uint16_t model_number5 = 0;
  dxl_wb.ping(D5, &model_number5);
  
  Serial.begin(9600);
}

void loop(){

  //check to see if there's data in the buffer
  if(Serial.available() > 2)
  {
    id = Serial.read();
    low = Serial.read();
    high = Serial.read();
    
    
    //control the motor from serial communication
    dxl_wb.goalPosition(id, (int32_t)(low+high*256));
    delay(1000);

    //check position of the dynamixel
    dxl_wb.readRegister(id, (uint16_t)36, (uint16_t)1, &get_data_1);
    dxl_wb.readRegister(id, (uint16_t)37, (uint16_t)1, &get_data_2);

    //write position back to serial
    Serial.write((uint8_t)get_data_1);
    Serial.write((uint8_t)get_data_2);
  }
}
