function [arr1,arr2] = contrastive_representation(X,Y,im)

sigma = 2.3333; %%精确度和sigma有关，取较大值没有明显影响mAP,降低


orinum = 6;


[Gx,Cx] = sublimated_deep_Features(X,orinum,im,sigma);

[Gy,Cy] = sublimated_deep_Features(Y,orinum,im,sigma);

%==========================================

arr1 = sum(Gx,[1 2]).*sqrt(sum(Cx,[1 2]));

arr2 = sum(Gy,[1 2]).*sqrt(sum(Cy,[1 2]));

 
end