%main program for the robot arm. 
%it calls all the functions that we have done so far to draw the letters.

clc
clear

%{
    Section 1: Inquire the user for 5 letters and map them to the pre-define
    grid. The output of this section is a nx3 matrix that contains the
    discretized coordinates that make up the letters. This also includes the
    scaling and calibration.
%}
letter = input('Enter the 5 capitalized letters as a string with no space in between: ', 's');
letter = char(letter);
numLetter = zeros(1,5);
for i = 1:5
    switch letter(i)
        case 'A'
            numLetter(i) = 1;
        case 'B'
            numLetter(i) = 2;
        case 'C'
            numLetter(i) = 3;
        case 'D'
            numLetter(i) = 4;
        case 'E'
            numLetter(i) = 5;
        case 'F'
            numLetter(i) = 6;
        case 'G'
            numLetter(i) = 7;
        case 'H'
            numLetter(i) = 8;
        case 'I'
            numLetter(i) = 9;
        case 'J'
            numLetter(i) = 10;
        otherwise
            disp('Something is wrong with the input characters please check again')
            return;
    end
end
%{
    Section 2: generate the angles by using inversed kinematics
%}


%{
    Section 3: send the angles to the OpenCM
%}


