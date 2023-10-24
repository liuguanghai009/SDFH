function X = xPCAWhitening_dim(XTrain,dim)

TF = isnan(XTrain);

XTrain(TF) = 0;

[coeff,scoreTrain,~,~,~,mu] = pca(XTrain,"Centered",false);

scoreTrain95 = scoreTrain(:,1:dim);

X = scoreTrain95';

sigma =(X * X')/size(X,2);  %% ==>计算零均值化后的数据计算协方差矩阵；

[s,v,~] = svd(sigma);     %% ==>对协方差矩阵进行特征值分解；

scoreTest95 = (XTrain - mu) * coeff(:,1:dim);

X =  scoreTest95(:,:)';

xRot = s'* X;     %% ==>对数据进行旋转,即：投影到主成分轴上，实现了去相关性；

epsilon = 1e-5;

%% ==>让每一维特征上的数据都除以该维特征的标准差，即：对每一个主成分轴上的数据进行缩放，使其方差为 1；

xPCAWhite = diag(1./(sqrt(diag(v)+epsilon)))*xRot;

features_pca = xPCAWhite';

X = normalize(features_pca,2,"norm");

end