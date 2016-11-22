% MATLAB script for Assessment Item-1
close all;

% Step-1: Load input image
image = imread('AssignmentInput.jpg');
figure;
imshow(image);
title('Step-1: Load input image');

% Step-2: Conversion of input image to greyscale
subplot(2, 2, 1);
grayImage = rgb2gray(image);
imshow(grayImage);
title('Grayscale input');
subplot(2, 2, 2);
imhist(grayImage);
title('Grayscale input hist');
% Step-3: Noise removal


% Step-4: Image Sharpening
for loopcount = 0 : 1
    for row = 2 : size(grayImage, 1) - 1
        for col = 2 : size(grayImage, 2) - 1      
            for a = row - 1 : row + 1
            end
        end
    end
end

subplot(2, 2, 3);
imshow(grayImage);
title('Sharpened image');
subplot(2, 2, 4);
imhist(grayImage);
title('Sharpened image hist');

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

