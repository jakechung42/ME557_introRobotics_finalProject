function[angle] = posAsk(serial, id)
%this function asks for the position of a dynamixel. 
%the input is the serial and the motor id that is be asked for
%prepare the "id" byte to send to OpenCM9.04
sendByte = id+8;
pause(3)
fwrite(serial, sendByte);
%read the returned angular position
angle = (fread(serial, 1) + fread(serial, 1)*256);
end
