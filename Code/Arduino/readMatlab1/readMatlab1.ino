#include <DynamixelWorkbench.h>

/*
 * This script is for the serial communication with Matlab.
 * It has 2 parts, depending on the bit sent, it wil be either reading or requesting position.
 * Author: Jake Chung
 * Winter 2020
 * Portland State University
 */
//intiate the dxl instance
DynamixelWorkbench dxl_wb;

//set up the variables to store the serial bytes
int high = -1;
int low = -1;
uint8_t id;
uint8_t firstByte;
uint32_t get_data_1;
uint32_t get_data_2;

void setup() {
  //set ID for the Dynamixels
  uint8_t D1 = 1;
  uint8_t D2 = 2;
  uint8_t D3 = 3;
  uint8_t D4 = 4;
  uint8_t D5 = 5;
  uint8_t D6 = 6;
  
  //initialize the AX12's
  dxl_wb.init("1", 1000000); //always set this to be 1

  //ping the motors
  uint16_t model_number1 = 0;
  dxl_wb.ping(D1, &model_number1);

  uint16_t model_number2 = 0;
  dxl_wb.ping(D2, &model_number2);

  uint16_t model_number3 = 0;
  dxl_wb.ping(D3, &model_number3);

  uint16_t model_number4 = 0;
  dxl_wb.ping(D4, &model_number4);

  uint16_t model_number5 = 0;
  dxl_wb.ping(D5, &model_number5);

  uint16_t model_number6 = 0;
  dxl_wb.ping(D6, &model_number6);
 
  Serial.begin(115200);
}

void loop(){

  //read the first byte to see if wants to move or get position.
  if(Serial.available() > 0)
  {
    firstByte = Serial.read(); //read the first byte.
    if (firstByte > (uint8_t)7)
    {
        //decompose first byte to get the id
        id = firstByte - 8;
        //read the register and send the position back to serial
        dxl_wb.readRegister(id, (uint16_t)36, (uint16_t)1, &get_data_1);
        dxl_wb.readRegister(id, (uint16_t)37, (uint16_t)1, &get_data_2);
        //write position back to serial
        Serial.write((uint8_t)get_data_1);
        Serial.write((uint8_t)get_data_2);
    }
    else //otherwise read the byte and firstByte would just be the motor ID
    {
        id = firstByte;

        while(Serial.available() <= 1) {} //wait for the next 2 bytes for the position
        
        //if(Serial.available() > 1) //wait for the next 2 bytes to read
        //{   
            low = Serial.read();
            high = Serial.read();
            //control the motor as requested in the serial
            dxl_wb.goalPosition(id, (int32_t)(low+high*256));
            delay(200); //change the delay to potentially make it move faster. Need to experiment with this value
            //check position of the dynamixel
            dxl_wb.readRegister(id, (uint16_t)36, (uint16_t)1, &get_data_1);
            dxl_wb.readRegister(id, (uint16_t)37, (uint16_t)1, &get_data_2);
            //write position back to serial
            Serial.write((uint8_t)get_data_1);
            Serial.write((uint8_t)get_data_2);
        //}
        
    }
  }
}
