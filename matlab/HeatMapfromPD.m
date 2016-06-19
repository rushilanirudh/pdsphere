function HT_map = HeatMapfromPD(PD,params)
%%Perform Kernel Density Estimation on a series of Persistence Diagram
%%To obtain the heat map from a single PD use 'HeatMapPD_func.m'
if(nargin<2)
    sig = 0.2;
    x1 = 0:0.03:6; x2 = 0:.03:6;
else
    sig = params.sig;
    x1 = params.x1;
    x2 = params.x2;
end

%% Symmetric variance in both dimensions
Sigma = [sig 0; 0 sig];
%%
numActions = size(PD,1);
numJoints = size(PD{1},1);

for action = 1:numActions
    for joint = 1:numJoints
        PersDiag = PD{action,2}{joint,1};
        if ~isempty(PersDiag)
            ind = PersDiag(:,2)>PersDiag(:,1);
            PersDiag = PersDiag(ind,:);
        end
        HeatMap = zeros(length(x1),length(x1));
        for i = 1:size(PersDiag,1)
            mu = [PersDiag(i,1) PersDiag(i,2)];
            
            [X1,X2] = meshgrid(x1,x2);
            F = mvnpdf([X1(:) X2(:)],mu,Sigma);
            F = reshape(F,length(x2),length(x1));
            
            HeatMap = HeatMap + F;
        end
        %         surf(x1,x2,HeatMap);
        HT_map{action,joint} = HeatMap;
    end
    str = sprintf('Computing heat map for action %d and joint# %d',action,joint);
    disp(str);
end
%%
savename = ['Heat_maps_dense_',num2str(Sigma(1,1)*10),'.mat'];
save(savename,'HT_map');
