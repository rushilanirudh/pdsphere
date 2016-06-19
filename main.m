clc
clear
addpath(genpath('libsvm-3.21'));
addpath(genpath('Sphere tools'));
load PD.mat
load Label_mocap.mat

%% The grid over which KDE is performed. Should be adjusted according to the data
x1 = 0:0.2:20; x2 = 0:.2:20;

%% Variance of Gaussian, in kernel density estimation
sigs = 0.2;
%sigs = [0.1:0.1:1 2 4 8 16]; %test for multiple sigmas

%% Dimensionality of PGA on Hypersphere
d = 50;
params.x1 = x2;
params.x2 = x2;
%%
for s = 1:length(sigs)
    params.sig = sigs(s);
    HT_map = HeatMapfromPD(PD,params);
    phi = hmap2sphere(HT_map);
    f = Sphere_PGA(phi,d);
    svmscore = PD_svmclassify(f,Label);
    perf(s) = mean(svmscore);
    
end