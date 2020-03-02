function[outOfBound] = isOutOfBound(thetaList)
%this function will take a list of theta after the path generation and tell
%if it is out of bound or not
%Author: Jake Chung
%Winter 2020
%Intro to Robotics Robot Arm project

upBound = max(thetaList);
lowBound = min(thetaList);
for i = 1:6
    switch i
        case 1
            if upBound(i)>MXbit2rad(4096)
                fprintf('%d Out of bound\n', i)
                outOfBound = 1;
                return;
            elseif lowBound(i)<MXbit2rad(0)
                fprintf('%d Out of bound\n', i)
                outOfBound = 1;
                return;
            end
        case 2
            if upBound(i)>MXbit2rad(3233)
                fprintf('%d Out of bound\n', i)
                outOfBound = 1;
                return;
            elseif lowBound(i)<MXbit2rad(810)
                fprintf('%d Out of bound\n', i)
                outOfBound = 1;
                return;
            end
        case 3
            if upBound(i)>AXbit2rad(957)
                fprintf('%d Out of bound\n', i)
                outOfBound = 1;
                return;
            elseif lowBound(i)<AXbit2rad(68)
                fprintf('%d Out of bound\n', i)
                outOfBound = 1;
                return;
            end
        case 4
            if upBound(i)>AXbit2rad(842)
                fprintf('%d Out of bound\n', i)
                outOfBound = 1;
                return;
            elseif lowBound(i)<AXbit2rad(163)
                fprintf('%d Out of bound\n', i)
                outOfBound = 1;
                return;
            end
        case 5
            if upBound(i)>AXbit2rad(847)
                fprintf('%d Out of bound\n', i)
                outOfBound = 1;
                return;
            elseif lowBound(i)<AXbit2rad(173)
                fprintf('%d Out of bound\n', i)
                outOfBound = 1;
                return;
            end
        case 6
            if upBound(i)>AXbit2rad(750)
                fprintf('%d Out of bound\n', i)
                outOfBound = 1;
                return;
            elseif lowBound(i)<AXbit2rad(182)
                fprintf('%d Out of bound\n', i)
                outOfBound = 1;
                return;
            end
    end
end
outOfBound = 0;
end