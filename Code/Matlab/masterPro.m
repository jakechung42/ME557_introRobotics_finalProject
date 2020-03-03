%main program for the robot arm. 
%it calls all the functions that we have done so far to draw the letters.

% sCloseAll();%close all previous ports before clearing variables
clc
clear
COM = 'COM12';
BaudRate = 115200;
s = serial(COM, 'BaudRate', BaudRate);
% fopen(s);
%{
    Section 1: Inquire the user for 5 letters and map them to the pre-define
    grid. The output of this section is a nx3 matrix that contains the
    discretized coordinates that make up the letters. This also includes the
    scaling and calibration.
%}
scale = 50/4; %physical scale for the letters
depth = 398; %get from the calibration
letter = input('Enter the 5 capitalized letters as a string with no space in between: ', 's');
coord = shift(letter, scale, 400);
%{
    Section 2: move the pen into writing position
%}
% sayA(s)
% homeAll(s)
% move2Write(s)
fprintf('Any key to start write, make sure that it'' in write position\n');
pause;
%{
    Section 3: generate thetaList to write the letter starting from the
    writing postion.
%}

path = pathGen(s, coord); %the screw matrix is builts in the pathGen function
outOfBound = isOutOfBound(path);
testTheta(path);
fprintf('Space bar to continue\n')
pause();

%{
    Section 3: send the angles to the OpenCM
%}

%check if out of bound
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
        posSet(s,1,path(i,1));
        posSet(s,2,path(i,2));
        posSet(s,3,path(i,3));
        posSet(s,4,path(i,4));
        posSet(s,5,path(i,5));
        posSet(s,6,path(i,6));
        pause(0.3);
    end
    fclose(s);
end
