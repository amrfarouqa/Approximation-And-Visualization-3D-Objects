clc, close all,
clear all,

load('T1_5.mat');
plot3(X,Y,Z, 'ko', 'MarkerSize', 8);
GlobalSpline(X,Y,Z);

 function GlobalSpline(X,Y,Z)
 iopt=1; % free ends or periodic
 ndivx=15,ndivy=10  % dividing the number for representation by Ox and Oy directions in the reference KS
  % Original image:
 hf1=figure(1);hold on,grid on,axis equal, %view([1 -1 1])
 set(hf1,'Color','w');set(hf1,'Position',[300, 600, 500, 400]);
  xlabel('x');ylabel('y'),zlabel('z');
 surf(X,Y,Z,'EdgeColor',[0.5 1. 0.2],'FaceColor',[1 0.5 0.5]);
 plot3(X,Y,Z,'ko');
 nx=size(X,1);ny=size(X,2);
 hf2=figure(2);hold on,grid on,axis equal, view([1 -1 1]),%axis([-9 9 -9 9 -9 9]);
 set(hf2,'Color','w');set(hf2,'Position',[700, 600, 500, 400]);
 xlabel('x');ylabel('y'),zlabel('z');

 for i=1:nx, for j=1:ny   % depicts given points
 h(i,j)=plot3(X(i,j),Y(i,j),Z(i,j),'.k','Marker','o','MarkerSize',10,'ButtonDownFcn',@startDragFcn);
 end, end
 hL=[];
 GS_Para_Func(X,Y,Z,ndivx,ndivy,iopt);

disp('End'); 
 return

 %*****************************************************************
 function GS_Para_Func(X,Y,Z,ndivx,ndivy,iopt)
% The function creates an interpolated surface according to the given
% control point coordinates X, Y, Z
% ndivx, ndivy - division number for representation according to Ox and Oy directions in reference KS
% control (large) reference grid
 xb=[1:size(X,2)];yb=[1:size(X,1)];
 nx=length(xb);ny=length(yb); 

% representation (fine) reference grid
 nxx=ndivx*(nx-1);nyy=ndivy*(ny-1);  

% Interpolated x, y, z coordinates:
 Xr=reshape(X,nx*ny,1); Yr=reshape(Y,nx*ny,1); Zr=reshape(Z,nx*ny,1);
 XX=zeros(1,nxx*nyy);   YY=zeros(1,nxx*nyy);   ZZ=zeros(1,nxx*nyy);
 k=0;
 for i=1:nx
     [GX,xxx]=GS_Base_Func(xb,i,ndivx,iopt);     
     for j=1:ny
         [GY,yyy]=GS_Base_Func(yb,j,ndivy,iopt);
         k=k+1;
         XX=XX+reshape(GY'*GX,1,nxx*nyy)*Xr(k);
         YY=YY+reshape(GY'*GX,1,nxx*nyy)*Yr(k);
         ZZ=ZZ+reshape(GY'*GX,1,nxx*nyy)*Zr(k);
     end
 end

 % [XX,YY]=meshgrid(xxx,yyy);
 if ~isempty(hL), delete(hL); end
 hL=surf(reshape(XX,nyy,nxx),reshape(YY,nyy,nxx),reshape(ZZ,nyy,nxx),'FaceColor',[1 0.5 0.5],'EdgeColor',[0.5 1. 0.2]);
 return
 end

 end   % This end ends the program description