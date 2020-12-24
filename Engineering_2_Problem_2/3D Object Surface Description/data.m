% Duommenys animacijai <begikas>
% vedancioji grandine - liemuo ir galva:
master_rigs_L=[3,3,2,2.5]   % vedancios grandines kaulu ilgiai
master_rigs_CSec=[0.2  0.1 ; 0.1  0.2 ; 0.07  0.07; 0.12 0.12];  %vedancios grandines kuginiu kaulu apvalkalu pradzios ir galo spinduliai
% vedamosios grandines - kojos ir rankos: 
% kaulu ilgiai: 
slave_rigs_L{1}=[0.8,3.5,2.2,1.5]; %  kaire koja
slave_rigs_L{2}=[0.8,3.5,2.2,1.5]; %  desine koja
slave_rigs_L{3}=[0.8,3,3,1]; %  kaire ranka
slave_rigs_L{4}=[0.8,3,3,1]; %  desine ranka
%vedamuju grandiniu kuginiu kaulu apvalkalu pradzios ir galo spinduliai:
slave_rigs_CSec{1}=[0.15  0.15  ; 0.11  0.07; 0.11  0.07; 0.11  0.07];    
slave_rigs_CSec{2}=[0.15  0.15  ; 0.11  0.07; 0.11  0.07; 0.11  0.07];  
slave_rigs_CSec{3}=[0.08  0.08  ; 0.08 0.05; 0.05 0.04; 0.05 0.04]; 
slave_rigs_CSec{4}=[0.08  0.08  ; 0.08 0.05; 0.05 0.04; 0.05 0.04];
% Apskaiciuojamos vedancios ir vedamos grandiniu kaulu koordinates pradineje animacijos padetyje.
% The angles to which the bones are rotated from reference positions along Ox to initial position of the skeleton:   
kampai_master_0=   [ 0   -5    0  ; 0    -15  0;  0   -10   0; 0  35   0] *pi/180;
kampai_slave_0{1}=[  0     0   90  ; 0     60  0;  0    130   0; 0    5   0] *pi/180;  
kampai_slave_0{2}=[  0     0  -90  ; 0     60  0;  0    130   0; 0    5   0] *pi/180; 
kampai_slave_0{3}=[  0    0   90  ; 0     105  0;  0    90   0; 0    0   0] *pi/180;  
kampai_slave_0{4}=[  0    0  -90  ; 0     105  0;  0    90   0; 0    0   0] *pi/180;
% displacements x,y,z of the base of the master chain:
shift_master_const= [0   0   0];      % constant component of displacement
shift_master_vconst=[0   0   0];      % constant value of the velocity
shift_master_sin=   [0   0   0];      % sine law component 
shift_master_sin2=  [0   0   0];      % double frequency sin law component
% rotations of master chain bones about global axes:
kampai_master_const=  [  0   0   0  ;  0    0   0;   0    0   0; 0   0   0] *pi/180;   % constant component of angles
kampai_master_sin=    [  0   0   0  ;  0    0   0;   0    0   0; 0   0   0] *pi/180;   % sine law components
kampai_master_sin2=   [  0   0   0  ;  0    0   0;   0    0   0; 0   0   0] *pi/180;   % double frequency sin law components
% rotations of slave  chain bones about global axes:
kampai_slave_const{1}=  [  0    0   0  ;  0   0    0;  0   0   0; 0    0   0] *pi/180;  % constant components of angles
kampai_slave_const{2}=  [  0    0   0  ;  0     0    0;  0     0   0; 0     0   0] *pi/180; 
kampai_slave_const{3}=  [  0    0   0  ;  0     0    0;  0     0   0; 0     0   0] *pi/180;  
kampai_slave_const{4}=  [  0    0   0  ;  0     0    0;  0     0   0; 0     0   0] *pi/180;

kampai_slave_sin{1}=    [  0    0   0  ;  0    0    0;  0   0   0;0     0   0] *pi/180;  % sine law components
kampai_slave_sin{2}=    [  0    0   0  ;  0     0    0;  0     0   0;0     0   0] *pi/180 ; 
kampai_slave_sin{3}=    [  0    0   0  ;  0     0    0;  0     0   0;0     0   0] *pi/180;  
kampai_slave_sin{4}=    [  0    0   0  ;  0     0    0;  0     0   0;0     0   0] *pi/180;

