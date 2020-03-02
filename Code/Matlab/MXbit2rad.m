function[rad] = MXbit2rad(bit)
%this function converts the radians to bit of the model to the physical 
rad = pi/2048*(bit-2048);
end