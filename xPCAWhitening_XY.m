function X = xPCAWhitening_XY(XTrain,XTest)
%%

TF = isnan(XTrain);

XTrain(TF) = 0;

%%

TF = isnan(XTest);

XTest(TF) = 0;

%% ======================***==============================

[coeff,scoreTrain,~,~,~,mu] = pca(XTrain,"Centered",false);

%%  用训练集来训练白化参数 

scoreTrain95 = scoreTrain(:,:);

x = scoreTrain95';

sigma = (x*x')/size(x,2); %% ===》计算零均值化后的数据计算协方差矩阵

[s,v,~] = svd(sigma);  %% ===》对协方差矩阵进行特征值分解

%%=============================***====================================

scoreTest95 = (XTest - mu) * coeff(:,:);

X = scoreTest95(:,:)';

%% 对数据进行旋转（投影到主成分轴上，实现了去相关性）

xRot = s'* X;   

%% 让每一维特征上的数据都除以该维特征的标准差（对每一个主成分轴上的数据进行缩放，使其方差为 1）

epsilon = 1e-5;

xPCAWhite = diag(1./(sqrt(diag(v)+epsilon)))*xRot; %%不可缺少，否则大幅度降低

features_pca = xPCAWhite';

X = normalize(features_pca,2,"norm");

end