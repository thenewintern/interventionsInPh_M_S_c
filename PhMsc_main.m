%%%%%%%%%%%%%%%%%%%%%%% PhMsc Main file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global c s m_a;
c=5;
s=5;
m_a=3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global det_changes_entities det_changes_capacity det_changes_servers;
global det_changes_times;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global start_time end_time;
start_time=0;
end_time=100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
duration=end_time-start_time;
tspan=linspace(start_time,end_time,duration*1000);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
opts=odeset('RelTol',1e-6);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ics=zeros((c+1)*m_a + 6*m_a,1);
ics(1,1)=1;
ics((c+1)*m_a + 1,1)=1;
%ics((c+1)*m_a + m_a + 1,1)=1;
%ics((c+1)*m_a + 2*m_a + 1,1)=0;
%ics((c+1)*m_a + 3*m_a + 1,1)=5;
%ics((c+1)*m_a + 4*m_a + 1,1)=0;
%ics((c+1)*m_a + 5*m_a + 1,1)=25;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[t,prob]=ode45(@PhMsc_function,tspan,ics,opts);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dummy_prob=prob(:,1:(c+1)*m_a);

E0_kfe=0;
E1_kfe=0;
E2_kfe=0;

E0_sub1_kfe = sum(prob(:,1 : s*m_a ),2);
E0_sub2_kfe = sum(prob(:,s*m_a + 1 : (c+1)*m_a ),2);


for n=1:c+1
    E0_kfe=E0_kfe+sum(dummy_prob(:,(n-1)*m_a + 1 : n*m_a),2);
    
    
    
    E1_kfe=E1_kfe+(n-1)*sum(dummy_prob(:,(n-1)*m_a + 1 : n*m_a),2);
    E2_kfe=E2_kfe+((n-1)^2)*sum(dummy_prob(:,(n-1)*m_a + 1 : n*m_a),2);
end

E0_pmde=sum(prob(:,(c+1)*m_a + 1 : (c+1)*m_a + 2*m_a ),2);

E1_pmde=sum(prob(:,(c+1)*m_a + 2*m_a + 1 : (c+1)*m_a + 4*m_a ),2);

E2_pmde=sum(prob(:,(c+1)*m_a + 4*m_a + 1 : (c+1)*m_a + 6*m_a ),2);


E0_sub1_pmde=sum(prob(:,(c+1)*m_a + 1 : (c+1)*m_a + m_a ),2);

E0_sub2_pmde=sum(prob(:,(c+1)*m_a + m_a + 1 : (c+1)*m_a + 2*m_a ),2);

E1_sub1_pmde=sum(prob(:,(c+1)*m_a + 2*m_a + 1 : (c+1)*m_a + 3*m_a ),2);

E1_sub2_pmde=sum(prob(:,(c+1)*m_a + 3*m_a + 1 : (c+1)*m_a + 4*m_a ),2);

E2_sub1_pmde=sum(prob(:,(c+1)*m_a + 4*m_a + 1 : (c+1)*m_a + 5*m_a ),2);

E2_sub2_pmde=sum(prob(:,(c+1)*m_a + 5*m_a + 1 : (c+1)*m_a + 6*m_a ),2);


E0_error=E0_kfe-E0_pmde;
E1_error=E1_kfe-E1_pmde;
E2_error=E2_kfe-E2_pmde;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
subplot(3,1,1),plot(t,E0_kfe);
xlabel('Time');
ylabel('E0_{kfe}');
subplot(3,1,2),plot(t,E0_pmde);
xlabel('Time');
ylabel('E0_{pmde}');
subplot(3,1,3),plot(t,E0_error);
xlabel('Time');
ylabel('E0_{error}');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input('')
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
subplot(3,1,1),plot(t,E1_kfe);
xlabel('Time');
ylabel('E1_{kfe}');
subplot(3,1,2),plot(t,E1_pmde);
xlabel('Time');
ylabel('E1_{pmde}');
subplot(3,1,3),plot(t,E1_error);
xlabel('Time');
ylabel('E1_{error}');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input('')
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)
subplot(3,1,1),plot(t,E2_kfe);
xlabel('Time');
ylabel('E2_{kfe}');
subplot(3,1,2),plot(t,E2_pmde);
xlabel('Time');
ylabel('E2_{pmde}');
subplot(3,1,3),plot(t,E2_error);
xlabel('Time');
ylabel('E2_{error}');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input('')
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
