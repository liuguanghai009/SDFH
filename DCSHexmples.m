function  DCSHexmples
%
net = vgg16;

im = imread("D:/显著性示例图像/dam.jpeg");

if size(im,3)==1
    rgb = cat(3,im,im,im);
    im = mat2gray(rgb);
end

img = single(im);

[h, w, ~] = size(img);

if(h < w)
    img_resize = imresize(img, [768 1024]);
else
    img_resize = imresize(img, [1024 768]);
end

X = activations(net, img_resize,'pool5', 'OutputAs',  'channels');

[hei,wid,~] = size(X);

imdata = imresize(im,[hei wid]);
%
SN =12;

[L,~] = imsegkmeans(imdata,SN);

Fs = labeloverlay(imdata,L);

F = imresize(Fs,[768 1024]);
%
rawData = imresize(im,[768 1024]);
%
figure;

subplot(1, 2, 1);

imshow(rawData);
%
subplot(1, 2, 2);

imagesc(F);

axis off;

end
