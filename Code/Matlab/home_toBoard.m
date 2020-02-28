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


%The following five lines stores angles that each motor must rotate by in order to be at the desired z distance: des_pos_n where n is the id of the motor.

%The following line is the conversion factor for MX64 motor. Bits to
%radians. 
Mx_to_radians=[2*pi]/[4096];

%The following line is the conversion factor for Ax12. Bits to radians.
Ax_to_radians=[2*pi]/[1024];


%The following lines describe the current position of each joint in
%radians. 
des_pos_one=posAsk(s,1)*Mx_to_radians;
des_pos_two=posAsk(s,2)*Mx_to_radians;
des_pos_three=posAsk(s,3)*Ax_to_radians;
des_pos_four=posAsk(s,4)*Ax_to_radians;
des_pos_five=posAsk(s,5)*Ax_to_radians;

% %Set the position of each of the motors to arbitrary point.

% posSet(s,1,posAsk(s,1))
% posSet(s,2,posAsk(s,2))
% posSet(s,3,posAsk(s,3))
% posSet(s,4,posAsk(s,4))
% posSet(s,5,posAsk(s,5))


thetalist=[des_pos_one-pi;des_pos_two-pi;des_pos_three-pi;des_pos_four-pi;des_pos_five-pi];
FKinSpace(M, Slist, thetalist)



