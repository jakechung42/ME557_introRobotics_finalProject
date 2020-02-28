%main program for the robot arm. 
%it calls all the functions that we have done so far to draw the letters.

clc
clear
close all


%call the letters 
[A,B,C,D,E,F,G,H,I,J] = trans(400);

%discretize the character 
discretChar = makePoints(A);


