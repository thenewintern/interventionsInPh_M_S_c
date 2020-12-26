function [dpdt]=PhMsc_function(t,prob)

t
global c s m_a;

[k1,alpha,A1,A2,lambda,mu]=PhMsc_qparm(t);

dpdt=zeros((c+1)*m_a + 6*m_a,1);

E0_pmde=zeros(m_a,2);
E1_pmde=zeros(m_a,2);
E2_pmde=zeros(m_a,2);

P_S_1=zeros(m_a,1);
P_S=zeros(m_a,1);
P_C=zeros(m_a,1);

%%%%%%%%%%%%%%%%%%%%%%% Kolmogorov Forward Equations %%%%%%%%%%%%%%%%%%%%%%
%subspace1
for i=1:m_a
    dpdt_index=i;
    
    dpdt(dpdt_index)=-lambda(i)*prob(i);
    
    for j=1:k1
        dpdt(dpdt_index)=dpdt(dpdt_index)+A1(j,i)*lambda(j)*prob(j);
    end
    
    dpdt(dpdt_index)=dpdt(dpdt_index)+mu*prob(m_a + i);
    
end


for n=1:s-1
    for i=1:m_a
        dpdt_index=n*m_a + i;
        
        dpdt(dpdt_index)=-(lambda(i)+n*mu)*prob(n*m_a + i);
        
        for j=1:k1
            dpdt(dpdt_index)=dpdt(dpdt_index)+A1(j,i)*lambda(j)*...
                             prob(n*m_a + j);
        end
        
        positive_flux=0;
        
        for j=1:k1
            positive_flux=positive_flux+A2(j)*lambda(j)*...
                          prob((n-1)*m_a + j);
        end
         
        dpdt(dpdt_index)=dpdt(dpdt_index)+alpha(i)*positive_flux;
        
        dpdt(dpdt_index)=dpdt(dpdt_index)+ (n+1)*mu*prob((n+1)*m_a + i);
        
    end
end 
%subspace1


%subspace2
for k=s:c-1
    for i=1:m_a
        dpdt_index=k*m_a+i;
        
        dpdt(dpdt_index)=-(lambda(i)+s*mu)*prob(k*m_a + i);
        
        for j=1:k1
            dpdt(dpdt_index)=dpdt(dpdt_index)+A1(j,i)*lambda(j)*...
                             prob(k*m_a + j);
        end
        
        positive_flux=0;
        
        for j=1:k1
            positive_flux=positive_flux+A2(j)*lambda(j)*...
                          prob((k-1)*m_a + j);
        end
        
        dpdt(dpdt_index)=dpdt(dpdt_index)+alpha(i)*positive_flux;
        
        dpdt(dpdt_index)=dpdt(dpdt_index)+s*mu*prob((k+1)*m_a + i);
       
    end
end


for i=1:m_a
    dpdt_index=c*m_a + i;
    
    dpdt(dpdt_index)=-(lambda(i)+s*mu)*prob(c*m_a + i);
    
    for j=1:k1
        dpdt(dpdt_index)=dpdt(dpdt_index)+A1(j,i)*lambda(j)*...
                         prob(c*m_a + j);
    end
    
    positive_flux=0;
    
    for j=1:k1
        positive_flux=positive_flux+A2(j)*lambda(j)*(...
                      prob((c-1)*m_a + j) + prob(c*m_a + j));
    end
    
    dpdt(dpdt_index)=dpdt(dpdt_index)+alpha(i)*positive_flux;
    
end
%subspace2
%%%%%%%%%%%%%%%%%%%%%%% Kolmogorov Forward Equations %%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%% Current Values of PMDEs %%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:m_a
    E0_pmde(i,1)=prob((c+1)*m_a + i);
    E0_pmde(i,2)=prob((c+1)*m_a + m_a + i);
    
    E1_pmde(i,1)=prob((c+1)*m_a + 2*m_a + i);
    E1_pmde(i,2)=prob((c+1)*m_a + 3*m_a + i);
    
    E2_pmde(i,1)=prob((c+1)*m_a + 4*m_a + i);
    E2_pmde(i,2)=prob((c+1)*m_a + 5*m_a + i);
    
end
%%%%%%%%%%%%%%%%%%%%%%% Current Values of PMDEs %%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%% Polya Eggenberger Approximations %%%%%%%%%%%%%%%%%%%%%

%subspace1
for i=1:m_a
    
        %if s==1
         %   P_S_1(i)=E0_pmde(i,1);
        %else
    
        EN=E1_pmde(i,1)/E0_pmde(i,1);
        EN2=E2_pmde(i,1)/E0_pmde(i,1);
        
        if isnan(EN)~=1 && isnan(EN2)~=1
            
            den=s-1;
           
        Var=EN2-EN*EN;
        eita=1000.;
        x=EN/den;
        epsilon=10^(-4);
          if EN<epsilon
              p=0.;
          else
              p=x;
          end
        theta=p;

        q=1-p;
        pqmin=min(p,q);
        x=-pqmin/(den-1);
        d=EN2-den*EN;
          if(EN<epsilon) 
              gamma=0.;
          elseif(EN>(den-epsilon))
              gamma=0.;
          elseif(Var<epsilon)
              gamma=-1/den+epsilon;
          elseif(abs(d)<epsilon)
              gamma=eita;
          elseif ((EN*(EN+(1.-p)))-EN2)/d<x
              gamma=x+epsilon; 
          else
              gamma=((EN*(EN+(1.-p)))-EN2)/d;
          end

          P_S_1(i)=PhMsc_PE(den,1-theta,gamma);
          
          P_S_1(i)=P_S_1(i)*E0_pmde(i,1);
          
        end
        
        %end
end

%subspace2

for i=1:m_a
    
        %if c-s==0
         %   P_S(i)=E0_pmde(i,2);
          %  P_C(i)=E0_pmde(i,2);
            
        %else
    
        EN=E1_pmde(i,2)/E0_pmde(i,2);
        EN2=E2_pmde(i,2)/E0_pmde(i,2);
        
        if isnan(EN)~=1 && isnan(EN2)~=1
            %EN;
            %EN2;
            EN=EN-s;
            EN2=EN2-2*s*EN-(s^2);
            %input('')
        %if EN>=0 && EN2 >= 0
            
            den=c-s;
           
        Var=EN2-EN*EN;
        eita=1000.;
        x=EN/den;
        epsilon=10^(-4);
          if EN<epsilon
              p=0.;
          else
              p=x;
          end
        theta=p;

        q=1-p;
        pqmin=min(p,q);
        x=-pqmin/(den-1);
        d=EN2-den*EN;
          if(EN<epsilon) 
              gamma=0.;
          elseif(EN>(den-epsilon))
              gamma=0.;
          elseif(Var<epsilon)
              gamma=-1/den+epsilon;
          elseif(abs(d)<epsilon)
              gamma=eita;
          elseif ((EN*(EN+(1.-p)))-EN2)/d<x
              gamma=x+epsilon; 
          else
              gamma=((EN*(EN+(1.-p)))-EN2)/d;
          end

          P_S(i)=PhMsc_PE(den,theta,gamma);
          P_C(i)=PhMsc_PE(den,1-theta,gamma);
          %E0_pmde(:,2)
          
          P_S(i)=P_S(i)*E0_pmde(i,2);
          P_C(i)=P_C(i)*E0_pmde(i,2);
          %input('')

        end
        %end
        %end
    
end

%%%%%%%%%%%%%%%%%%%% Polya Eggenberger Approximations %%%%%%%%%%%%%%%%%%%%%
%P_S_1(:,1)=prob((s-1)*m_a + 1 : s*m_a);
%P_S(:,1)=prob(s*m_a + 1 : (s+1)*m_a);
%P_C(:,1)=prob(c*m_a + 1 : (c+1)*m_a);




%%%%%%%%%%%%%%% Partial Moment Differential Equations %%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%% E[N^0(t),N(t)<s,A(t)=i] %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:m_a
    dpdt_index=(c+1)*m_a + i;
    
    dpdt(dpdt_index)=-lambda(i)*E0_pmde(i,1);
    
    for j=1:k1
        dpdt(dpdt_index)=dpdt(dpdt_index)+A1(j,i)*lambda(j)*...
                         E0_pmde(j,1);
    end
    
    positive_flux=0;
    
    for j=1:k1
        positive_flux=positive_flux+A2(j)*lambda(j)*(E0_pmde(j,1)-...
                      P_S_1(j));
    end
    
    dpdt(dpdt_index)=dpdt(dpdt_index)+alpha(i)*positive_flux;
    
    dpdt(dpdt_index)=dpdt(dpdt_index)+s*mu*P_S(i);

end
%%%%%%%%%%%%%%%%%%%%% E[N^0(t),N(t)<s,A(t)=i] %%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%% E[N^0(t),N(t)>=s,A(t)=i] %%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:m_a
    dpdt_index=(c+1)*m_a + m_a + i;
    
    dpdt(dpdt_index)=-lambda(i)*E0_pmde(i,2);
    
    for j=1:k1
        dpdt(dpdt_index)=dpdt(dpdt_index)+A1(j,i)*lambda(j)*E0_pmde(j,2);
    end
    
    positive_flux=0;
    
    for j=1:k1
        positive_flux=positive_flux+A2(j)*lambda(j)*(E0_pmde(j,2)+...
                      P_S_1(j));
    end
    
    dpdt(dpdt_index)=dpdt(dpdt_index)+alpha(i)*positive_flux;
    
    dpdt(dpdt_index)=dpdt(dpdt_index)-s*mu*P_S(i);

end
%%%%%%%%%%%%%%%%%%%%% E[N^0(t),N(t)>=s,A(t)=i] %%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%% E[N(t),N(t)<s,A(t)=i] %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:m_a
    dpdt_index=(c+1)*m_a + 2*m_a + i;
    
    dpdt(dpdt_index)=-lambda(i)*E1_pmde(i,1);
    
    for j=1:k1
        dpdt(dpdt_index)=dpdt(dpdt_index)+A1(j,i)*lambda(j)*...
                         E1_pmde(j,1);
    end
    
    positive_flux=0;
    
    for j=1:k1
        positive_flux=positive_flux+A2(j)*lambda(j)*(E0_pmde(j,1)+...
                      E1_pmde(j,1)-s*P_S_1(j));
    end
    
    dpdt(dpdt_index)=dpdt(dpdt_index)+alpha(i)*positive_flux;
    
    dpdt(dpdt_index)=dpdt(dpdt_index)-mu*E1_pmde(i,1);
    
    dpdt(dpdt_index)=dpdt(dpdt_index)+(s-1)*s*mu*P_S(i);

end
%%%%%%%%%%%%%%%%%%%%%%% E[N(t),N(t)<s,A(t)=i] %%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%% E[N(t),N(t)>=s,A(t)=i] %%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:m_a
    dpdt_index=(c+1)*m_a + 3*m_a + i;
    
    dpdt(dpdt_index)=-lambda(i)*E1_pmde(i,2);
    
    for j=1:k1
        dpdt(dpdt_index)=dpdt(dpdt_index)+A1(j,i)*lambda(j)*E1_pmde(j,2);
    end
    
    positive_flux=0;
    
    for j=1:k1
        positive_flux=positive_flux+A2(j)*lambda(j)*(E1_pmde(j,2)+...
                      E0_pmde(j,2)-P_C(j)+s*P_S_1(j));
    end
    
    dpdt(dpdt_index)=dpdt(dpdt_index)+alpha(i)*positive_flux;
    
    dpdt(dpdt_index)=dpdt(dpdt_index)-s*mu*(E0_pmde(i,2)+(s-1)*P_S(i));
        
end
%%%%%%%%%%%%%%%%%%%%%%% E[N(t),N(t)>=s,A(t)=i] %%%%%%%%%%%%%%%%%%%%%%%%%%%%






%%%%%%%%%%%%%%%%%%%%%%% E[N^2(t),N(t)<s,A(t)=i] %%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:m_a
    dpdt_index=(c+1)*m_a + 4*m_a + i;
    
    dpdt(dpdt_index)=-lambda(i)*E2_pmde(i,1);
    
    
    for j=1:k1
        dpdt(dpdt_index)=dpdt(dpdt_index)+A1(j,i)*lambda(j)*...
                         E2_pmde(j,1);
    end
    
    positive_flux=0;
    
    for j=1:k1
        positive_flux=positive_flux+A2(j)*lambda(j)*(E2_pmde(j,1)+...
                      2*E1_pmde(j,1)+E0_pmde(j,1)-(s^2)*P_S_1(j));
    end
    
    dpdt(dpdt_index)=dpdt(dpdt_index)+alpha(i)*positive_flux;
    
    dpdt(dpdt_index)=dpdt(dpdt_index)+mu*E1_pmde(i,1);
    
    dpdt(dpdt_index)=dpdt(dpdt_index)-mu*2*E2_pmde(i,1);
    
    dpdt(dpdt_index)=dpdt(dpdt_index)+((s-1)^2)*s*mu*P_S(i);

end
%%%%%%%%%%%%%%%%%%%%%%% E[N^2(t),N(t)<s,A(t)=i] %%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% E[N^2(t),N(t)>=s,A(t)=i] %%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:m_a
    dpdt_index=(c+1)*m_a + 5*m_a + i;
    
    dpdt(dpdt_index)=-lambda(i)*E2_pmde(i,2);
    
    for j=1:k1
        dpdt(dpdt_index)=dpdt(dpdt_index)+A1(j,i)*lambda(j)*E2_pmde(j,2);
    end
    
    positive_flux=0;
    
    for j=1:k1
        positive_flux=positive_flux+A2(j)*lambda(j)*(E2_pmde(j,2)+...
                      2*E1_pmde(j,2)+E0_pmde(j,2)-(2*c+1)*P_C(j)+...
                      (s^2)*P_S_1(j));
    end
    
    dpdt(dpdt_index)=dpdt(dpdt_index)+alpha(i)*positive_flux;
    
    dpdt(dpdt_index)=dpdt(dpdt_index)+s*mu*E0_pmde(i,2);
    
    dpdt(dpdt_index)=dpdt(dpdt_index)-s*mu*2*E1_pmde(i,2);
    
    dpdt(dpdt_index)=dpdt(dpdt_index)-s*mu*((s-1)^2)*P_S(i);

end
%%%%%%%%%%%%%%%%%%%%%%% E[N^2(t),N(t)>=s,A(t)=i] %%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% Partial Moment Differential Equations %%%%%%%%%%%%%%%%%%%%%

end