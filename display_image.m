function display_image(image)

    figure()
    imshow(real(image) ./ real(max(max(image))))

end