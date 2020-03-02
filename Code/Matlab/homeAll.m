function[] = homeAll(s)
%home all motors

for i = 3:6
    temp = posSet(s, i, 512);
end

for i = 1:2
    temp = posSet(s, i, 2048);
end

end