function d = hilbert_sphere_pd_metric(pd1,pd2,params)

%%computes the proposed metric between two persistence diagrams specified
%%by pd1, pd2.
if(nargin<3)
    sig = 0.2;
    x1 = 0:0.2:20; x2 = 0:.2:20;
else
    sig = params.sig;
    x1 = params.x1;
    x2 = params.x2;
end

ht1 = HeatMapPD_func(pd1,params);
ht2 = HeatMapPD_func(pd2,params);
phi = hmap2sphere({ht1,ht2});
d = rdist(phi{1},phi{2});

