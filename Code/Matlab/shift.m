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
NL1 = list{l1};
NL2 = list{l2};
NL3 = list{l3};
NL4 = list{l4};
NL5 = list{l5};

NL1(:,1) = NL1(:,1) - 10;
NL2(:,1) = NL2(:,1) - 6;
NL3(:,1) = NL3(:,1) - 2;
NL4(:,1) = NL4(:,1) + 2; 
NL5(:,1) = NL5(:,1) + 6;

NL1(:,3) = NL1(:,3) + 4;
NL2(:,3) = NL2(:,3) + 4;
NL3(:,3) = NL3(:,3) + 4;
NL4(:,3) = NL4(:,3) + 4; 
NL5(:,3) = NL5(:,3) + 4;



%fixes the scale
scale = [ scale,0,0; 0,1,0; 0,0,scale*1.5];

%scale stuff
NL1=NL1*scale;
NL2=NL2*scale;
NL3=NL3*scale;
NL4=NL4*scale;
NL5=NL5*scale;



%assigns adjusted matrixes to new names (nested for loops fixes what used
%to be -999
L1 = NL1;
    for i = 1:length(L1(:,1))
        for j = 1:length(L1(1,:))
            if L1(i,j) <= -999
            L1(i,j) = -999;
            end
        end
    end    
    
    
L2 = NL2;
    for i = 1:length(L2(:,1))
        for j = 1:length(L2(1,:))
            if L2(i,j) <= -999
            L2(i,j) = -999;
            end
        end
    end 
    

 
L3 =NL3;
for i = 1:length(L3(:,1))
        for j = 1:length(L3(1,:))
            if L3(i,j) <= -999
            L3(i,j) = -999;
            end
        end
    end 

L4 = NL4;
    for i = 1:length(L4(:,1))
        for j = 1:length(L4(1,:))
            if L4(i,j) <= -999
            L4(i,j) = -999;
            end
        end
    end 
    
    
L5 = NL5;
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







