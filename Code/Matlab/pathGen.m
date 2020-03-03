function[thetaList] = pathGen(s, charArr)
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

%define IKinSpace characteristics
ew = 1;
ev = 0.1;

%determine the very first point to start writing by using the current
%postion and then discritize the the board to start writing.
curTheta = getAllAngle(s); %comment this out for test run without the arm
curTheta(1) = MXbit2rad(curTheta(1));
curTheta(2) = MXbit2rad(curTheta(2));
curTheta(3) = AXbit2rad(curTheta(3));
curTheta(4) = AXbit2rad(curTheta(4));
curTheta(5) = AXbit2rad(curTheta(5));
curTheta(6) = AXbit2rad(curTheta(6));

% curTheta = [1.1351; -0.7118; 0.6565; -1.4174; 0.9265; 0.6013]; %comment
% this out for real run
curPos = FKinSpace(M, Slist, curTheta);
curPos = curPos(1:3,4)'; %get the current linear position
firstPath = makePoints([curPos;charArr(1,:)]); %make the first path to go to the first point of the first letter.
thetaList = zeros(6, length(firstPath(:,1)));
thetaList(:,1) = curTheta;
for i= 2:length(firstPath(:,1)) %start from 2 because the first theta is already the current theta
    [thetaList(:,i), success] = IKinSpace(Slist, M, buildT(firstPath(i,:)), thetaList(:,i-1), ew, ev);
    if success == 0
        fprintf('Generate path to first point fail. Check config!\n');
        return;
    end
end
iTheta = thetaList(:,end);
thetaList = thetaList';
%initiate the counting variable
i = 1;
while (i ~= (length(charArr(:,1)))-1)
    if charArr(i,1)==-999 %perform lift pen when for -999
        path = liftPen(charArr(i-1,:), charArr(i+1,:), thetaList(i,:), Slist, M);
        i = i+1;
        iTheta = path(end,:)';
        thetaList = [thetaList; path];
    else 
        [path, success] = IKinSpace(Slist, M, buildT(charArr(i,:)), iTheta, ew, ev);
        if success == 0 %if cannot find path, perturb the initial guess to try to find path again
            fprintf('Fail to make path, going to guess again!\n');
            k = 1;
            while (success==0)
                perturb = 0.03+(0-0.03).*rand(6,1);
                iTheta = iTheta+perturb;
                [path, success] = IKinSpace(Slist, M, buildT(charArr(i,:)), iTheta, ew, ev);
                if k == 10 %perturb it only 5 times
                    fprintf('Still cannot get solution, cancel operation\n');
                    return;
                end
                k=  k+1;
            end
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