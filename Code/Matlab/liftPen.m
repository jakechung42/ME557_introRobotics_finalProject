function[out] = liftPen(p1, p2, preTheta, Slist, M)
%Author: Jake Chung
%Introduction to Robotics - Winter 2020
%Robot arm final project.
%This function generate the trajectory for the lift pen action.
%This function is called when there's a -999 value detected in an
%letter-array or when it's called to move from one letter to the next.
%Inputs of the function are the following:
%- The starting point of the pen
%- The ending point of the pen
%- The T(theta) of the first point 
%- sList
%- the M matrix
%The reliability of this depends on the T(theta) input. If the intial guess
%is poor, the inverse kinematics won't give a solution


%lift the pen from the surface of the whiteboard
amountMoveAway = 10;
p1(1,2) = p1(1,2)-amountMoveAway; %move away from the board some amount
L = norm(p2-p1); %get the length of the vector to move to the next vertex
uv = (p2-p1)/L; %unit vector
np = 8; %number of points to get to p2 increase this number if life pen start moving chaotically
dL = L/np;
ew = 1;
ev = 0.1;
out = [0, 0, 0, 0, 0];
%first the tip of the pen has to move to the new p1 off of the whiteboard
[path1st, sucess] = IKinSpace(Slist, M, buildT(p1), preTheta', ew, ev);
if sucess == 0
    fprintf('Fail to make path for intial point for lifting pen!\n')
    return;
else 
    preTheta = path1st;
end
%start inverse kinematics for the rest of the path to the next point
for i = 1:np
    stp = p1+i*uv*dL;
    [path, sucess] = IKinSpace(Slist, M, buildT(stp), preTheta, ew, ev);
    if sucess == 0
        fprintf('Fail to make path for lift pen!\n')
        return;
    end
    path = path';
    out(end+1,:) = path;
    preTheta = path'; %give new initial guess
end
out = out(2:end,:);
out = [path1st';out];
end