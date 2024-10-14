function display_image(image, algorithm)
    figure()
    imshow(real(image) ./ real(max(max(image))))  %normalize image
    %colormap(turbo);  
end