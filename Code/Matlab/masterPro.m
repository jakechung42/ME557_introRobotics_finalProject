%main program for the robot arm. 
%it calls all the functions that we have done so far to draw the letters.

clc
clear

%{
    Section 1: Inquire the user for 5 letters and map them to the pre-define
    grid. The output of this section is a nx3 matrix that contains the
    discretized coordinates that make up the letters. This also includes the
    scaling and calibration.
%}
scale = 50/4; %physical scale for the letters
depth = 400; %get from the calibration
letter = input('Enter the 5 capitalized letters as a string with no space in between: ', 's');
coord = shift(letter, scale, 400);
%{
    Section 2: generate the angles by using inversed kinematics
%}
path = pathGen(coord); %the screw matrix is builts in the pathGen function
testTheta(path);
%{
    Section 3: send the angles to the OpenCM
%}


