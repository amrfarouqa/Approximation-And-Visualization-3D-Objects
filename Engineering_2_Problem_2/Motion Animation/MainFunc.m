figure(1); hold on; axis equal;  grid on;
load('Camel.mat');
FVV=FV.vertices; FVV(:,2)=-FVV(:,2); 
FV.vertices=FVV;

patch(FV,'facecolor',[1 1 0],'EdgeColor','None','FaceAlpha',0.4);  camlight;
xlabel('x'); ylabel('y'); zlabel('z'); 
% Bones Connection Points (X Y Z)
Nodes=[-20 -30 10; % Back Leg Left 1
       20 -30 10; % Back LEg Right 2
       0 -40 40; % TailBone 3
       0 10 40; % Back Bone 4
       0 20 40; % Nech Bone 5
       -20 20 10; % 6 Front Leg  Left 
       20 20 10; % 7 Front Leg Right 
       0 40 50]; % Head 8
GChain=[1 3 2 3 4 5 6 5 7 5 8]; %Bones Connection Flow
plot3(Nodes(GChain,1),Nodes(GChain,2),Nodes(GChain,3),'r-','LineWidth',3);view(130,20);
% for i=1:numel(Chains)
%     plot3(Nodes(Chains{i},1),Nodes(Chains{i},2),Nodes(Chains{i},3),'r-','LineWidth',3);
% end
plot3(Nodes(:,1),Nodes(:,2),Nodes(:,3),'b*','MarkerSize',6);
axis equal;
xlabel('x'); ylabel('y'); zlabel('z');
n(1)=numel(GChain)-1; % valdancios grandines kaulai
% Joints=[];
% for i=1:n(1)
%     Joints=[Joints; GChain(i:i+1)];
% end
% GAngles=[0 0 0;  0 0 5; 0 0 0; 0 0 0; 0 0 0] *pi/180; 
% GAngles2=[1 0 0; 0 0 0; 0 0 0; 10 10  0; 0 0 0] *pi/180; 
% GAnglesConst=[1 0 0;  0 0 0; 0 0 0; 0 0 0; 0 0 0] *pi/180; 

%[1st Bone (X Y Z);      2nd One ; 3rd Bone ; 4th Bone ; 5th Bone ; 6th Bone ; 7th Bone ; 8th Bone] Amplitude
GAngles=        [0 0 0;  0 0 0;    0 0 0;     0 0 0;     0 0 0;     0 0 0;     0 0 0;     0 0 0; 0 0 0; 20 0 0] *pi/180; 
GAngles2=       [0 0 0;  0 0 0;    0 0 0;     0 0 0;     0 0 0;     0 0 0;     0 0 0;     0 0 0; 0 0 0; 0 0 0] *pi/180; 
GAnglesConst=   [0 0 0;  0 0 0;    0 0 0;     0 0 0;     0 0 0;     0 0 0;     0 0 0;     0 0 0; 0 0 0; 0 0 0] *pi/180; 

GShiftSin=[0 0.02 0];
GShift=[0 0 0];
GShiftV=[0 5 0];
Gn=n(1);
pause
figure(1); hold on; axis([-50 50 -100 200 0 60]);
view(130,20);
% view(160,10);
%animation Time
for ang=0:0.1:300
    cla;
    Tshift=eye(4,4); Tcum=eye(4,4);
    Tshift(1:3,4)=Nodes(GChain(1),:)';
    AnglesMasterC=GAngles*sin(ang)+GAngles2*sin(2*ang)+GAnglesConst;
    DispMasterC=GShiftSin*sin(ang)+GShift+GShiftV*ang;
    for i=1:Gn
        R=rotation_matrix(AnglesMasterC(i,:)); % turn matrix 3x3
        Tcum=Tcum*[R,zeros(3,1);zeros(1,3),1]; % Most Important Line Read the Lecture of skeleton
        Tmaster{i}=Tshift*Tcum;
        A1=Tmaster{i}*[Nodes(GChain(i:i+1),1)'-Nodes(GChain(i),1);
            Nodes(GChain(i:i+1),2)'-Nodes(GChain(i),2);
            Nodes(GChain(i:i+1),3)'-Nodes(GChain(i),3);
            ones(1,2)];
        x1=A1(1,:);y1=A1(2,:);z1=A1(3,:);
        Tshift(1:3,4)=[x1(end);y1(end);z1(end)]; % shift from the beginning of the GKS to the matrix of the next bone starting point
        %--------------------------------------------------------------
        plot3(x1,y1,z1,'r-');
        plot3(x1,y1,z1,'b*','MarkerSize',6);

    end
    pause(0.01)
end