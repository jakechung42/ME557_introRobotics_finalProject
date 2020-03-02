function[bit] = MXrad2bit(rad)
%this function converts the radians to bit of the model to the physical 
bit = 2048/pi*rad+2048;
end