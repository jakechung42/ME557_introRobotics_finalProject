function[] = homeSlow()
%this function home the robot arm slowly
allPos = getAllAngle(s);
% allPos = [3403; 1203; 700; 123; 301; 931];
%desired angles 
wantPos = [2048; 2048; 512; 512; 512; 512];

%home the MX's first
nStep = 15;
for i = 1:2
    for j = 1:nStep
        if (allPos(i)-wantPos(i))>0
            step = round(allPos(i)-j*abs(allPos(i)-wantPos(i))/nStep);
            posSet(s,i,step);
        elseif (allPos(i)-wantPos(i))<0
            step = round(allPos(i)+j*abs(allPos(i)-wantPos(i))/nStep);
            posSet(s,i,step);
        else
            fprintf('Cannot read position. Exit!\n')
            return;
        end
        pause(0.2);
    end
end

%home the RX's
nStep = 10;
for i = 3:6
    for j = 1:nStep
        if (allPos(i)-wantPos(i))>0
            step = round(allPos(i)-j*abs(allPos(i)-wantPos(i))/nStep);
            posSet(s,i,step);
        elseif (allPos(i)-wantPos(i))<0
            step = round(allPos(i)+j*abs(allPos(i)-wantPos(i))/nStep);
            posSet(s,i,step);
        else
            fprintf('Cannot read position. Exit!\n')
            return;
        end
        pause(0.2);
    end
end
homeAll(s)
end