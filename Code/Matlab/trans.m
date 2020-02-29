function[A,B,C,D,E,F,G,H,I,J] = trans(DEPTH)

%reads coordinates in XY plance
A = csvread('L_A.csv');
B = csvread('L_B.csv');
C = csvread('L_C.csv');
D = csvread('L_D.csv');
E = csvread('L_E.csv');
F = csvread('L_F.csv');
G = csvread('L_G.csv');
H = csvread('L_H.csv');
I = csvread('L_I.csv');
J = csvread('L_J.csv');


%adds depth value, converts to xz plane
z = DEPTH;
L = {A,B,C,D,E,F,G,H,I,J};
trns = [1,0,0; 0,0,1; 0,1,0;];

for s = 1:10
L{s}(:,3) = z;
L{s}=L{s}*trns;
end

%Reads list to reassign matrix variables
            A = L{1};
            B = L{2};
            C = L{3};
            D = L{4};
            E = L{5};
            F = L{6};
            G = L{7};
            H = L{8};
            I = L{9};
            J = L{10};
end

