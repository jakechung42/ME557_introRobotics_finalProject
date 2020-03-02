function[bit] = AXrad2bit(rad)
%this function converts the bit to radians of the model to the physical
bit=512/pi*rad+512;
end