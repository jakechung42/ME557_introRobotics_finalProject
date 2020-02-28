function[thetaList] = pathGen(charArr)
%this function input is the character coordinates. The function
%generates the thetaList for the arm to move.
%Author: Jake Chung
%Winter 2020
%Introduction to Robotics

%the charArr input has -999 in the array. This -999 is to signify that the
%pen has to lift. Need to program this in the inverse kinematics.

%first need to discretize the points.
%can change the discretize resoltion in the function

%define the screw matrix, this is from the physical arm.
%For joint 1:
r1 = [0;0;0];
w1 = [0;0;1];
v1 = cross(r1, w1);
%For joint 2:
r2 = [0;0;55.4];
w2 = [1;0;0];
v2 = cross(r2, w2);

%For joint 3:
r3 = [0;0;132.4];
w3 = [0;1;0];
v3 = cross(r3, w3);
%For joint 4:
r4 = [0;0;200.8];
w4 = [1;0;0];
v4 = cross(r4, w4);
%For joint 5:
r5 = [0;0;363.8];
w5 = [1;0;0];
v5 = cross(r5, w5);
%The M vector describes the end affector's position in the home position. 
M=[1,0,0,0;0,1,0,0;0,0,1,363.8+166.4;0,0,0,1];
%Define the screw axes for each of the motors:
S1 = [w1;v1];
S2 = [w2;v2];
S3 = [w3;v3];
S4 = [w4;v4];
S5 = [w5;v5];
%Slist is a row vector contains all of your s vectors.
Slist=[S1,S2,S3,S4,S5];
%discretize the input character array
disCharArr = makePoints(charArr);
%initiate the counting variable
i = 1;
while (i ~= (length(disCharArr(:,1))))
    if disCharArr(:,1)==-999
        
    
    