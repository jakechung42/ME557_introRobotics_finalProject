function[] = sayA(s)
%this function calls the Robot Arm to open up the calmp to insert the pen

%bring the arm to home position first
homeAll(s);

%bring the arm to position for insertion 
posSet(s, 2, 2772);

%go slow for the second motor
%set increment 
numStp = 10;
for i = 0:numStp
    step = 512+i*(843-512)/numStp;
    posSet(s, 4, step);
end

%go slow for the third motor
for i = 0:numStp
    step = 512-i*(512-205)/numStp;
    posSet(s, 5, step);
end

%in position for pen insertion. Now wait for user to releaser to home
%position
fprintf('Press any key to go back to home position.\n')
pause;
%bring the end effector back quickly to grip onto the pen
posSet(s, 5, 512);
pause(1);
currentPos4 = posAsk(s, 4);
pause(1);
currentPos2 = posAsk(s, 2);
pause(1);
for i = 0:numStp
    step4 = currentPos4-i*(currentPos4-512)/numStp;
    step2 = currentPos2-i*(currentPos2-2048)/numStp;
    posSet(s, 4, step4);
    posSet(s, 2, step2);
end
homeAll(s)
end