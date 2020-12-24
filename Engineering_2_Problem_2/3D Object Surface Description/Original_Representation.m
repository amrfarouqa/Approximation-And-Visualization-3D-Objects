figure(1); hold on; axis equal;  grid on;
FV=stlread('T2_5.stl');
FVV=FV.vertices; FVV(:,2)=-FVV(:,2); 
FV.vertices=FVV;

patch(FV,'facecolor',[1 1 0],'EdgeColor','None','FaceAlpha',0.4);  camlight;
xlabel('x'); ylabel('y'); zlabel('z'); 
view([-10 0 0]);