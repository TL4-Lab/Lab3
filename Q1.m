% Matteo Tullo + Isaiah Ngou
% 4TL4 Lab 1 Q1
clear();

X = imread("KillarneyPic.png");
Xdouble = im2double(X);
whos X
whos Xdouble

impulseSampled = Xdouble;

% imshow(Xdouble);
% colormap(1-gray);
colormap(gray);

iter = 1;
%impulse sample
for i = 1:776
    for j=1:1395
        if (mod(iter,5) ~= 0)
            impulseSampled(i,j) = 0;
        end
        iter = iter + 1;
    end
end

%imshow(impulseSampled);

%downsample by 5
downsampledX = downsample(Xdouble,5); %Xdouble(1:5:1082520);
downsampledX = downsample(downsampledX',5)';

%imshow(downsampledX);

% Zero-order hold reconstruction 
sz = size(Xdouble);
ZOHR = zeros(sz);
iter = 1;
iter2 = 1;
iterI = 1;
iterJ = 1;
for i = 1:776
    for j=1:1395
        ZOHR(i,j) = downsampledX(iterI,iterJ);
        disp(iterI)
        if (mod(iter,25) == 0)
            iterI = mod(iterI + 1, 156);
            iter2 = iter2 + 1;
        end
        if (mod(iter2, 25) == 0)
            iterJ = iterJ + 1;
        end
        iter = iter + 1;
    end
end
imshow(ZOHR);


