function out = Sphere_PGA(phi,k)
%%perform Principal Geodesic Analysis on the Hypersphere
[M,N] = size(phi);
PGAfeats = zeros(N*k,M);
disp('********');
for n = 1:N
    str = sprintf('Computing PGA features for joint %d',n);
    disp(str);
    mu = sphere_extrinsic_mean(phi(:,n));
    for m = 1:M
        V(:,m) = log_map(mu,phi{m,n});
    end
    [pc,w,ev] = pca(V');
    PGAfeats((n-1)*k+1:n*k,:) = w(:,1:k)';
end
out = PGAfeats;