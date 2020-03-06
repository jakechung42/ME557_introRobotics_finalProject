function [py]= home_toBoard(s)
%Collect the angles the motor needs to make in order to reach the board. 


%For joint 1:
r1 = [0;0;0];
w1 = [0;0;1];
v1 = cross(r1, w1);

%For joint 2:
r2 = [0;0;55.4];
w2 = [1;0;0];
v2 = cross(r2, w2);

%For joint 3:
r3 = [0;0;132.4];
w3 = [0;1;0];
v3 = cross(r3, w3);

%For joint 4:
r4 = [0;0;246.8];
w4 = [1;0;0];
v4 = cross(r4, w4);

%For joint 5:
r5 = [0;0;316.6];
w5 = [0;1;0];
v5 = cross(r5, w5);

%For joint 5:
r6 = [0;0;385.8];
w6 = [1;0;0];
v6 = cross(r6, w6);



%The M vector describes the end affector's position in the home position. 
M=[[1,0,0,0];[0,1,0,0];[0,0,1,385.8+159.7];[0,0,0,1]];

%Define the screw axes for each of the motors:
S1 = [w1;v1];
S2 = [w2;v2];
S3 = [w3;v3];
S4 = [w4;v4];
S5 = [w5;v5];
S6 = [w6;v6];

%Slist is a row vector contains all of your s vectors.
Slist=[S1,S2,S3,S4,S5,S6];

%The following lines describe the home position of the robot arm. 
int_pos_one=2047;
int_pos_two=2049;
int_pos_three=510;
int_pos_four=512;
int_pos_five=510;
int_pos_six=512;

%The following lines describe the desired position of each joint in
%radians. 


R_desired=[[1,0,0];[0,0,1];[0,-1,0]];

T_new = RpToTrans(R_desired,[0;350;118.5]);

[thetalist_start, success] = IKinSpace(Slist, M, T_new, [MXbit2rad(2047);MXbit2rad(1652);AXbit2rad(510);AXbit2rad(180);AXbit2rad(510);AXbit2rad(661)], 0.1, .01);


beta_start_list=[MXrad2bit(thetalist_start(1,1));MXrad2bit(thetalist_start(2,1));AXrad2bit(thetalist_start(3,1));AXrad2bit(thetalist_start(4,1));AXrad2bit(thetalist_start(5,1));AXrad2bit(thetalist_start(6,1))];

            
des_pos_one=beta_start_list(1,1);
des_pos_two=beta_start_list(2,1);
des_pos_three=beta_start_list(3,1);
des_pos_four=beta_start_list(4,1);
des_pos_five=beta_start_list(5,1);
des_pos_six=beta_start_list(6,1);

    %Px indicates that the robot arm's end effector position should be along
    %x=0;
    
    Px_desired=0;

    %Pz indicates the desired elevation of the end effector in space. 
    Pz_desired=118.5;

    %Indicate the amount of steps each motor should take to reach the
    %desired position.
    step=5;
    
    %The increment by which motor ones's position changes. 
    Ang_change_1=[abs(des_pos_one-int_pos_one)]/[step];

    %The increment by which motor two's position changes. 
    Ang_change_2=[abs(des_pos_two-int_pos_two)]/[step];
    
    %The increment by which motor three's position changes. 
    Ang_change_3=[abs(des_pos_three-int_pos_three)]/[step];
    
    %The increment by which motor four's position changes. 
    Ang_change_4=[abs(des_pos_four-int_pos_four)]/[step];
    
    %The increment by which motor five's position changes. 
    Ang_change_5=[abs(des_pos_five-int_pos_five)]/[step];
    
    %The increment by which motor six's position changes. 
    Ang_change_6=[abs(des_pos_six-int_pos_six)]/[step];
    
    posSet(s,2,des_pos_two);

for x=1:step

        %one
            x1=posAsk(s,1);
            pause(.2);
            
            %If the home position for motor four exceeds the desired position for
            %motor four subtract angular increment from the current position. 
            if(int_pos_one > des_pos_one)
                    
                    posSet(s,1,x1-Ang_change_1);
            
            
     
            else
            %If the home position for motor four is less than the desired position for
            %motor four add angular increment to the current position
        
                    posSet(s,1,x1+Ang_change_1);
            end
            
%          %Three
     x3=posAsk(s,3);
     pause(.1);
            
     %If the home position for motor four exceeds the desired position for
     %motor four subtract angular increment from the current position. 
            if(int_pos_three > des_pos_three)
                    
                    posSet(s,3,x3-Ang_change_3);
            
            
     
            else
            %If the home position for motor four is less than the desired position for
            %motor four add angular increment to the current position
        
            posSet(s,3,x3+Ang_change_3);
            end
            
         %Four
         x4=posAsk(s,4);
         pause(.1);
    
         %If the home position for motor two exceeds the desired position for
         %motor two subtract angular increment from the current position.
    
            if(int_pos_four > des_pos_four)
        
                    posSet(s,4,x4-Ang_change_4); 
            else
            
            %If the home position for motor two is less than the desired position for
            %motor two add angular increment to the current position
        
                    posSet(s,4,x4+Ang_change_4);
            end      
            
            
            
         %Five
         x5=posAsk(s,5);
         pause(.1);
    
         %If the home position for motor two exceeds the desired position for
         %motor two subtract angular increment from the current position.
    
            if(int_pos_five > des_pos_five)
        
                    posSet(s,5,x5-Ang_change_5); 
            else
            
            %If the home position for motor two is less than the desired position for
            %motor two add angular increment to the current position
        
                    posSet(s,5,x5+Ang_change_5);
            end   
            
            
         %Six
         x6=posAsk(s,6);
         pause(.1);
    
         %If the home position for motor two exceeds the desired position for
         %motor two subtract angular increment from the current position.
    
            if(int_pos_six > des_pos_six)
        
                    posSet(s,6,x6-Ang_change_6); 
            else
            
            %If the home position for motor two is less than the desired position for
            %motor two add angular increment to the current position
        
                    posSet(s,6,x6+Ang_change_6);
            end       
end

%The following counter was place in order to exit out of the while loop
%properly. 

x_counter=0;


while(x_counter== 0)
    
prompt=('If you want the robot to go forward, type f. If you want to save the robot''s current p and theta values, type s\n');

x = input(prompt,'s');

%Store the current angles of the end effector.

cur_mo1_ang=posAsk(s,1);
cur_mo2_ang=posAsk(s,2);
cur_mo3_ang=posAsk(s,3);
cur_mo4_ang=posAsk(s,4);
cur_mo5_ang=posAsk(s,5);
cur_mo6_ang=posAsk(s,6);
pause(1);

current_theta_list=[MXbit2rad(cur_mo1_ang);MXbit2rad(cur_mo2_ang);AXbit2rad(cur_mo3_ang);AXbit2rad(cur_mo4_ang);AXbit2rad(cur_mo5_ang);AXbit2rad(cur_mo6_ang)];

% %What is the transformation matrix corresponding to the current position in
% %space?
T_current=FKinSpace(M, Slist, current_theta_list);

p_current=T_current(1:3,4);
    
switch x
    case 'f'
   
   %Increment the end effector's position in the y direction. 
        y_increment=(abs(406.4-p_current(2,1)))/5;
   
   %What is the new y position of the end effector?
        y_new=p_current(2,1)+y_increment;
   
   %What is the new p vector for the end effector?
        p_new=[Px_desired;y_new;Pz_desired];
        
   %What is the new transformation matrix based on p_new?
        T_new = RpToTrans(R_desired,p_new);
        
   %What is the initial guess for the end effector? It is equal to the
   %current theta list.
   
   %What are the constants that are to be used to determine the precision of
   %the inverse kinematics?
        eomg=0.1;
        ev=0.01;
   
   %What are the angles corresponding to the position T_new?
        [thetalist_new, success] = IKinSpace(Slist, M, T_new, current_theta_list, eomg, ev);
    
        
        
        
        new_ang_1=thetalist_new(1,1);
        new_ang_2=thetalist_new(2,1);
        new_ang_3=thetalist_new(3,1);
        new_ang_4=thetalist_new(4,1);
        new_ang_5=thetalist_new(5,1);
        new_ang_6=thetalist_new(6,1);
        pause(.1);
        
        Betalist=[MXrad2bit(new_ang_1);MXrad2bit(new_ang_2);AXrad2bit(new_ang_3);AXrad2bit(new_ang_4);AXrad2bit(new_ang_5);AXrad2bit(new_ang_6)];
   
        Beta_1_ang=Betalist(1,1);
        Beta_2_ang=Betalist(2,1);
        Beta_3_ang=Betalist(3,1);
        Beta_4_ang=Betalist(4,1);
        Beta_5_ang=Betalist(5,1);
        Beta_6_ang=Betalist(6,1);
        
        pause(.1);
        
        posSet(s,1,Beta_1_ang);
        posSet(s,2,Beta_2_ang);
        posSet(s,3,Beta_3_ang);
        posSet(s,4,Beta_4_ang);
        posSet(s,5,Beta_5_ang);
        posSet(s,6,Beta_6_ang);
       

    case 's'
       
        Board_bits=[posAsk(s,1);posAsk(s,2);posAsk(s,3);posAsk(s,4);posAsk(s,5);posAsk(s,6)];
        Board_angles=[MXbit2rad(Board_bits(1,1));MXbit2rad(Board_bits(2,1));AXbit2rad(Board_bits(3,1));AXbit2rad(Board_bits(4,1));AXbit2rad(Board_bits(5,1));AXbit2rad(Board_bits(6,1))];
        
        %What is the transformation matrix corresponds to the desired position in
        %space?
        T_board=FKinSpace(M, Slist,Board_angles);
 
        %The following line will be used to determine the p value corresponding to
        %the desired transformation matrix. 
 
         [R_board,p_board] = TransToRp(T_board);
     py=p_board(2,1);  
     x_counter=1;
end
end





