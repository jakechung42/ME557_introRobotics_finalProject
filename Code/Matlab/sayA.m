function[] = sayA(s)
%this function calls the Robot Arm to open up the calmp to insert the pen

%bring the arm to home position first
homeAll(s);
pause(0.2);

%go slow for the second motor
%set increment 
numStp = 7;
for i = 1:numStp
    step = 2048+i*(2772-2048)/numStp;
    posSet(s, 2, step);
    pause(0.5)
end
pause(1);
for i = 1:numStp
    step = 512-i*(512-250)/numStp;
    posSet(s, 4, step);
    pause(0.2)
end
pause(1);
for i = 1:numStp
    step = 512+i*(800-512)/numStp;
    posSet(s, 6, step);
    pause(0.2)
end

%in position for pen insertion. Now wait for user to releaser to home
%position
fprintf('Press any key to go back to home position.\n')
pause;
%bring the end effector back quickly to grip onto the pen
posSet(s, 6, 512);
pause(1);
homeAll(s)
% for i = 1:numStp
%     step4 = currentPos4-i*(currentPos4-512)/numStp;
%     step2 = currentPos2-i*(currentPos2-2048)/numStp;
%     posSet(s, 4, step4);
%     posSet(s, 2, step2);
%     pause(0.7)
% end
% homeAll(s)
end