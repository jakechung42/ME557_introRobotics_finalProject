function[] = homeAll(s)
%home all motors

for i = 3:6
    fprintf('Home %d\n',i);
    posSet(s, i, 512);
    pause(0.5);
end

for i = 1:2
    fprintf('Home %d\n',i);
    posSet(s, i, 2048);
    pause(2);
end
fprintf('Done home\n')
end