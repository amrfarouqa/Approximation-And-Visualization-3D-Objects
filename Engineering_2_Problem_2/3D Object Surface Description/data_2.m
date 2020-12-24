% Data for animation <runner>
% master chain - body and head:
master_rigs_L=[0.15,0.5,0.15,0.2]   % bone lengths of master chain
master_rigs_CSec=[0.2  0.1 ; 0.1  0.2 ; 0.07  0.07; 0.12 0.12];  %radia of bone envelopes of master chain
% slave chains - legs adn hands: 
% bone lengths: 
slave_rigs_L{1}=[0.11,0.5,0.45]; %  left leg
slave_rigs_L{2}=[0.11,0.5,0.45]; %  right leg 
slave_rigs_L{3}=[0.2,0.35,0.35]; %  left hand
slave_rigs_L{4}=[0.2,0.35,0.35]; %  right hand
%radia of bone envelopes of slave chains:
slave_rigs_CSec{1}=[0.15  0.13  ; 0.11  0.07; 0.07 0.04];    
slave_rigs_CSec{2}=[0.15  0.15  ; 0.12  0.08; 0.08 0.05];  
slave_rigs_CSec{3}=[0.08  0.08  ; 0.08 0.05; 0.05 0.04]; 
slave_rigs_CSec{4}=[0.08  0.08  ; 0.08 0.05; 0.05 0.04];
% Calculation of bone coordinates of master and slave chains at the initial position of animation
% The angles to which the bones are rotated from reference positions along Ox to initial position of the skeleton:
kampai_master_0=   [ 0   -90    0  ; 0    -90  0;  0   -90   0; 0  -90   0] *pi/180;
kampai_slave_0{1}=[  0     0   90  ; 0     90  0;  0    90   0] *pi/180;  
kampai_slave_0{2}=[  0     0  -90  ; 0     90  0;  0    90   0] *pi/180; 
kampai_slave_0{3}=[  0    25   90  ; 0     90  0;  0    90   0] *pi/180;  
kampai_slave_0{4}=[  0    25  -90  ; 0     90  0;  0    90   0] *pi/180;

% displacements x,y,z of the base of the master chain:
shift_master_const= [0.1   0     0];      % constant component of displacement 
shift_master_vconst=[0.4   0     0];      % constant value of the velocity
shift_master_sin=   [  0   0     0];      % sine law component 
shift_master_sin2=  [  0   0  0.05];       % double frequency sin law component

% rotations of master chain bones about global axes:
kampai_master_const=  [  0   0   0  ;  0    0   0;   0    0   0; 0   -5   0] *pi/180;   % constant component of angles
kampai_master_sin=    [  0   0   5  ;  5    5 -15;   5    0  10; 0    0   0] *pi/180;   % sine law components
kampai_master_sin2=   [  0   0   0  ;  0    5   0;   0    0   0; 0   -5   0] *pi/180;    % double frequency sin law components
% rotations of slave  chain bones about global axes:
kampai_slave_const{1}=  [  0    7   0  ;  0     0    0;  0    35   0] *pi/180; % constant components of angles
kampai_slave_const{2}=  [  0    7   0  ;  0     0    0;  0    35   0] *pi/180; 
kampai_slave_const{3}=  [  0    0   0  ;  0   -10    0;  0   -80   0] *pi/180;  
kampai_slave_const{4}=  [  0    0   0  ;  0   -10    0;  0   -60   0] *pi/180;

kampai_slave_sin{1}=[  0    0  10  ;  0    30    0;  0    35   0] *pi/180;  % sine law components
kampai_slave_sin{2}=[  0    0  10  ;  0   -30    0;  0   -35   0] *pi/180 ; 
kampai_slave_sin{3}=[  0    0 -20  ;  0   -40    0;  0    30   0] *pi/180;  
kampai_slave_sin{4}=[  0    0 -20  ;  0    40    0;  0   -30   0] *pi/180;

