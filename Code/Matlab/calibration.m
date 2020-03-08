function[] = calibration(s)
%Author: Jake Chung
%Calibration algorithm for the robot arm 
%The process draws a line across the board to visually determine the
%distance of the board
%Intro to Robotics

%% define the screw matrix, this is from the physical arm.
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
M=[[1,0,0,0];[0,1,0,-10];[0,0,1,385.8+158];[0,0,0,1]];
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

%% move to write position to write a line across the board
%discretize to draw across the board
curTheta = [1.1351; -0.7118; 0.6565; -1.4174; 0.9265; 0.6013]; %generate path from this location
curPos = FKinSpace(M, Slist, curTheta);
curPos = curPos(1:3,4)' %get the current linear position
depth = 405;
pointOnBoard = [-150,depth,105];
firstPath = makePoints([curPos;pointOnBoard]) %make the first path to go to the first point of the first point on the board.
thetaList = zeros(6, length(firstPath(:,1)));
thetaList(:,1) = curTheta;
%get theta to move to a point on the board to start writing the verticle
%line
for i= 2:length(firstPath(:,1)) %start from 2 because the first theta is already the current theta
    [thetaList(:,i), success] = IKinSpace(Slist, M, buildT(firstPath(i,:)), thetaList(:,i-1), ew, ev);
    if success == 0
        fprintf('Generate path to first point fail. Check config!\n');
        return;
    end
end
%generate path of the horizontal line
endOfLine = [150,depth,105];
verLine = makePoints([pointOnBoard; endOfLine])
horLineTheta = zeros(6, length(verLine(:,1)));
horLineTheta(:,1) = thetaList(:,end);
%generate path to move to the end of line
for i= 2:length(verLine(:,1)) %start from 2 because the first theta is already the current theta
    [horLineTheta(:,i), success] = IKinSpace(Slist, M, buildT(verLine(i,:)), horLineTheta(:,i-1), ew, ev);
    if success == 0
        fprintf('Generate path to for horizontal line fails. Check config!\n');
        return;
    end
end
path = [thetaList';horLineTheta'];
%bring back to bound
path = angLim(path)
testTheta(path);
fprintf('Press any key to start moving to board\n')
pause;
%check bound
outOfBound = isOutOfBound(path);
move2Write(s);
pause(1);
if outOfBound == 1
    fprintf('Path is out of bound!\n')
    fclose(s);
    return;
else 
    fprintf('Checked Bound, Begin write\n');
    %convert the radians to bit to write
    path(:,1) = MXrad2bit(path(:,1));
    path(:,2) = MXrad2bit(path(:,2));
    path(:,3) = AXrad2bit(path(:,3));
    path(:,4) = AXrad2bit(path(:,4));
    path(:,5) = AXrad2bit(path(:,5));
    path(:,6) = AXrad2bit(path(:,6));
    for i = 1:length(path(:,1))
        fprintf('Loading %2.3f\n', i/length(path(:,1))*100);
        posSet(s,1,path(i,1));
        posSet(s,2,path(i,2));
        posSet(s,3,path(i,3));
        posSet(s,4,path(i,4));
        posSet(s,5,path(i,5));
        posSet(s,6,path(i,6));
        pause(0.5);
    end
    fprintf('Done write\n')
    
end
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

