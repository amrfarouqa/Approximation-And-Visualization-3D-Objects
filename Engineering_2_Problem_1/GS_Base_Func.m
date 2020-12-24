function [GS,sss]=GS_Base_Func(X,i,nnn,iopt)

%   calculates the base function of the global spline at the imaging points
% X - interpolation abscices
% i - basic function number
% nnn - the number of imaging points in each interval
% iopt - 0 (lean tip spline) or 1 (periodic spline)

nP=length(X);
GS=[];sss=[];
    Y=zeros(1,nP); Y(i)=1; DDF=Spline_Coeff(X,Y,iopt);
    for iii=1:nP-1  %------  cycle through the intervals between adjacent points
        [GS1,sss1]=Spline_Func(X(iii:iii+1),Y(iii:iii+1),DDF(iii:iii+1),nnn); % meanings and imaging abscises
%         plot(sss1,GS1)
%         pause
        GS=[GS,GS1];sss=[sss,sss1];
    end %----------------- end of cycle through intervals
return
end






