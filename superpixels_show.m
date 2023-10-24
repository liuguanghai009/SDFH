function  outputImage = superpixels_show(I,SN)

%%

[L,~] = imsegkmeans(I,SN);

B = labeloverlay(I,L); 

outputImage = mat2gray(im2gray(B));

end