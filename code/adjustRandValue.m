function [] = adjustCardValueP1(sigma )

    newRandValue=-1;
    
    while newRandValue<0 || newRandValue>1
        newRandValue=sigma*randn+randValue;
    end
    playerP1(3)=newRandValue;
end

