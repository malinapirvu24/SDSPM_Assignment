clear all;
close all;
clc;
global c p lambda dist D Rh poslocal freq l m; 

%% Initialization - mandatory
initialization();

%% Dirty image and beam 
% [I_D, beam] = dirty_image(200); run if imsize changes, otherwise
% imsize = 200
load dirty_image.mat
display_image(I_D)
display_image(B)

%% MVDR algorithm
I_mvdr = MVDR(200); 

%display_image(I_mvdr);
