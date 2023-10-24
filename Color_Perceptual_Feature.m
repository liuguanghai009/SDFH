function CPW = Color_Perceptual_Feature(data,LAB)

[hei,wid] = size(data);

map = imresize(data,[hei+2 wid+2]);

CPW = zeros(hei,wid);

%

for i=2:hei+1
    for j=2:wid+1
        %
        values = 0.0;
        summ= 0;
        %
        for u=-1:1
            for v=-1:1
                %
                if (map(i+u,j+v)>=0)%%不要改动

                    summ = summ + 1;

                    cL = power(LAB(i,j,1) - LAB(i+u,j+v,1),2);

                    cA = power(LAB(i,j,2) - LAB(i+u,j+v,2),2);

                    cB = power(LAB(i,j,3) - LAB(i+u,j+v,3),2);

                    values = values + sqrt(cL + cA + cB);

                end
                %
            end
        end
        %

        values = max(0.000005,values);

        A = 8.0*log(values + 1.0)/max(1.0,summ);

        CPW(i-1,j-1) = abs(sqrt(A)-1.0)/max(1.0,summ);

    end
end

end