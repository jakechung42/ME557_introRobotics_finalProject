function[] = testRun(s)

    for i = 1:50
        a = posSet(s, 1, MXagl(180)+i*1024/50);
        b = posSet(s, 2, MXagl(180)+i*1024/50);
        c = posSet(s, 3, AXagl(180)-i*256/50);
        d = posSet(s, 4, AXagl(180)-i*256/50);
        
    end
end