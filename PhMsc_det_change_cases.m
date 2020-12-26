function [] = PhMsc_det_change_cases()
clc

global det_changes_entities det_changes_capacity det_changes_servers;
global det_changes_times;
global start_time end_time;
start_time=0;
end_time=100;

input('\nEnter all inputs as row vectors\n\nPress Enter to continue\n');

dummy_det_changes_times_en = ...
    input('\nEnter the times for deterministic entity changes\n');

dummy_det_changes_entities = ...
    input('\nEnter the corresponding entity changes\n');

dummy_det_changes_times_cap = ...
    input('\nEnter the times for deterministic capacity changes\n');

dummy_det_changes_capacity = ...
    input('\nEnter the corresponding capacity changes\n');

dummy_det_changes_times_ser = ...
    input('\nEnter the times for deterministic capacity changes\n');

dummy_det_changes_servers = ...
    input('\nEnter the corresponding capacity changes\n');



dummy_det_changes_times_en  =  dummy_det_changes_times_en';
dummy_det_changes_entities  =  dummy_det_changes_entities';

dummy_det_changes_times_cap =  dummy_det_changes_times_cap';
dummy_det_changes_capacity  =  dummy_det_changes_capacity';

dummy_det_changes_times_ser =  dummy_det_changes_times_ser';
dummy_det_changes_servers   =  dummy_det_changes_servers';


size_dummy_det_changes_times_en  = size(dummy_det_changes_times_en);
size_dummy_det_changes_times_cap = size(dummy_det_changes_times_cap);
size_dummy_det_changes_times_ser = size(dummy_det_changes_times_ser);

size_dummy_det_changes_times_en  = size_dummy_det_changes_times_en(1);
size_dummy_det_changes_times_cap = size_dummy_det_changes_times_cap(1);
size_dummy_det_changes_times_ser = size_dummy_det_changes_times_ser(1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

det_changes_times=[];
det_changes_entities=[];
det_changes_capacity=[];
det_changes_servers=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if size_dummy_det_changes_times_en > 0
    
det_changes_times(1 : size_dummy_det_changes_times_en , 1)=...    
dummy_det_changes_times_en(1 : size_dummy_det_changes_times_en , 1);

end

if size_dummy_det_changes_times_cap > 0
    
det_changes_times(size_dummy_det_changes_times_en + 1 :...
size_dummy_det_changes_times_en + size_dummy_det_changes_times_cap,1)=...
dummy_det_changes_times_cap(1 : size_dummy_det_changes_times_cap,1);

end

if size_dummy_det_changes_times_ser > 0

det_changes_times(size_dummy_det_changes_times_en + ...
size_dummy_det_changes_times_cap + 1 : size_dummy_det_changes_times_en +...
size_dummy_det_changes_times_cap + size_dummy_det_changes_times_ser ,1)=...
dummy_det_changes_times_ser(1 : size_dummy_det_changes_times_ser,1);

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if size_dummy_det_changes_times_en > 0
    
det_changes_entities(1 : size_dummy_det_changes_times_en,1)=...
dummy_det_changes_entities(1 : size_dummy_det_changes_times_en,1);

end

if size_dummy_det_changes_times_cap > 0
    
det_changes_entities(size_dummy_det_changes_times_en + 1 : ...
size_dummy_det_changes_times_en+size_dummy_det_changes_times_cap,1)=0;

end

if size_dummy_det_changes_times_ser>0
det_changes_entities(size_dummy_det_changes_times_en+...
size_dummy_det_changes_times_cap+1:...
size_dummy_det_changes_times_en+size_dummy_det_changes_times_cap+...
size_dummy_det_changes_times_ser,1)=0;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if size_dummy_det_changes_times_en>0
det_changes_capacity(1:size_dummy_det_changes_times_en,1)=0;
end

if size_dummy_det_changes_times_cap>0
det_changes_capacity(size_dummy_det_changes_times_en+1:...
size_dummy_det_changes_times_en+size_dummy_det_changes_times_cap,1)=...
dummy_det_changes_capacity(1:size_dummy_det_changes_times_cap,1);
end

if size_dummy_det_changes_times_ser>0
det_changes_capacity(size_dummy_det_changes_times_en+...
size_dummy_det_changes_times_cap+1:...
size_dummy_det_changes_times_en+size_dummy_det_changes_times_cap+...
size_dummy_det_changes_times_ser,1)=0;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if size_dummy_det_changes_times_en>0
det_changes_servers(1:size_dummy_det_changes_times_en,1)=0;
end

if size_dummy_det_changes_times_cap>0
det_changes_servers(size_dummy_det_changes_times_en+1:...
size_dummy_det_changes_times_en+size_dummy_det_changes_times_cap,1)=0;
end

if size_dummy_det_changes_times_ser>0
det_changes_servers(size_dummy_det_changes_times_en+...
size_dummy_det_changes_times_cap+1 : size_dummy_det_changes_times_en+...
size_dummy_det_changes_times_cap+size_dummy_det_changes_times_ser,1)=...
dummy_det_changes_servers(1:size_dummy_det_changes_times_ser,1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



if (size_dummy_det_changes_times_cap+size_dummy_det_changes_times_en+...
     size_dummy_det_changes_times_ser)>0
[det_changes_times,index]=sort(det_changes_times);

dummy_det_changes_entities=det_changes_entities;
dummy_det_changes_capacity=det_changes_capacity;
dummy_det_changes_servers=det_changes_servers;

vector_size=size(index);
vector_size=vector_size(1,1);

for i=1:vector_size
    det_changes_entities(i,1)=dummy_det_changes_entities(index(i));
    det_changes_capacity(i,1)=dummy_det_changes_capacity(index(i));
    det_changes_servers(i,1)=dummy_det_changes_servers(index(i));
end

dummy_det_changes_times=det_changes_times;
dummy_det_changes_entities=det_changes_entities;
dummy_det_changes_capacity=det_changes_capacity;
dummy_det_changes_servers=det_changes_servers;



det_changes_times=[];
det_changes_entities=[];
det_changes_capacity=[];
det_changes_servers=[];

i=1;
j=1;

while i<=vector_size
    if i<vector_size
        if dummy_det_changes_times(i,1)~=dummy_det_changes_times(i+1,1)
            det_changes_times(j,1)=dummy_det_changes_times(i,1);
            
            det_changes_entities(j,1)=dummy_det_changes_entities(i,1);
            
            det_changes_capacity(j,1)=dummy_det_changes_capacity(i,1);
            
            det_changes_servers(j,1)=dummy_det_changes_servers(i,1);
            
            i=i+1;
            j=j+1;
        else
            if i<vector_size-1
                if dummy_det_changes_times(i,1)==...
                        dummy_det_changes_times(i+2,1)
                    
                    det_changes_times(j,1) = ...
                        dummy_det_changes_times(i,1);
                    
                    det_changes_entities(j,1) = ...
                        sum(dummy_det_changes_entities(i:i+2,1));
                    
                    det_changes_capacity(j,1) = ...
                        sum(dummy_det_changes_capacity(i:i+2,1));
                    
                    det_changes_servers(j,1) = ...
                        sum(dummy_det_changes_servers(i:i+2,1));
                    
                    i=i+3;
                    j=j+1;
                    
                else
                    
                    det_changes_times(j,1) = ...
                        dummy_det_changes_times(i,1);
                    
                    det_changes_entities(j,1) = ...
                        sum(dummy_det_changes_entities(i:i+1,1));
                    
                    det_changes_capacity(j,1) = ...
                        sum(dummy_det_changes_capacity(i:i+1,1));
                    
                    det_changes_servers(j,1) = ...
                        sum(dummy_det_changes_servers(i:i+1,1));
                    
                    i=i+2;
                    j=j+1;
                    
                    
                end
                    
            else
                det_changes_times(j,1)=dummy_det_changes_times(i,1);
                
                det_changes_entities(j,1)=...
                    sum(dummy_det_changes_entities(i:i+1,1));
                
                det_changes_entities(j,1)=...
                    sum(dummy_det_changes_entities(i:i+1,1));
                
                det_changes_entities(j,1)=...
                    sum(dummy_det_changes_entities(i:i+1,1));
                
                i=i+2;
                j=j+1;
            end
            
            
        end
        
    else
        
        det_changes_times(j,1)=dummy_det_changes_times(i,1);
        
        det_changes_entities(j,1)=dummy_det_changes_entities(i,1);
        
        det_changes_capacity(j,1)=dummy_det_changes_capacity(i,1);
        
        det_changes_servers(j,1)=dummy_det_changes_servers(i,1);
        
        i=i+1;
        j=j+1;
        
    end
            
end

vector_size=size(det_changes_times);
vector_size=vector_size(1,1);

if det_changes_times(1,1)~=start_time
    det_changes_times(2:vector_size+1,1)=...
                                det_changes_times(1:vector_size,1);
    det_changes_times(1,1)=start_time;                        
    
    det_changes_entities(2:vector_size+1,1)=...
                                det_changes_entities(1:vector_size,1);
    det_changes_entities(1,1)=0;                        

    det_changes_capacity(2:vector_size+1,1)=...
                                det_changes_capacity(1:vector_size,1);
    det_changes_capacity(1,1)=0;                        
    
    det_changes_servers(2:vector_size+1,1)=...
                                det_changes_servers(1:vector_size,1);
    det_changes_servers(1,1)=0;                        
end

if det_changes_times(vector_size,1)~=end_time
    det_changes_times(vector_size+1,1)=end_time;                        
    
    det_changes_entities(vector_size+1,1)=0;                        

    det_changes_capacity(vector_size+1,1)=0;                        
    
    det_changes_servers(vector_size+1,1)=0;                        
end

det_changes_times
det_changes_entities
det_changes_capacity
det_changes_servers
input('')



else
   
det_changes_times
det_changes_entities
det_changes_capacity
det_changes_servers
input('')   
    

end


end