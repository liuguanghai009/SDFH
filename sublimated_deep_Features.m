function  [rotatedF,cpw] = sublimated_deep_Features(X,oNum,im,sigma)

[hei,wid,K] = size(X);

%% 无法缺少，否则将降低3%精确度

imdata = imresize(im,[hei wid]);

SN = 12;

Fs = superpixels_show(imdata,SN);

%
cm = imresize(im,[hei+2 wid+2]);

LAB = rgb2lab(cm);


%%

gabor_energy = zeros(hei,wid,K,oNum);

rotatedF = zeros(hei,wid,K);

cpw = zeros(hei,wid,K);

%%
for n=1:oNum

    ori = pi*(n-1)/oNum;

    gabor_energy(:,:,:,n) = gaborEnergyConvn(X,ori,sigma);

end

rankw = zeros([1,oNum]);

MaxOH = zeros(1,oNum);

MinOH = zeros(1,oNum);


for m=1:K

    rankw(:) = sum(gabor_energy(:,:,m,:),[1 2]);

    [~,index] = sort(rankw,'descend');

    MaxOH(index(1)) = MaxOH(index(1))+1;

    MinOH(index(oNum)) = MinOH(index(oNum))+1;

    %%
end

%%

[~,Lmax] = sort(MaxOH,'descend');

[~,Lmin] = sort(MinOH,'descend');

%%

for m=1:K

    OSE = sqrt((gabor_energy(:,:,m,Lmin(1))).^2);
    
   cpw(:,:,m) = Color_Perceptual_Feature(OSE,LAB);

    rotatedF(:,:,m) = OSE.*Fs;  %%不要改动

end

%%

end