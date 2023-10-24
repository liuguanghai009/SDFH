function X = transfer_learning_whitening(XTrain,XTest,dim)
%%
TF = isnan(XTrain);
 
 XTrain(TF) = 0;
 
 TF = isnan(XTest);
 
XTest(TF) = 0;
%%
[coeff,scoreTrain,~,~,explained,mu] = pca(XTrain,"Centered",false);

scoreTrain95 = scoreTrain(:,1:dim);

x = scoreTrain95';

sigma =(x*x')/size(x,2);

[s,v,~] = svd(sigma);

scoreTest95 = (XTest-mu)*coeff(:,1:dim);

x1 = scoreTest95(:,1:dim)';%取前dim维

xRot = zeros(size(x1));

xRot = s'*x1;

epsilon = 1e-5;

xPCAWhite = size(x1);

xPCAWhite = diag(1./(sqrt(diag(v)+epsilon)))*xRot;

features_pca = xPCAWhite';

X = normalize(features_pca,2,"norm");

end
