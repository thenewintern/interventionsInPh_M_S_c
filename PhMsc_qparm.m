%%%%%%%%%% Arrival and Service related matrices and vectors %%%%%%%%%%%%%%%
% function[k1,k2,alpha,beta,A1,A2,B1,B2,lambda,mu]=PhPh1c_qparm(t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [k1,alpha,A1,A2,lambda,mu]=PhMsc_qparm(t)

% Matrices and vectors that need the user to set values:

lambda = [9  8  6  0  0  0  0  0  0  0]';

mu = 0;

alpha = [0.3  0.3  0.4  0.  0.  0.  0.  0  0  0]';

A1=[0.1  0.2  0.1  0  0.  0  0  0  0  0;   %1
    
    0.2  0.1  0.1  0  0  0  0  0  0  0;   %2
    
    0.3  0.1  0.1  0  0  0  0  0  0  0;   %3
    
    0  0  0  0  0  0  0  0  0  0;   %4
    
    0  0  0  0  0  0  0  0  0  0;   %5
    
    0  0  0  0  0  0  0  0  0  0;   %6
    
    0  0  0  0  0  0  0  0  0  0;   %7
    
    0  0  0  0  0  0  0  0  0  0;   %8
    
    0  0  0  0  0  0  0  0  0  0;   %9
    
    0  0  0  0  0  0  0  0  0  0];  %10


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sum_alpha=sum(alpha);

if sum_alpha~=1
    alpha=alpha/sum_alpha;
end

A2=1-sum(A1,2);

k1=find(lambda,1,'last');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

