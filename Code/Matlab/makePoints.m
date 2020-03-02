function[list] = makePoints(matrix)
%this function takes in the main vertexes of the character and make points
%in between them for the inverse kinametic
%test array
% clear
% close all
% matrix = [0,0,0;19.5,42.76,0;39,0,0;-999,-999,-999;9.5,21.5,0;29.5,21.5,0];
% plot(matrix(:,1),matrix(:,2),'o')
% xlim([-1 40])
% ylim([-1 45])
np=5;
list = zeros(1,3);
i=1;
while (i ~= (length(matrix(:,1))))
    %check to see if it's the lift up point
    if (matrix(i+1,1) == -999)
        i = i+2;
        list = [list;[-999,-999,-999]];
    else
        %define the first and second vector
        vec1 = matrix(i,:);
        vec2 = matrix(i+1,:);
        %get the legnth between 
        L = norm(vec2-vec1);
        %np is the number of points between each vertex np
        dL = L/np;
        %generate the list of points between 2 arbitrary points.
        %first need to get the unit vector uv
        uv = (vec2-vec1)/L;
        %make an array of vectors to store the points
        VecList = zeros(np,3);
        VecList(1,:) = vec1;
        for j = 2:np
            %loop through and build the points using the unit vector
            VecList(j,:) = VecList(j-1,:)+uv*dL;
        end
        %VecList
        %built the new matrix with the discrete points in between.
        list = [list;VecList];
        i = i+1;
    end
end
%clean up list
list = list(2:end,:);
list(end,:) = matrix(end,:);
% %turn on plot function to check makePoints
% plot(list(:,1), list(:,3),'o-')
end