clc, close all,
clear all

load('T1_5.mat');
Hermitian(X, Y, Z)

function Hermitian(X,Y,Z)
    %xb=[0,1];yb=[0,1];
    xb=(0:10),yb=(0:19);
 [X0,Y0]=meshgrid(xb,yb)  % Reference grid

   ndivx=15,ndivy=10  % division number for imaging according to Ox and Oy directions in reference KS
% Original image:

hf1=figure(1);hold on,grid on,axis equal, view([1 -1 1])
set(hf1,'Color','w');set(hf1,'Position',[300, 300, 500, 400]);
xlabel('x');ylabel('y'),zlabel('z');
surf(X,Y,Z,'EdgeColor',[0.5 1. 0.2],'FaceColor',[1 0.5 0.5]); plot3(X,Y,Z,'ko');
nx=size(X,1);ny=size(X,2);

hf2=figure(2);hold on,grid on,axis equal,
% axis([min(min(X)) max(max(X)) min(min(Y)) max(max(Y)) -1 3]*1.5);
view([1 -1 1]),
set(hf2,'Color','w');set(hf2,'Position',[700, 300, 500, 400]);
xlabel('x');ylabel('y'),zlabel('z');

   for i=1:nx, for j=1:ny   % represents the given points
     h(i,j)=plot3(X(i,j),Y(i,j),Z(i,j),'.k','Marker','o','MarkerSize',10,'ButtonDownFcn',@startDragFcn);
 end, end
     hL=[];
Hermitian_Para_Func(X,Y,Z,ndivx,ndivy);
disp('End'); 
return

   %*****************************************************************

   function Hermitian_Para_Func(X,Y,Z,ndivx,ndivy)
% The function creates an interpolated surface according to the given
% control point coordinates X, Y, Z
% ndivx, ndivy - division number for representation according to Ox and Oy directions in reference KS
    nxxx=size(X,2);nyyy=size(X,1);
 if ~isempty(hL), delete(hL); end

% Approximate derivative recalculation in internal network points
 DZX=zeros(size(Z));DZY=zeros(size(Z));
 DXX=zeros(size(X));DXY=zeros(size(X));
 DYX=zeros(size(Y));DYY=zeros(size(Y));

 for iii=1:nxxx %-------------- numerical derivative evaluation of nodes
     if iii==1,i1=iii+1;i2=iii;
     elseif iii==nxxx, i1=iii;i2=iii-1;
     else, i1=iii+1;i2=iii-1;
     end
     for jjj=1:nyyy %------------------------------------------
             if jjj==1,j1=jjj+1;j2=jjj;
             elseif jjj==nyyy, j1=jjj;j2=jjj-1;
             else, j1=jjj+1;j2=jjj-1;
             end
             dx=X0(jjj,i1)-X0(jjj,i2);   dy=Y0(j1,iii)-Y0(j2,iii);
             if dy~=0
                 DZY(jjj,iii)= (Z(j1,iii)-Z(j2,iii))/dy;
                 DXY(jjj,iii)= (X(j1,iii)-X(j2,iii))/dy;
                 DYY(jjj,iii)= (Y(j1,iii)-Y(j2,iii))/dy;
             end
            if dx~=0
                 DZX(jjj,iii)= (Z(jjj,i1)-Z(jjj,i2))/dx;
                 DXX(jjj,iii)= (X(jjj,i1)-X(jjj,i2))/dx;
                 DYX(jjj,iii)= (Y(jjj,i1)-Y(jjj,i2))/dx;
            end
     end %------------------------------------------
 end %------------------------------------------ 

 for iii=1:nxxx-1 %------------------------------------------
        for jjj=1:nyyy-1 %------------------------------------------
         Xs=X(jjj:jjj+1,iii:iii+1);
         Ys=Y(jjj:jjj+1,iii:iii+1);
         Zs=Z(jjj:jjj+1,iii:iii+1);

         DZXs=DZX(jjj:jjj+1,iii:iii+1);
         DZYs=DZY(jjj:jjj+1,iii:iii+1);
         DXXs=DXX(jjj:jjj+1,iii:iii+1);
         DXYs=DXY(jjj:jjj+1,iii:iii+1);
         DYXs=DYX(jjj:jjj+1,iii:iii+1);
         DYYs=DYY(jjj:jjj+1,iii:iii+1);

   % reference grid
         xb=[1:size(Xs,2)];yb=[1:size(Xs,1)];
         nx=length(xb);ny=length(yb);

   % display (fine) reference grid
         xxb=[min(xb):(max(xb)-min(xb))/ndivx:max(xb)];
         yyb=[min(yb):(max(yb)-min(yb))/ndivy:max(yb)];
         nxx=length(xxb);nyy=length(yyb);

   % Calculation of double Hermit polynomials and accumulation of sum:
 Xr=reshape(Xs,nx*ny,1);DXXr=reshape(DXXs,nx*ny,1);DXYr=reshape(DXYs,nx*ny,1);
 Yr=reshape(Ys,nx*ny,1);DYXr=reshape(DYXs,nx*ny,1);DYYr=reshape(DYYs,nx*ny,1);
 Zr=reshape(Zs,nx*ny,1);DZXr=reshape(DZXs,nx*ny,1);DZYr=reshape(DZYs,nx*ny,1);
 XX=zeros(1,nxx*nyy);YY=zeros(1,nxx*nyy);ZZ=zeros(1,nxx*nyy); k=0;

  for i=1:nx, [UX,VX]=Hermite(xb,i,xxb);  %LX=Lagrange(xb,i,xxb);
     for j=1:ny,[UY,VY]=Hermite(yb,j,yyb); %LY=Lagrange(yb,j,yyb);
         k=k+1;
 %         XX=XX+reshape(LY'*LX,1,nxx*nyy)*Xr(k);
 %         YY=YY+reshape(LY'*LX,1,nxx*nyy)*Yr(k);

         XX=XX+reshape(UY'*UX,1,nxx*nyy)*Xr(k)+reshape(VY'*UX,1,nxx*nyy)*DXYr(k)+reshape(UY'*VX,1,nxx*nyy)*DXXr(k);
         YY=YY+reshape(UY'*UX,1,nxx*nyy)*Yr(k)+reshape(VY'*UX,1,nxx*nyy)*DYYr(k)+reshape(UY'*VX,1,nxx*nyy)*DYXr(k);
         ZZ=ZZ+reshape(UY'*UX,1,nxx*nyy)*Zr(k)+reshape(VY'*UX,1,nxx*nyy)*DZYr(k)+reshape(UY'*VX,1,nxx*nyy)*DZXr(k);
     end
 end

  hL(iii,jjj)=surf(reshape(XX,nyy,nxx),reshape(YY,nyy,nxx),reshape(ZZ,nyy,nxx),'FaceColor',[1 0.5 0.5],'EdgeColor',[0.5 1. 0.2]);
       end %------------------------------------------
 end %------------------------------------------
 return
 end
 %*****************************************************************

 end   % This end ends the program description
 %*****************************************************************
 %*****************************************************************
 %*****************************************************************

 function [U,V]=Hermite(X,j,x)  % Hermit polynomials
     L=Lagrange(X,j,x); DL=D_Lagrange(X,j,X(j));
     U=(1-2*DL.*(x-X(j))).*L.^2;
     V=(x-X(j)).*L.^2;
 return
 end

 function L=Lagrange(X,j,x)   % Lagrange polynomial
     n=length(X);
         L=1;
     for k=1:n, if k ~= j, L=L.*(x-X(k))/(X(j)-X(k)); end, end
 return
 end

 function DL=D_Lagrange(X,j,x)  % Lagrange polynomial derived by x
     n=length(X);
         DL=0; % DL resolution counter
     for i=1:n % cycle per rejected members
         if i==j, continue, end
          Lds=1;
         for k=1:n,
             if k ~= j && k ~= i , Lds=Lds.*(x-X(k)); end, end
         DL=DL+Lds;
     end
     Ldv=1;   % DL resolution denominator
      for k=1:n,
          if k ~= j, Ldv=Ldv.*(X(j)-X(k)); end,
      end
     DL=DL/Ldv;
 return
 end 