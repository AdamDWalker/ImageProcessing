% MATLAB script for Assessment Item-1
close all;

% Step-1: Load input image
IM = imread('AssignmentInput.jpg');
figure;
imshow(IM);
title('Step-1: Load input image');

% Step-2: Conversion of input image to greyscale
subplot(2, 4, 1);
IM2 = rgb2gray(IM);
imshow(IM2);
title('Grayscale input');
subplot(2, 4, 2);
imhist(IM2);
title('Grayscale input hist');

% Step-3: Noise removal

IM3 = medfilt2(IM2);
subplot(2, 4, 3);
imshow(IM3);
title('Noiseless image');
subplot(2, 4, 4);
imhist(IM3);
title('Noiseless image hist');

% Step-4: Image Sharpening
% for loopcount = 0 : 1
%     for row = 2 : size(grayImage, 1) - 1
%         for col = 2 : size(grayImage, 2) - 1      
%             for a = row - 1 : row + 1
%             end
%         end
%     end
% end

IM4 = imsharpen(IM3);
subplot(2, 4, 5);
imshow(IM4);
title('Sharpened image');
subplot(2, 4, 6);
imhist(IM4);
title('Sharpened image hist');

% Step-5: Binary Image Segmentation 

level = graythresh(IM4);
%Level is approx 0.82, 0.9 gives more stuff scattered around, I like 0.85
%for now
BW = imbinarize(IM4, 0.9); 
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

