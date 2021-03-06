function[] = move2Write(s)
%this function moves the arm to the write position from the home position. Should be called before
%starting to write 
%Author: Jake Chung
%Winter 2020
%Final project Intro to Robotics.

%bring arm to home
homeAll(s)
pause(1);

%set motors 4 5 6 first.
posSet(s, 6, 610);
pause(1)
posSet(s, 5, 663);
pause(1)
posSet(s, 4, 281);
pause(1)
%motor 1 2 3 will go in steps
n_step = 8;
for i= 1:n_step
    posSet(s,3,i*(619-512)/n_step+512);
    pause(0.2);
    posSet(s,2,2048-i*(2048-1584)/n_step);
    pause(0.2);
    posSet(s,1,i*(2788-2048)/n_step+2048);
    pause(0.2);
end
posSet(s,3,619);
pause(0.9)
posSet(s,2,1584);
pause(0.9)
posSet(s,1,2788);
pause(0.9)
end