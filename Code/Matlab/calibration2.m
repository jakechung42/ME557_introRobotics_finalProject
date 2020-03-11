function[] = calibration2(s)
%Author: Jake Chung
%this function attemp to calibrate the distance to the board. 
%since we know that the distance from joint 3 to the end effector is
%perfect 16 inches, we will try to use that to our advantage.

homeAll(s)
posSet(s, 1, 1024);
fprintf('Press key to move to motor 3\n')
pause
posSet(s, 3, 220);
n_step = 5;
for i= 1:n_step
    posSet(s,3,512-i*(512-220)/n_step);
    pause(1)
end
while(1)
    move = input('press 1, 2, or 3 to move to postion 1, 2, or 3, press 0 to stop: \n', 's');
    switch move
        case '1'
            posSet(s, 2, 1024);
            posSet(s, 3, 205);
        case '2'
            posSet(s, 2, 2048);
            posSet(s, 3, 220);
        case '3'
            posSet(s, 2, 2048+1024);
            posSet(s, 3, 220);
        case '0'
            homeAll(s)
            return;
    end
end
end