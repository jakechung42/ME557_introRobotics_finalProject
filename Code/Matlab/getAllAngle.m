function[ang_out] = getAllAngle(s)
%this function uses the posAsk function to ask the the angles of the joints
%and output them back.
ang_out = zeros(6,1);
for i=1:6
    fprintf('Get angle %d\n', i);
    ang_out(i,1) = posAsk(s,i);
    pause(0.5);
end
end

