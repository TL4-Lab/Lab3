% Matteo Tullo + Isaiah Ngou
% 4TL4 Lab 1 Q1
clear();

X = imread("KillarneyPic.png");
Xdouble = im2double(X);
whos X
whos Xdouble

impulseSampled = Xdouble;

imshow(Xdouble);
% colormap(1-gray);
colormap(gray);

iter = 1;
%impulse sample
for i = 1:776
    for j=1:1395
        if (mod(i,5) ~= 0 || mod(j,5) ~= 0)
            impulseSampled(i,j) = 0;
        end
        iter = iter + 1;
    end
end

%imshow(impulseSampled);
%title("Impulse Sampling at 1/5 of the Original Rate");

%downsample by 5
downsampledX = downsample(Xdouble,5); %Xdouble(1:5:1082520);
downsampledX = downsample(downsampledX',5)';

%imshow(downsampledX);
%title("Downsampling by a factor of 5");

% downsampledX(1:5, 1:5) = [1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;];

% Zero-order hold reconstruction 
sz = size(Xdouble);
ZOHR = zeros(sz);
for i = 1:156
    for j=1:279
        ZOHR((i-1)*5 + 1:((i-1)*5)+5,(j-1)*5 + 1:((j-1)*5)+5) = downsampledX(i,j)*ones(5);
    end
end
%imshow(ZOHR);
%title("Zero-order hold reconstruction");

% First-order hold reconstruction 
sz = size(downsampledX);
xVals = (1:1/5:sz(1));
yVals = (1:1/5:sz(2));

F = griddedInterpolant(downsampledX);
OOHR = F({xVals, yVals});

% for i = 1:size(downsampledX,1) - 2
%     for j=1:size(downsampledX,2) - 2
%         slope1 = (downsampleX(i+1,j) - downsampleX(i,j))/5;
%         for k  = 1:5
%             OOHR(i+k,j) = slope1*k;
%         end
%         slope2 = (downsampleX(i+1,j+1) - downsampleX(i,j+1))/5;
%         for k  = 1:5
%             OOHR(i+k,j) = slope1*k;
%         end
% 
% 
%         ZOHR((i-1)*5 + 1:((i-1)*5)+5,(j-1)*5 + 1:((j-1)*5)+5) = %submatrix;
%     end
% end
imshow(OOHR);
title("First-order hold reconstruction");
