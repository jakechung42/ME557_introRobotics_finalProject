function[] = HomePosition(s,p)
% p is the number of iterations
for i = 3:5
    %find the step change value    
    bit1 = posAsk(s,i); %gives bit value ex: -512
    ANGA = AXbit(bit1); %converts to angle ex: -180
    ANGstepA = (180 - abs(ANGA))/p;
    for a = 1:p
        if ANGA <= 180
            %gets a binary angle    
            bit1 = posAsk(s,i);

            %converts ANG1 from binary to degrees
            ANGA = AXbit(bit1);

            %new destination with step included
            ANGchange = AXagl(ANGA + ANGstepA); 

            %tell motor to move
            posSet(s,i,ANGchange);
        else
            bit1 = posAsk(s,i);

            %converts ANG1 from binary to degrees
            ANGA = AXbit(bit1);

            %new destination with step included
            ANGchange = AXagl(ANGA - ANGstepA); 

            %tell motor to move
            posSet(s,i,ANGchange);
                           
        end
    end
end
   for i = 1:2
       
        bit1 = posAsk(s,i);
        ANGA = AXbit(bit1);
        ANGM = MXbit(bit1);
        ANGstepA = (180 - abs(ANGA))/p;
        ANGstepM = (180 - abs(ANGM))/p;
        
        for a = 1:p
            if ANGM <= 180
                %gets a binary angle    
                bit1 = posAsk(s,i);

                %converts ANG1 from binary to degrees
                ANGM = MXbit(bit1);

                %new destination increment
                ANGchange = MXagl(ANGM + ANGstepM); 

                %tell motor to move
                posSet(s,i,ANGchange);
           
            else
                %gets a binary angle    
                bit1 = posAsk(s,i);

                %converts ANG1 from binary to degrees
                ANGM = MXbit(bit1);

                %new destination increment
                ANGchange = MXagl(ANGM - ANGstepM); 

                %tell motor to move
                posSet(s,i,ANGchange);    
            end
        end
   end
end

