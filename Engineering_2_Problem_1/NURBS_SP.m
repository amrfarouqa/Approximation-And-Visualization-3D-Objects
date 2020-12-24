clc, close all,
clear all

load('T1_5.mat');
plot3(X,Y,Z, 'ko', 'MarkerSize', 8);

NURBS(X,Y,Z);

function NURBS(X,Y,Z)
W=[1 1 1  1 1 1 1 1;
   1 1 1  1 1 1 1 1; 
   1 1 1  1 1 1 1 1; 
   1 1 1 15 1 1 1 1; 
   1 1 1  1 1 1 1 1; 
   1 1 1  1 1 1 1 1; 
   1 1 1  1 1 1 1 1 ]   
ndivx=30,ndivy=30  % division number for imaging according to Ox and Oy directions in reference KS
W=ones(ndivx,ndivy); 
% Original image:
hf1=figure(1);hold on,grid on,axis equal, view([1 -1 1]) 
set(hf1,'Color','w');set(hf1,'Position',[300, 600, 500, 400]);  
xlabel('x');ylabel('y'),zlabel('z'); 
surf(X,Y,Z,'EdgeColor',[0.5 1. 0.2],'FaceColor',[1 0.5 0.5]); 
plot3(X,Y,Z,'ko'); 
nx=size(X,1);ny=size(X,2);   

hf2=figure(2);hold on,grid on,axis equal, view([1 -1 1])
set(hf2,'Color','w');
set(hf2,'Position',[700, 600, 500, 400]); 
xlabel('x');ylabel('y'),zlabel('z');   

for i=1:nx, for j=1:ny   % represents the given points
     h(i,j)=plot3(X(i,j),Y(i,j),Z(i,j),'.k','Marker','o','MarkerSize',10);
end, end     
hL=[];hM=[];   

NURBS_patch(X,Y,Z,W,ndivx,ndivy);   

disp('End'); 
return 
%*****************************************************************     
function NURBS_patch(X,Y,Z,W,ndivx,ndivy) 
% The function creates an interpolated surface according to the given
% ruler point coordinates X, Y, Z
% ndivx, ndivy - division number for representation according to Ox and Oy directions in reference KS
% control grid dimensions
nx=size(X,2);ny=size(X,1);   

% representation (fine) reference grid
xxb=[0:1/ndivx:1]; 
yyb=[0:1/ndivy:1]; 
nxx=length(xxb);nyy=length(yyb);   

% Bernstein polynomial arrays
BX=Bernstein_Func(xxb); 
BY=Bernstein_Func(yyb);  
if ~isempty(hL), delete(hL); end 
if ~isempty(hM), delete(hM); end    

   for iii=0:nx-4 % cycle through segments ********************
    for jjj=0:ny-4 % cycle through segments ********************
    Xr=reshape(X(jjj+1:jjj+4,iii+1:iii+4),16,1); 
    Yr=reshape(Y(jjj+1:jjj+4,iii+1:iii+4),16,1);  
    Zr=reshape(Z(jjj+1:jjj+4,iii+1:iii+4),16,1); 
    Wr=reshape(W(jjj+1:jjj+4,iii+1:iii+4),16,1);
    XX=zeros(1,nxx*nyy);
    YY=zeros(1,nxx*nyy);
    ZZ=zeros(1,nxx*nyy);
    WW=zeros(1,nxx*nyy); 
    k=0;
      for i=1:4, for j=1:4
         k=k+1;
         XX=XX+reshape(BY(j,:)'*BX(i,:),1,nxx*nyy)*Xr(k)*Wr(k);
         YY=YY+reshape(BY(j,:)'*BX(i,:),1,nxx*nyy)*Yr(k)*Wr(k);
         ZZ=ZZ+reshape(BY(j,:)'*BX(i,:),1,nxx*nyy)*Zr(k)*Wr(k);
         WW=WW+reshape(BY(j,:)'*BX(i,:),1,nxx*nyy)*Wr(k);
      end, end
    hL(iii+1,jjj+1)=surf(reshape(XX./WW,nyy,nxx),reshape(YY./WW,nyy,nxx),reshape(ZZ./WW,nyy,nxx),'FaceColor',[1 0.5 0.5],'EdgeColor',[0.5 1. 0.2]);
    end %*******************************************************
   end %*******************************************************
hM=surf(X,Y,Z,'EdgeColor','k','FaceColor','none');   
return
end 
%*****************************************************************

function B=Bernstein_Func(x)     
% n - number of ruling points
% x - display points in the parameter value range [0,1]
T=[x'.^3, x'.^2, x',x'.^0];         
CC=[ -1,  3, -3, 1;               
      3, -6,  3, 0;        
     -3,  0,  3, 0;        
      1,  4,  1, 0]/6;     
B=(T*CC)';
return
end
%***************************************************************** 
end   % This end ends the program description