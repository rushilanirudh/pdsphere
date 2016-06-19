function svmscore = PD_svmclassify(f,Label)

nClass = length(unique(Label));

teN = 5;
for k = 1:100
    rng(k);
    trids = [];
    teids = [];
    for n = 1:nClass
        id = find(Label==n);
        teidx = randperm(length(id),teN);
        tridx = id;
        tridx(teidx) = [];
        trids = [trids tridx'];
        teids = [teids id(teidx)'];
    end

g = 1/size(f,1);
C = 1e1;
model = svmtrain(Label(trids), f(:,trids)', ['-s 0 -c ',num2str(C),' -t 0 -g ',num2str(g)]);
[predict_label, accuracy, prob_values] = svmpredict(Label(teids), f(:,teids)', model);
svmscore(k) = accuracy(1);
end