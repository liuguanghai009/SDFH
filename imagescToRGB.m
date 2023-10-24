function rgb = imagescToRGB(im)
 
h = imagesc(im); % imagesc handle
 
cm = colormap(h.Parent); % get axes colormap

n = size(cm,1); % number of colors in colormap

c = linspace(h.Parent.CLim(1),h.Parent.CLim(2),n); % intensity range

ind = reshape(interp1(c,1:n,im(:),'nearest'),size(im)); % indexed image

rgb = ind2rgb(ind,cm); % rgb image
 
end