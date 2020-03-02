function[] = homeAll(s)
%home all motors

for i = 3:6
    temp = posSet(s, i, 512);
    pause(0.2);
end

for i = 1:2
    temp = posSet(s, i, 2048);
    pause(0.8);
end

end