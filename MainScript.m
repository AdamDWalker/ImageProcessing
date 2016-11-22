% MATLAB script for Assessment Item-1
close all;

% Step-1: Load input image
I = imread('AssignmentInput.jpg');
figure;
imshow(I);
title('Step-1: Load input image');

% Step-2: Conversion of input image to greyscale
figure;
grayImage = rgb2gray(I);
imshow(grayImage);
title('Step-2: Conversion of input image to greyscale');
figure;
imhist(grayImage);
% Step-3: Noise removal


% Step-4: Image Sharpening

highest = 0;
lowest = 0;
mean = 0;
threshold = 5;
for loopcount = 0 : 1
    for row = 2 : size(grayImage, 1) - 1
        for col = 2 : size(grayImage, 2) - 1      
            for a = row - 1 : row + 1
                for b = col - 1 : col + 1

                  if grayImage(a, b) > highest
                      highest = grayImage(a, b);
                  end
                  
                  if grayImage(a, b) < lowest
                      lowest = grayImage(a, b);
                  end
                end
            end
            mean = (highest + lowest) / 2;
            
            if (grayImage(row, col) >= threshold)
                grayImage(row, col) = grayImage(row, col) + mean;
            else
                grayImage(row, col) = grayImage(row, col) - mean;
            end      
            
            highest = 0;
            lowest = 0;
            mean = 0;
        end
    end
end

figure;
imshow(image);
title('Hopefully a sharpened image');
figure 
imhist(image);

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

