function times = PDSpeed()
load PD
load Label_mocap.mat
id = [];

for i = 1:5
    idx = find(Label == i);
    id = [id idx(1:3)];
end
id = id(:);
    sig = 0.1;
    Sigma = [sig 0; 0 sig];
    
    for action = 1:length(id(:));
        action
        for joint = 1:57
        tic
        PersDiag1 = PD{id(action),2}{joint,1};
        PersDiag2 = PD{id(action),2}{joint,1};
        
        ht1 = HeatMapPD_func(PersDiag1);
        ht2 = HeatMapPD_func(PersDiag2);
        phi1 = sqrt(ht1/(sum(ht1(:))+1e-10));
        phi2 = sqrt(ht2/(sum(ht2(:))+1e-10));
        d = rdist(phi1,phi2);
        
        t(action,joint) = toc;
        end
    end
    times = t;
