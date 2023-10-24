function PCA_cw_norm

%%

datasets =  ["Oxford_5K库","Paris_6K库","Oxford_105K库","Paris_106K库","Holidays_upright库","UKB库","ROxford5k库","RParis6k库"];

% net_name = ["vgg16","alexnet","resnet101","repvgg","sublimatedVGG"];
% 
% layerList = ["pool5","pool5","res5c_relu","mul4_24","pool5"];

numList = [512,256,2048,640,512];

Index = 1 ;

dataname = datasets(Index);

%%

filename = dir("F:/VGG16特征/" + dataname + "/SDFH/正例/" + "*.txt");
filesXTrain = dir("F:/VGG16特征/" + dataname + "/SDFH/负例/" + "*.txt");

[file_count, ~] = size(filesXTrain);
[file_num, ~] = size(filename);

number = 1;

num = numList(number);

XTest = zeros(file_num,num);
XTrain = zeros(file_count,num);

parfor i=1:file_num
    %%
    i
    %%
    XTest(i,:) = importdata("F:/VGG16特征/" + dataname{1} + "/SDFH/正例/" + filename(i).name);

    %%

    XTrain(i,:) = importdata("F:/VGG16特征/" + dataname{1} + "/SDFH/负例/" + filesXTrain(i).name);

    %%

    if (mod(i,5)==0)
        fprintf('i=%d\n',i);
    end

end

dim = 256;

X = GWL(XTrain,XTest,dim);

for i=1:file_num
    % 获取图片序号d
    split = strsplit(filename(i).name, {'.'});
    name = split(1);
    %%
    feature_save = X(i,:)';
    save(['F:/VGG16特征/',dataname{1},'/SDFH/白化特征/',name{1},'.txt'],'feature_save','-ASCII');
    %%
end

end