% MATLAB script for Assessment Item-1
close all;

% Step-1: Load input image
IM = imread('AssignmentInput.jpg');
figure;
imshow(IM);
title('Step-1: Load input image');

% Step-2: Conversion of input image to greyscale
IM = im2double(IM);
IM2 = zeros(size(IM,1), size(IM,2));

for row = 1 : size(IM,1)
    for col = 1 : size(IM,2)        
        IM2(row, col) = 0.2989 * IM(row, col, 1) + 0.5870 * IM(row, col, 2) + 0.1140 * IM(row, col, 3);
    end
end

figure;
subplot(1,2,1);
%IM2 = rgb2gray(IM);
imshow(IM);
title('Coloured input');
subplot(1,2,2);
imshow(IM2);
title('Grayscale output');

% ------ Step-3: Noise removal ~ Median Filter ------ % 
% Converting both the input, and output images to double for consistency

noNoise = zeros(size(IM2));
IMD = im2double(IM2); 
count = 1;
array = zeros(1,9);
% Run over the entire image with a 3x3 kernel.
% Sort these 9 pixel values and use the median value for the center pixel
for row = 2 : size(IMD, 1) - 1
    for col = 2 : size(IMD, 2) - 1      
        for a = row - 1 : row + 1
            for b = col - 1 : col + 1
                array(count) = IMD(a,b);
                count = count + 1;
            end
        end
        count = 1;
        sortedArray = sort(array);
        noNoise(row, col) = sortedArray(5);
    end
end
figure;
subplot(1,3,1);
imshow(IM2);
title('Noisy input');
subplot(1,3,2);
imshow(noNoise);
title('Median filter - My Code');

% ------ Step-3: Noise Removal Matlab Code ------ %
IM3 = medfilt2(IM2);
subplot(1,3,3);
imshow(IM3);
title('Matlab Medfilt2');
% subplot(1, 2, 2);
% imhist(IM3);
% title('Noiseless image hist');

% Step-4: Image Sharpening
sm1 = noNoise;
sm2 = zeros(size(sm1));

sum = 0;
for loopcount = 0 : 3
    for row = 2 : size(sm1, 1) - 1
        for col = 2 : size(sm1, 2) - 1      
            for a = row - 1 : row + 1
                for b = col - 1 : col + 1
                    sum = sum + sm1(a,b);
                end
            end
            
            sum = sum / 9;
            sm2(row, col) = sum;
            sum = 0;
        end
    end
end

edge = sm1 - sm2;

sharp = sm1 + edge;

figure;
subplot(1, 3, 1);
imshow(IM3);
title('IM2');
subplot(1, 3, 2);
imshow(edge);
title('Edge');
subplot(1, 3, 3);
imshow(sharp);
title('Sharp');

%----- This is the matlab code for image sharpening -----%
% IM4 = imsharpen(IM3);
% figure;
% subplot(1, 2, 1);
% imshow(IM4);
% title('Sharp matlab');
% subplot(1, 2, 2);
% imshow(sharp);
% title('Sharp me');

% Step-5: Binary Image Segmentation 

level = graythresh(sharp);

%Level is approx 0.82, 0.9 gives more stuff scattered around, I like 0.89
%for now
%BW = imbinarize(sharp, 0.89); 

BW = false(size(sharp));

for row = 1 : size(sharp, 1)
    for col = 1 : size(sharp, 2)
        if sharp(row, col) > 0.92 % This should be a threshold level calculated elsewhere but it works for now
            BW(row, col) = true;
        end
    end
end

%BW = bwareaopen(BW, 10);
figure;
BW = ~BW;
imshow(BW);
title('Binary Image');

% bin3 = imbinarize(bin1);
% bin3 = bwareaopen(bin3, 50);
% figure;
% imshow(bin3);
% title('Binary Image');

%Step-6: Morphological Processing

se = strel('square',3);
se2 = strel('disk',1);
IM5 = imerode(BW, se);
IM6 = bwmorph(IM5, 'majority');
IM7 = imdilate(IM6, se2);

figure;
imshow(IM7);
title('Dilated');
