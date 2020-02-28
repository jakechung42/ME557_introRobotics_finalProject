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
disCharArr = makePoints(charArr)
%define IKinSpace characteristics
ew = 1;
ev = 1;
%initiate the counting variable
i = 1;
%need to determine theta list by randomly choosing the initial value
sucess = 0;
while (sucess ~= 1)
    iTheta = -2*pi + (2*pi--2*pi).*rand(5,1);
    [path, sucess] = IKinSpace(Slist, M, buildT(disCharArr(1,:)), iTheta, ew, ev);
end
iTheta = path;
while (i ~= (length(disCharArr(:,1))))
    i
    if disCharArr(i,:)==-999
        path = liftPen(disCharArr(:,i-1), disCharArr(:,i+1));
        i = i+1;
    else 
        [path, sucess] = IKinSpace(Slist, M, buildT(disCharArr(i,:)), iTheta, ew, ev)
        if sucess == 0
            fprintf('Fail to make path!');
            pause
        end
    end
    iTheta = path;
    thetaList = [thetaList; path'];
    i = i+1;
end
end

%% this function generate the trajectory for the lift pen action.
%This function is called when there's a -999 value detected.
function[out] = liftPen(p1, p2)
%p1 is the point on the board 
%p2 is the next point that the tip of then pen needs to move to
%lift the pen from the surface of the whiteboard
p1(1,2) = p1(1,2)-10; %move away from the board 10mm
L = norm(p2-p1); %get the length of the vector to move to the next vertex
uv = (p2-p1)/L; %unit vector
np = 4; %number of points to get to p2 increase this number if life pen start moving chaotically
dL = L/np;
iTheta = [0.1; 0.1; 0.1; 0.1; 0.1];
ew = 0.1;
ev = 0.1;
out = [0; 0; 0];
for i = 1:np
    stp = p1+uv*dL;
    [path, sucess] = IKinSpace(Slist, M, buildT(stp), iTheta, ew, ev);
    if sucess == 0
        fprintf('Fail to make path for lift pen!\n')
        pause;
    end
    path = path';
    out(:, end+1) = path;
end
out = out(:, 2:end);
end

%% This function builds the T matrix using the "standard" orientation and the input translation vector
%the rotation matrix is R = [1 0 0; 0 0 -1; 0 1 0]
function[T_out] = buildT(vec)
R = [1 0 0; 0 0 -1; 0 1 0];
T_out = [[R, vec']; 0 0 0 1];
end