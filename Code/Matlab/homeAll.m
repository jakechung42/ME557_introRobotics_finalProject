function[] = homeAll(s)
%home all motors

for i = 3:6
    posSet(s, i, 512);
    pause(0.2);
end

for i = 1:2
    posSet(s, i, 2048);
    pause(0.7);
end

end