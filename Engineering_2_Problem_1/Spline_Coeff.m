
function DDF=Spline_Coeff(X,Y,iopt)
% calculated second derivatives of spline nodes
% iopt=1 - periodic splines

n=length(X);
A=zeros(n);b=zeros(n,1);
d=X(2:n)-X(1:(n-1));
 for i=1:n-2
     A(i,i:i+2)=[d(i)/6, (d(i)+d(i+1))/3,d(i+1)/6];
     b(i)=(Y(i+2)-Y(i+1))/d(i+1)-(Y(i+1)-Y(i))/d(i);
 end
 
if iopt == 0,  A(n-1,1)=1;A(n,n)=1;
else, A(n-1,[1,2,n-1,n])=[d(1)/3, d(1)/6, d(n-1)/6,d(n-1)/3]; 
      A(n,[1,n])=[1,-1];  
      b(n-1)=(Y(2)-Y(1))/d(1)-(Y(n)-Y(n-1))/d(n-1);
end

DDF=A\b;
 
return
end