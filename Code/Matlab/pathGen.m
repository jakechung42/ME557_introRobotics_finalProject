function[thetaList] = pathGen(charArr)
%this function input is the character coordinates. The function
%generates the thetaList for the arm to move.
%Author: Jake Chung
%Winter 2020
%Introduction to Robotics

%the charArr input has -999 in the array. This -999 is to signify that the
%pen has to lift. The liftPen function is called when -999 value is
%encountered

%uncomment this section for testing
%[A,B,C,D,E,F,G,H,I,J] = trans(400);
% charArr =      [0   400     0;...
%      10   400     20;...
%      20   400     40;...
%      30   400     20;...
%      40   400     0;...
%   -999   400  -999;...
%      30   400     20;...
%      10   400     20];
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
r4 = [0;0;200.8+45];%add another piece to increase the length a link
w4 = [1;0;0];
v4 = cross(r4, w4);
%For joint 5:
r5 = [0;0;363.8+45];
w5 = [1;0;0];
v5 = cross(r5, w5);
%The M vector describes the end affector's position in the home position. 
M=[1,0,0,0;0,1,0,0;0,0,1,363.8+166.4+45;0,0,0,1];
%Define the screw axes for each of the motors:
S1 = [w1;v1];
S2 = [w2;v2];
S3 = [w3;v3];
S4 = [w4;v4];
S5 = [w5;v5];
%Slist is a row vector contains all of your s vectors.
Slist=[S1,S2,S3,S4,S5];

%discretize the input character array
disCharArr = makePoints(charArr); %comment this out when Johnathan's code is done.
%define IKinSpace characteristics
ew = 1;
ev = 0.01;
%initiate the counting variable
i = 1;
%need to determine theta list by randomly choosing the initial value
sucess = 0;
thetaList = [0 0 0 0 0];
while (sucess ~= 1)
    iTheta = -2*pi + (2*pi--2*pi).*rand(6,1);
    [path, sucess] = IKinSpace(Slist, M, buildT(disCharArr(1,:)), iTheta, ew, ev);
end
iTheta = path;
while (i ~= (length(disCharArr(:,1)))-1)
    if disCharArr(i,1)==-999
        path = liftPen(disCharArr(i-1,:), disCharArr(i+1,:), thetaList(i,:), Slist, M);
        i = i+1;
        iTheta = path(end,:)';
        thetaList = [thetaList; path];
    else 
        [path, sucess] = IKinSpace(Slist, M, buildT(disCharArr(i,:)), iTheta, ew, ev);
        if sucess == 0
            fprintf('Fail to make path!\n');
            return
        else 
            iTheta = path;
            thetaList = [thetaList; path'];
            i = i+1;
        end
    end
end
thetaList = thetaList(2:end,:);
thetaList = angLim(thetaList);
end

%% This function builds the T matrix using the "standard" orientation and the input translation vector
%the rotation matrix is R = [1 0 0; 0 0 -1; 0 1 0]
function[T_out] = buildT(vec)
R = [1 0 0; 0 0 -1; 0 1 0]';
T_out = [[R, vec']; 0 0 0 1];
end

%% This function limit the output from path to be within the -2pi to 2pi limit
function[path] = angLim(path)
numVec = length(path(:,1)); %length of the input path matrix
for m = 1:6
    for n = 1:numVec
        if (abs(path(n,m))>2*pi)
            path(n, m) = rem(path(n,m),2*pi); %check and bring back to be within the limit
        end
    end
end
end