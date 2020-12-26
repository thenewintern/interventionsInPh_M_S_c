function [x]=PhPh1c_PE(c,theta,gamma)
    numerator = 1;
    denominator = 1;
    for j = 0 : c-1
        numerator = numerator*((1 - theta) + j*gamma);
        
        denominator = denominator*( 1 + j*gamma);
    end
    
    x = numerator/denominator;
    
end
    