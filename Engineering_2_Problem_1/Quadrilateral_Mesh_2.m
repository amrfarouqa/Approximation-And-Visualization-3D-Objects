
close all; clc;

FV = stlread('T1_5.stl');
patch(FV,'FaceColor', [0.5 0.5 0.5]);
title("original STL");
axis equal; grid on; view([1 1 1]);
%centering >>
middleX=mean(FV.vertices(FV.vertices(:,3)==0,1));
middleY=mean(FV.vertices(FV.vertices(:,3)==0,2));
FV.vertices(:,1)=FV.vertices(:,1)-middleX;
FV.vertices(:,2)=FV.vertices(:,2)-middleY;
%<<centering 
figure;
title("centered STL");
patch(FV, 'FaceColor', [0.5 0.5 0.5]); 
axis equal; grid on; view([1 1 1]);
eps = 1e-2;
NumberLayers=11;
NumberAngles=10;
hmin=min(FV.vertices(:,3));
hmax=max(FV.vertices(:,3));
h=[hmin+eps:(hmax-hmin)/(NumberLayers-1):hmax-eps hmax-eps];
ang=0:2*pi/(NumberAngles - 1):2*pi;
[X,Y,Z]=QuadroMesh(FV,h,ang);
figure();
surf(X,Y,Z);
axis equal;
grid on;
view([1 -1 1]);
title('Quadrilateral Mesh')

function [X, Y, Z]=QuadroMesh(FV,h,ang)
maxDis=1000;
nh=length(h);
nang=length(ang);
nfaces=size(FV.faces,1);
X=zeros(nh,nang);
Y=zeros(nh,nang);
Z=zeros(nh,nang);
for i=1:nh
    hi=h(i);
    Fi=[];%accumulate and store the faces (triagnles)
    for k=1:nfaces 
        V=FV.vertices(FV.faces(k,:),:);
        minZ=min(V(:,3));
        maxZ=max(V(:,3));
        if minZ<=hi && maxZ>=hi 
            Fi=[Fi k];
        end
    end
    for j=1:nang 
        Z(i,j)=hi;
        angj=ang(j);
        P1=[0 0 hi];
        P2=[maxDis*cos(angj) maxDis*sin(angj) hi]; 
        dist=0;
        for k=Fi 
            V=FV.vertices(FV.faces(k, :), :);
            [inSegment,x,y,z]=lineIntersectsTriangle(P1,P2,V(1,:),V(2,:),V(3,:));
            if inSegment && norm([x y])>dist
                X(i,j)=x;
                Y(i,j)=y;
                Z(i,j)=z;
                dist=norm([x y]); 
            end
        end
    end
    
end
end
