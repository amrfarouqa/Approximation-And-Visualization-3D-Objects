clc
close all

AngleNr=10;
LayerNr=20;

filename='T1_5'; 
FV = stlread([filename '.stl']); 
save([filename '.mat'], 'FV');

Vert=FV.vertices;
Faces=FV.faces;


Vert(:,1)=Vert(:,1)-mean(Vert(:,1));
Vert(:,2)=Vert(:,2)-mean(Vert(:,2)); 
Vert(:,3)=Vert(:,3)-min(Vert(:,3));
FV.vertices=Vert;

figure; hold on; view(130,20);
patch(FV,'facecolor',[1 1 0],'EdgeColor',[0.2 0.2 0.2],'FaceAlpha',0.6); camlight;
  
axis equal;
xlabel('x'); ylabel('y'); zlabel('z');

z0=min(Vert(:,3));
z1=max(Vert(:,3));
x0=min(Vert(:,1));
x1=max(Vert(:,1));
y0=min(Vert(:,2));
y1=max(Vert(:,2));


tol=1e-2*(z1-z0);
z1=z1-tol;
z0=z0+tol;
MaxD=50;

% dz-step on the z-axis to be on the z-axis LayerNr control layer
% content
% dttt-step in each layer, what number of values to take
% meaning that each control layer contained AngleNr
% control point
dz=(z1-z0)/(LayerNr-1);
dttt=2*pi/AngleNr;
ttt=0:dttt:2*pi;

%XX, YY, ZZ - arrays of checkpoint coordinates
XX=zeros(LayerNr,AngleNr);
YY=zeros(LayerNr,AngleNr);
ZZ=zeros(LayerNr,AngleNr);

% of the original 3d object with X and Y values standard
% grid
% not required ?????
[u,v]=meshgrid([min(Vert(:,1)), max(Vert(:,1))], [min(Vert(:,2)) max(Vert(:,2))]);
figure; hold on; view(130,20); axis equal;
patch(FV,'facecolor',[1 1 0],'EdgeColor',[0.2 0.2 0.2],'FaceAlpha',0.8);  camlight; 

for i=1:LayerNr  % of actions performed for each layer:
      ZLayer=z0+(i-1)*dz; % of current layer Z value = zfirst value + layer number * layer, z, value step
      % ELLayer returns the planes (vertex indices) that have vertices z
% less than the current layer
      ELLayer = Faces(ismember(sum([Vert(Faces(:,1),3)<ZLayer Vert(Faces(:,2),3)<ZLayer Vert(Faces(:,3),3)<ZLayer],2),[1 2]),:);     
      XMidLayer=mean(Vert(:,1)); 
      YMidLayer=mean(Vert(:,2));
     % marks the middle of the current layer
      plot3(XMidLayer,YMidLayer,ZLayer,'r.','MarkerSize',16);
      Line1=[XMidLayer YMidLayer ZLayer];
      for k=1:AngleNr+1
         xk=cos(ttt(k));
         yk=sin(ttt(k));
         X2Layer=XMidLayer+MaxD*xk;
         Y2Layer=YMidLayer+MaxD*yk;
         DistanceM=0;
         Line2=[X2Layer Y2Layer ZLayer];
         for m=1:size(ELLayer)% takes one plane (triangle) and checks that it does not intersect with the center line of the layer
             ELs=ELLayer(m,:);
             V=Vert(ELs,:);
             [inSegment, IntersectionX, IntersectionY, IntersectionZ]=lineIntersectsTriangle(Line1,Line2, V(1,:),V(2,:),V(3,:)); 
             distXYZ=norm([IntersectionX, IntersectionY, IntersectionZ]-Line1);
             % if finds the intersection of the plane and the line, the point writes i
% array
             if inSegment && distXYZ>DistanceM  
                 XX(i,k)=IntersectionX;
                 YY(i,k)=IntersectionY;
                 ZZ(i,k)=IntersectionZ;
                 DistanceM=distXYZ;
             end
         end
     end
     fprintf(1,'layer %d \r',i);
end
   
 figure; hold on; view(130,20);
 surf(XX,YY,ZZ); axis equal;
 plot3(XX,YY,ZZ,'ko','MarkerSize', 8);
 xlabel('x'); ylabel('y'); zlabel('z');
 
Thorizontal=ttt;
Tvertical=ZZ(:,1);
X=XX; Y=YY; Z=ZZ;
save([filename '.mat'], 'X', 'Y', 'Z','Thorizontal','Tvertical') 