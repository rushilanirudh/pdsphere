%compute sphere extrinsic mean
%expects set of points in cell array
function out = sphere_extrinsic_mean(cluster_points)
i=1;
n=length(cluster_points);
M=0;
for j=1:n
    M=M+cluster_points{j};
end
M=M/n;

out=M/norm(M);
end