function[T] = testTheta(thetaList)
%this program test the theta list output of the pathGen function by
%calculating the T(theta) matrix using forward kinematics and plot the points
%Author: Jake Chung
%Winter 2020
%Intro to Robotics
close all
%use the same definition of sList and M
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
r4 = [0;0;200.8];%add another piece to increase the length a link
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
%length of matrix thetaList
L = length(thetaList(:,1));
%perform the forward kinematics
T = zeros(3,L);
for i = 1:L
    T_temp = FKinSpace(M, Slist, thetaList(i, :)');
    T(:,i) = T_temp(1:3,4);
end
plot3(T(1,:),T(2,:),T(3,:),'o-')
T = T';
grid on
xlabel('x')
ylabel('y')
zlabel('z')
figure %plot x-z
plot(T(:,1), T(:,3),'o-')
T(1,:)
% xlim([-16 40])
% ylim([-10 50])
grid on
end