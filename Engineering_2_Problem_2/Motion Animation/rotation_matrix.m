function R=rotation_matrix(kampai)
    % apskaiciuoja posukio matrica 3x3 pagal duotus posukio kampus apie 3 asis
    ang=norm(kampai);ax=kampai/ang;
    s=1;vx=0;vy=0;vz=0;
    if ang > 0, s=cos(ang/2);vx=ax(1)*sin(ang/2);vy=ax(2)*sin(ang/2);vz=ax(3)*sin(ang/2);end
    R=quaternion_to_matrix(s,vx,vy,vz); 
return
end
function R=quaternion_to_matrix(s,vx,vy,vz)
% pagal duotas kvaternijono komponentes apskaiciuoja posukio matrica 3x3
R=[1-2*vy^2-2*vz^2 ,  2*vx*vy-2*s*vz ,   2*vx*vz+2*s*vy; 
    2*vx*vy+2*s*vz  , 1-2*vx^2-2*vz^2,   2*vy*vz-2*s*vx;
    2*vx*vz-2*s*vy  ,  2*vy*vz+2*s*vx ,  1-2*vx^2-2*vy^2];
return
end