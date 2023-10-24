function  DCSHexmples



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
%% 无法缺少，否则将降低3%精确度
% 
 Fs = superpixels_show(imdata,12);

%%

Fs = imresize(im,[768 1024]); 

 imwrite(Fs,['D:/结果图像/方向/','dam','.jpg']);

imshow(Fs);

end