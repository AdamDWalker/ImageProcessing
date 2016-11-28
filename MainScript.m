% MATLAB script for Assessment Item-1
close all;

% Step-1: Load input image
IM = imread('AssignmentInput.jpg');
figure;
imshow(IM);
title('Step-1: Load input image');

% Step-2: Conversion of input image to greyscale
figure;
subplot(1, 2, 1);
IM2 = rgb2gray(IM);
imshow(IM2);
title('Grayscale input');
subplot(1, 2, 2);
imhist(IM2);
title('Grayscale input hist');

% Step-3: Noise removal

IM3 = medfilt2(IM2);
figure;
subplot(1, 2, 1);
imshow(IM3);
title('Noiseless image');
subplot(1, 2, 2);
imhist(IM3);
title('Noiseless image hist');

% Step-4: Image Sharpening
sm1 = im2double(IM3);
sm2 = zeros(size(sm1));

sum = 0;
for loopcount = 0 : 1
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

IM4 = imsharpen(IM3);
figure;
subplot(1, 2, 1);
imshow(IM4);
title('Sharp matlab');
subplot(1, 2, 2);
imshow(sharp);
title('Sharp me');

% Step-5: Binary Image Segmentation 

level = graythresh(IM4);
%Level is approx 0.82, 0.9 gives more stuff scattered around, I like 0.89
%for now
BW = imbinarize(IM4, 0.89); 
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

se = strel('disk',2);
se2 = strel('disk',4);
IM5 = imerode(BW, se);
IM6 = imdilate(IM5, se2);
figure;
imshow(IM6);
title('Dilated');

% Step-whatever: Image smoothing
% smooth = zeros(size(grayImage));
% 
% sum = 0;
% 
% for loopcount = 0 : 1
%    for row = 2 : size(grayImage, 1) - 1
%       for col = 2 : size(grayImage, 2) - 1      
%           for a = row - 1 : row + 1
%               for b = col - 1 : col + 1
% 
%                   sum = sum + grayImage(a, b);
% 
%               end
%           end
%           sum = sum / 9;
%           smooth(row, col) = sum;
%           sum = 0;
%        end
%    end
% end
% 
% for r1 = 2:size(grayImage -1)
%     for c1 = 2:size(grayImage -1)
%         sharp(r1,c1) = grayImage(r1,c1) - smooth(r1,c1);
%     end
% end
% 
% subplot(1,2,1);
% imshow(sharp);
% title('sharp');
% subplot(1,2,2);
% imshow(smooth);
% title('smooth');

