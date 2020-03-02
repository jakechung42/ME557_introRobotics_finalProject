function[] = testCoor(a)
%this function plots the points to write the letters
close all
figure
plot3(a(:,1),a(:,2),a(:,3),'*-')
xlim([-100,100])
ylim([300,500])
zlim([-100,100])
end
