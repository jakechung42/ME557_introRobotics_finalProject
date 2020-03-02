function[path] = shift(letter,scale,depth)
% example: [path] = shift('ABCDE',3,16)
%Outputs the translated versions of the appropriate letters
letter = char(letter);
numLetter = zeros(1,5);
jump = [-999,-999,-999];
for p = 1:5
    switch letter(p)
        case 'A'
            numLetter(p) = 1;
        case 'B'
            numLetter(p) = 2;
        case 'C'
            numLetter(p) = 3;
        case 'D'
            numLetter(p) = 4;
        case 'E'
            numLetter(p) = 5;
        case 'F'
            numLetter(p) = 6;
        case 'G'
            numLetter(p) = 7;
        case 'H'
            numLetter(p) = 8;
        case 'I'
            numLetter(p) = 9;
        case 'J'
            numLetter(p) = 10;
        otherwise
            disp('Something is wrong with the input characters please check again')
            return;
    end
end

l1 = numLetter(1);
l2 = numLetter(2);
l3 = numLetter(3);
l4 = numLetter(4);
l5 = numLetter(5);

%retrieves coordinate matrixes A through J
[A,B,C,D,E,F,G,H,I,J] = trans(depth);

%Forms them into a list
list = {A,B,C,D,E,F,G,H,I,J};

%Takes the appropriate matrix from the list depending on the letter number
%and transposes it
list{l1}(:,1) = list{l1}(:,1) - 8;
list{l2}(:,1) = list{l2}(:,1) - 4;
list{l4}(:,1) = list{l4}(:,1) + 4; 
list{l5}(:,1) = list{l5}(:,1) + 8;

%fixes the scale
scale = [ scale,0,0; 0,1,0; 0,0,scale];

%scale stuff
list{l1}=list{l1}*scale;
list{l2}=list{l2}*scale;
list{l3}=list{l3}*scale;
list{l4}=list{l4}*scale;
list{l5}=list{l5}*scale;



%assigns adjusted matrixes to new names (nested for loops fixes what used
%to be -999
L1 = list{l1};
    for i = 1:length(L1(:,1))
        for j = 1:length(L1(1,:))
            if L1(i,j) <= -999
            L1(i,j) = -999;
            end
        end
    end    
    
    
L2 = list{l2};
    for i = 1:length(L2(:,1))
        for j = 1:length(L2(1,:))
            if L2(i,j) <= -999
            L2(i,j) = -999;
            end
        end
    end 
    

 
L3 = list{l3};
for i = 1:length(L3(:,1))
        for j = 1:length(L3(1,:))
            if L3(i,j) <= -999
            L3(i,j) = -999;
            end
        end
    end 

L4 = list{l4};
    for i = 1:length(L4(:,1))
        for j = 1:length(L4(1,:))
            if L4(i,j) <= -999
            L4(i,j) = -999;
            end
        end
    end 
    
    
L5 = list{l5};
    for i = 1:length(L5(:,1))
        for j = 1:length(L5(1,:))
            if L5(i,j) <= -999
            L5(i,j) = -999;
            end
        end
    end 
    
    %discretize and combine
DL1 = makePoints(L1);
DL2 = makePoints(L2);
DL3 = makePoints(L3);
DL4 = makePoints(L4);
DL5 = makePoints(L5);

path = [DL1; jump; DL2; jump; DL3; jump; DL4; jump; DL5] ;
end






