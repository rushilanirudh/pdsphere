clc
%clear
% D2 = load('PD_pairwise_stroke20160323T082437.mat')
D2 = load('PD_pairwise_stroke20160323T115855.mat');
%load distmat_Wass.mat

%load PGA_distmat.mat
D = D2.D;

Label = scores';
Label(Label<5) = 0;
Label(Label==5) = 1;
%load Label_mocap.mat
%load All_stroke_movements_pairwise_distmat.mat;
%Label = [zeros(1,60) ones(1,28)];
%D = z;
[M,N] = size(D);

for m = 1:M
    disvec = D(m,:);
    disvec(m) = [];
    [val,loc] = min(disvec);
    mindis(m) = val;
    pred_label(m) = Label(loc);
end
disp(sum(pred_label==Label')/88)