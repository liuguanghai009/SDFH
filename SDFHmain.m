function SDFHmain

datasets = ["Oxford_5K库","Paris_6K库","Oxford_105K库","Paris_106K库","Holidays_upright库","UKB库","ROxford5k库","RParis6k库"];

net_name = ["vgg16","alexnet","resnet101","repvgg","sublimatedVGG"];

layerList = ["pool5","pool5","res5c_relu","mul4_24","pool5"];

numList = [512,256,2048,640,512];

%%

Index = 1;

dataname = datasets(Index);

number = 1;

layer = layerList(number);

num = numList(number);

switch net_name(number)
    case 'repvgg'
        net = importdata('G:/VGG16特征提取代码/repvgg/data/networks/imagenet_repvggplus_L2pse_deploy.mat');
    otherwise
        net = eval(net_name(number));
end


%%

filepatch="F:/标准图像库/" + dataname + "/图库/";

filename = dir(filepatch + "*.jpg");

[file_num, ~] = size(filename);

%

positiveCrow = zeros(file_num,num);

negativeCrow = zeros(file_num,num);

parfor i=1:file_num

    im = imread("F:/标准图像库/" + dataname + "/图库/" + filename(i).name);
    
    %%
    if size(im,3)==1
        rgb = cat(3,im,im,im);
        im = mat2gray(rgb);
    end
    %%
    img = single(im);

    [h, w, ~] = size(img);
    %%
    switch datasets
        case 'UKB库'
            img_resize = img;
        otherwise
            if(h < w)
                img_resize = imresize(img, [768 1024]); 
            else
                img_resize = imresize(img, [1024 768]);
            end
    end

    %%

    X = activations(net, img_resize,layer, 'OutputAs',  'channels');

    img_AAresize = imresize(img, [227 227]);%%望勿改动

    Y = activations(net, img_AAresize,layer, 'OutputAs',  'channels');

    [positiveCrow(i,:),negativeCrow(i,:)] = contrastive_representation(X,Y, im);

    if (mod(i,5)==0)
        fprintf('i=%d\n',i);
    end
end

positive_deepCrow = normalize(positiveCrow,2,'norm');
negative_deepCrow = normalize(negativeCrow,2,'norm');
%%
for i=1:file_num

    split = strsplit(filename(i).name, {'.'});
    name = split(1);

    %%
    positive_feature_save = positive_deepCrow(i,:)';
    save(['F:/VGG16特征/',dataname{1},'/SDFH/正例/',name{1},'.txt'],'positive_feature_save','-ASCII');
    %%
    negative_feature_save = negative_deepCrow(i,:)';
    save(['F:/VGG16特征/',dataname{1},'/SDFH/负例/',name{1},'.txt'],'negative_feature_save','-ASCII');

end

end