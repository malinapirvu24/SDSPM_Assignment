%% Initialization - mandatory
clear all;
close all;
clc;
global c p lambda dist D Rh poslocal freq l m; 

imsize = 100;
initialization();

%% Dirty image and beam - basic algorithm
%[I_D, B] = dirty_image_basic(imsize); 
load dirty_image.mat
display_image(I_D)
title("Basic algorithm")
display_image(B)
title("Basic algorithm")

%% MVDR algorithm
%[I_mvdr, A_mvdr] = MVDR(imsize); 
load mvdr_image.mat
display_image(I_mvdr);
title("Dirty image - MVDR algorithm")

%% AAR algorithm
%[I_aar, A_aar] = AAR(imsize); 
load aar_image.mat
display_image(I_aar);
title("Dirty image - AAR algorithm")

%% LSI algorithm
I_lsi = LSI(imsize, I_mvdr, A_mvdr);
load lsi_image.mat  % mvdr
display_image(I_lsi);
title("Optimal image - LSI algorithm")


