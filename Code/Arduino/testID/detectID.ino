#include <DynamixelWorkbench.h>

DynamixelWorkbench dxl_wb;


void setup() {
  uint8_t currentID = 2;
  int32_t get_data = 0;
  Serial.begin(9600);
  while(!Serial);
  delay(100);
  //initialize the AX12
  dxl_wb.init("1", 1000000); //always set this to be 1
  uint16_t model_number = 0;
  dxl_wb.ping(currentID, &model_number);

  //read the current ID
  dxl_wb.itemRead(currentID, "ID", &get_data);
  delay(100);
  Serial.print("Current ID: ");
  Serial.println(get_data);
}

void loop() {

}
