function features_pca = PCA(features,dim)

%%防止数据为Nan或Inf
 TF = isnan(features);
 features(TF) = 0;
%%

[coeff,score,latent] = pca(features);

features_pca = score(:,1:dim);

 features_pca = normalize(features_pca,2,'norm');
 
end