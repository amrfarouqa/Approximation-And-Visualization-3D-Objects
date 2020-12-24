function [S,sss]=Spline_Func(X,Y,DDF,nnn)
% calculation of the spline in the interval between two points
% nnn - number of tz in the image
% S - spline meanings
% sss - absicess
d=X(2)-X(1);
sss=X(1):(X(2)-X(1))/(nnn-1):X(2);
S=DDF(1)/2*(sss-X(1)).^2+(DDF(2)-DDF(1))/(6*d)*(sss-X(1)).^3+(sss-X(1))*((Y(2)-Y(1))/d-DDF(1)*d/3-DDF(2)*d/6) +Y(1);

return
end