%this function send a position to the serial port to move the dynamexials
function[position] = posSet(serial, id, goalPos)

    low = mod(goalPos, 256);
    high = floor(goalPos/256);

    fwrite(serial, id);
    fwrite(serial, low);
    fwrite(serial, high);
    
    
    position = (fread(serial, 1) + fread(serial, 1)*256);
end