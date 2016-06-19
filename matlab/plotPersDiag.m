function [] = plotPersDiag(y,tt)

hold on;

lim = 6;
% Plot the diagram
for ll = 1:size(y,1)
    plot(y(ll,1),y(ll,2),'ms');
end
plot([0 lim],[0 lim],'k');
axis equal; axis([0 lim 0 lim]);
line([0 lim], [0 lim]);
title(tt);

hold off;