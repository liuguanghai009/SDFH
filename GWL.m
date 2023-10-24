function X = GWL(XTrain,XTest,dim)

Xout = xPCAWhitening_XY(XTrain,XTest);

Yout = xPCAWhitening_XY(Xout,XTrain);

gain = [Xout Yout];


%%

X = PCA(gain,dim); %%不要改动，再次提升

%%务必进行归一化,否则精确度低2个点

X = normalize(X,2,"norm");

%%
end