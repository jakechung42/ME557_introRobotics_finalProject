#include <DynamixelWorkbench.h>

DynamixelWorkbench dxl_wb;
#define currentID 2
void setup() {
  //uint8_t currentID = 1;
  //initialize the AX12
  dxl_wb.init("1", 1000000);
  //ping the motor
  uint16_t model_number = 0;
  //dxl_wb.ping(currentID, &model_number);
  dxl_wb.goalPosition(currentID, int32_t(512));
  delay(1000);

}

void loop() {
  dxl_wb.goalPosition(currentID, (int32_t)0);
  delay(1000);

  dxl_wb.goalPosition(currentID, (int32_t)1023);
  delay(1000);

}
