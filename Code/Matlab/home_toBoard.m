function []= home_toBoard(s)
%Collect the angles the motor needs to make in order to reach the board. 

addpath("C:\Users\vladi\OneDrive\Desktop\Winter 2020\Robotics\Hunt's Github Code");

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
r4 = [0;0;246.8];
w4 = [1;0;0];
v4 = cross(r4, w4);

%For joint 5:
r5 = [0;0;316.6];
w5 = [0;1;0];
v5 = cross(r5, w5);

%For joint 5:
r6 = [0;0;385.8];
w6 = [1;0;0];
v6 = cross(r6, w6);



%The M vector describes the end affector's position in the home position. 
M=[[1,0,0,0];[0,1,0,0];[0,0,1,385.8+159.7];[0,0,0,1]];

%Define the screw axes for each of the motors:
S1 = [w1;v1];
S2 = [w2;v2];
S3 = [w3;v3];
S4 = [w4;v4];
S5 = [w5;v5];
S6 = [w6;v6];

%Slist is a row vector contains all of your s vectors.
Slist=[S1,S2,S3,S4,S5,S6];


%The following five lines stores angles that each motor must rotate by in order to be at the desired z distance: des_pos_n where n is the id of the motor.

%The following line is the conversion factor for MX64 motor. Bits to
%radians. 
Mx_to_radians=[2*pi]/[4096];

%The following line is the conversion factor for Ax12. Bits to radians.
Ax_to_radians=[2*pi]/[1024];


%The following lines describe the current position of each joint in
%radians. 
Initial_pos_one=posAsk(s,1)*Mx_to_radians
Initial_pos_two=posAsk(s,2)*Mx_to_radians
Initial_pos_three=posAsk(s,3)*Ax_to_radians
Initial_pos_four=posAsk(s,4)*Ax_to_radians
Initial_pos_five=posAsk(s,5)*Ax_to_radians
Initial_pos_six=posAsk(s,6)*Ax_to_radians

% %Set the position of each of the motors to arbitrary point.

posSet(s,1,3.1109)
posSet(s,2,2.5219)
posSet(s,3,3.0434)
posSet(s,4,0.9879)
posSet(s,5,3.1048)
posSet(s,6,4.0436)

% 
% thetalist=[Initial_pos_one-pi;Initial_pos_two-pi;Initial_pos_three-pi;Initial_pos_four-pi;Initial_pos_five-pi;Initial_pos_six-pi];
% FKinSpace(M, Slist, thetalist)



