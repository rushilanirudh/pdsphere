function HT_map = HeatMapPD_func(PD,params)

if(nargin<2)
    sig = 0.2;
    x1 = 0:0.03:6; x2 = 0:.03:6;
else
    sig = params.sig;
    x1 = params.x1;
    x2 = params.x2;
end


Sigma = [sig 0; 0 sig];

PersDiag = PD;
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
HT_map = HeatMap;


