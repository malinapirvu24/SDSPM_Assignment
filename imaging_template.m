% Template script for radio astronomy image formation
% Millad Sardarabadi, Sept 2015
%
clear all
close all
clc
%% Loading Data
% The data from LOFAR core will be loaded in this cell.
%
% Rh: A p x p sample covariance matrix, where p = number of antennas
% poslocal: A p x 3 matrix containing the earth-bound coordinates of the
%           receiving elements.
% freq: Central frequency for the measured channel.
% t_obs_matlab: Observation time.
%               (datestr(t_obs_matlab): 11-Jul-2012 22:22:20) 
% lon: Longitude of the LOFAR core
% lat: Latitude of the LOFAR core

load lofar_DSP_data_1.mat

%% Initialization
c = 299792458; % speed of light
p = size(Rh,1);% number of receiving elements
lambda = c / freq; % wavelength at the observation frequency

% define a distance matrix of all baselines (=vectors between pairs of antennas)
dist = sqrt(  (meshgrid(poslocal(:,1)) - meshgrid(poslocal(:,1)).').^2 ...
            + (meshgrid(poslocal(:,2)) - meshgrid(poslocal(:,2)).').^2);
D = max(dist(:)); % Maximum Baseline


%% Coordinate system
% In astronomy it is common to use the (l,m,n) coordinates which 
% are the components of the more familiar direction vector in spherical 
% coordinates:
%    s = [cos(theta) * cos(phi)
%        cos(theta) * sin(phi)
%        sin(theta)]


% define a grid of image coordinates (l,m) at the right resolution
FracAngle = 0.25;% fraction of theoretical limit for angle resolution
                 % 0.25 means ~4x4 pixels in the main lobe
dl = FracAngle * lambda / D; % width/height of a pixel
l = 0:dl:1; % First image coordinate := cos(theta)cos(phi)
l = [-fliplr(l(2:end)),l]';
m = l;  % Second image coordinate := cos(theta)sin(phi)
        % m = l means an aspect ratio 1:1


%% Your Imaging Algorithm should come hereafter...

% Dirty image:

imsize = 30; 

x = linspace(-1,1,imsize);

[PX, PY] = meshgrid(x,x);   % all combinations of p-coords (l,m,n) vectors
PZ = sqrt(1 - PX.^2 - PY.^2);


p_vectors = zeros(3,imsize.^2);     % list the p-vectors
for counter = 1:imsize.^2
        p_vectors(:,counter) = [PX(counter) PY(counter) PZ(counter)];

end



I_D_hat = zeros(imsize .^ 2, 1);   % initialize variables
pixel_counter = 1;


for pixel = p_vectors           % scan over all pixels
    if (imag(pixel(3)) == 0)    % if within bounds, compute
        for ix = 1:p
            for iy = 1:p
           
                  I_D_hat(pixel_counter) =  I_D_hat(pixel_counter) + Rh(ix,iy) .* exp(1i .* ((poslocal(ix,:) - poslocal(iy,:))) * pixel);

            end
        end
    

    else
    I_D_hat(pixel_counter) = 0;      % if not in bounds, set to 0
    
    end
    pixel_counter = pixel_counter + 1;    % go to next pixel
end
disp('Done!')

I_D_hat = reshape(I_D_hat, imsize, imsize)
%%


imshow(real(I_D_hat) ./ max(max(I_D_hat)))   % normalize to properly look at output image


