clc
clear
close all
S = serial('COM12', 'BaudRate', 9600);
fopen(S);
for i = 1:5
    if i >= 3
        %find the step change value    
        bit1 = posAsk(S,i);
        ANGA = AXbit(bit1);
        ANGM = MXbit(bit1);
        ANGstepA = (180 - ANGA)/20;
        ANGstepM = (180 - ANGM)/20;

            for a = 1:20
                %gets a binary angle    
                bit1 = posAsk(S,i);

                %converts ANG1 from binary to degrees
                ANGA = AXbit(bit1);

                %new destination with step included
                ANGchange = AXagl(ANGA + ANGstepA); 

                %tell motor to move
                posSet(S,i,ANGchange);

            end
    
    else
        bit1 = posAsk(S,i);
        ANGA = AXbit(bit1);
        ANGM = MXbit(bit1);
        ANGstepA = (180 - ANGA)/20;
        ANGstepM = (180 - ANGM)/20;
        for a = 1:20
            
            %gets a binary angle    
            bit1 = posAsk(S,i);

            %converts ANG1 from binary to degrees
            ANGM = MXbit(bit1);

            %new destination increment
            ANGchange = MXagl(ANGM + ANGstepM); 

            %tell motor to move
            posSet(S,i,ANGchange);
        end
    end
end
fclose(S);

