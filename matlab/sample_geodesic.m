function sample_geodesic(p1,p2)


count = 1;
x1 = 0:.01:2; x2 = 0:.01:2;
for i = [0 0.25 0.5 0.75 1]
 %   h2t = exp_map(p1,v12,i);
   h2t = sphere_geodesic(p1,p2,i);
    subtightplot(2,5,count+5,[0.01 0.01], [0.01 0.01], [0.01 0.01])
    
    surf(x1,x2,reshape(h2t.^2,201,201),'LineStyle','none')
    set(gca,'YDir','normal')
    view([28,16]);
    axis off
    axis square
    count = count+1;
end

% 
% for i = [0 0.25 0.5 0.75 1]
%     h2t = exp_map(p1,v13,i);
%     subtightplot(2,5,count,[0.02 0.02], [0.05 0.05], [0.05 0.05])
%     surf(x1,x2,reshape(h2t.^2,201,201),'LineStyle','none')
%     set(gca,'YDir','normal')
%     % axis([0 51 0 51 0 0.03])
%     view([0,90])
%     count = count+1;
% end
end