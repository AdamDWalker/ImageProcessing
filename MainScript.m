% MATLAB script for Assessment Item-1
close all;

% Step-1: Load input image
% I = imread('AssignmentInput.jpg');
% figure;
% imshow(I);
% title('Step-1: Load input image');

% Step-2: Conversion of input image to greyscale
subplot(2, 2, 1);
grayImage = rgb2gray(I);
imshow(grayImage);
title('Grayscale Input');
subplot(2, 2, 2);
imhist(grayImage);
title('Grayscale hist');
% Step-3: Noise removal


% Step-4: Image Sharpening
for loopcount = 0 : 1
    for row = 2 : size(grayImage, 1) - 1
        for col = 2 : size(grayImage, 2) - 1      
            for a = row - 1 : row + 1
                for b = col - 1 : col + 1
                end
            end
        end
    end
end

subplot(2, 2, 3);
imshow(grayImage);
title('Sharpened image');
subplot(2, 2, 4);
imhist(grayImage);
title('Sharpened hist');

% Step-whatever: Image smoothing
% image = im2double(grayImage);
% outputImage = zeros(size(image));
% 
% sum = 0;
% 
% for loopcount = 0 : 1
%    for row = 2 : size(image, 1) - 1
%       for col = 2 : size(image, 2) - 1      
%           for a = row - 1 : row + 1
%               for b = col - 1 : col + 1
% 
%                   sum = sum + image(a, b);
% 
%               end
%           end
%           sum = sum / 9;
%           image(row, col) = sum;
%           sum = 0;
%        end
%    end
% end
% 
% figure;
% imshow(image);
% title('Hopefully a smoothed image');

