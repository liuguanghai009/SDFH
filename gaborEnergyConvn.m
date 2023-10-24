function X = gaborEnergyConvn(X,ori, sigma)

gamma = 0.50;

lambda = 7.0;

phi00 = 0.0;

phi11 = - pi / 2.0;

gobor1 = simple_Gabor_function(sigma,ori,gamma,lambda,phi00); 

gobor2 = simple_Gabor_function(sigma,ori,gamma,lambda,phi11);

%%

[hei,wid,~]= size(X);

inputData = imresize(X,[hei+8 wid+8]);

result00 = convn(inputData,gobor1,'valid');
result11 = convn(inputData,gobor2,'valid');

X = sqrt(result00.*result00 + result11.*result11);

end