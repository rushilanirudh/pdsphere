function out = hmap2sphere(HT_map)

[M,N] = size(HT_map);
phi = cell(M,N);

for m = 1:M
    for n = 1:N
        h = HT_map{m,n};
        ht = h/(sum(h(:))+1e-10);
        if ~sum(ht(:))
            ht(1) = 1;
        end
        phi{m,n} = sqrt(ht(:));
        
    end
end

out = phi;