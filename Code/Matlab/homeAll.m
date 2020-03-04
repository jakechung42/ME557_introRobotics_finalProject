function[] = homeAll(s)
%home all motors
fprintf('Home 2\n')
pause(1)
posSet(s,2,2048);
pause(1)
for i = 3:6
    fprintf('Home %d\n',i);
    posSet(s, i, 512);
    pause(0.8);
end
pause(1)
fprintf('Home 1\n')
posSet(s,1,2048)
fprintf('Done home\n')
end