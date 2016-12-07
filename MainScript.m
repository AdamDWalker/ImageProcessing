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
for loopcount = 0 : 5
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
%IM4 = imsharpen(IM3);
% figure;
% subplot(1, 2, 1);
% imshow(IM4);
% title('Sharp matlab');
% subplot(1, 2, 2);
% imshow(sharp);
% title('Sharp me');

% Step-5: Binary Image Segmentation 

%level = graythresh(IM4);

% This threshold lets more data through into the foreground, which makes
% allows the morphological processing step to produce better results. Any
% extra data that gets through is easy to clean up anyway.
threshold = 0.935;

BW = false(size(sharp));

for row = 1 : size(sharp, 1)
    for col = 1 : size(sharp, 2)
        if sharp(row, col) > threshold
            BW(row, col) = true;
        end
    end
end

% Invert the image such that black is the background
BW = ~BW ;

figure;
imshow(BW);
title('Binary Image');

%Step-6: Morphological Processing

se = strel('square',4);
se2 = strel('disk',2);
IM5 = imerode(BW, se);
IM6 = imdilate(IM5, se2);
IM7 = bwareaopen(IM6, 200);

figure;
imshow(IM7);
title('Dilated');

% Step-7: Remove non-starfish objects

[B,L] = bwboundaries(IM7, 'noholes');
hold on
for k = 1:length(B)
  boundary = B{k};
  plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end

stats = regionprops(L,'Area','Centroid', 'Perimeter');

threshold = 0.94;
minThresh = 0.18;
maxThresh = 0.24;

% loop over the boundaries
for k = 1:length(B)

  % obtain (X,Y) boundary coordinates corresponding to label 'k'
  boundary = B{k};

  % compute a simple estimate of the object's perimeter
  delta_sq = diff(boundary).^2;
  perimeter = stats(k).Perimeter;

  % obtain the area calculation corresponding to label 'k'
  area = stats(k).Area;

  % compute the roundness metric
  metric = 4*pi*area/perimeter^2;

  % display the results
  metric_string = sprintf('%2.2f',metric);

  % mark objects outside the threshold range with a black circle
  if metric < minThresh || metric > maxThresh
    centroid = stats(k).Centroid;
    plot(centroid(1),centroid(2),'ko');     
  end

  text(boundary(1,2)-35,boundary(1,1)+13,metric_string,'Color','y',...
       'FontSize',14,'FontWeight','bold');

end

title(['Metrics closer to 1 indicate that ',...
       'the object is approximately round']);

% label = bwlabel(IM7);
% props = regionprops(label, 'Area', 'Perimeter');
% 
% area = [props.Area];
% perimeter = [props.Perimeter];
% roundness = 4*pi*area/perimeter.^2;
% 
% display(area);
% display(perimeter);
% display(roundness);
% 
% target = find(((900 <= area) & (area <= 1200)) & ((0.05 <= metric) & (metric <= 0.15)));
%  
% IM8 = ismember(label, target);
figure;
imshow(IM8);
title('Step-7: Automatic Recognition');


