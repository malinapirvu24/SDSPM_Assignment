function[I_D, beam] = dirty_image(imsize)

global c p lambda dist D Rh poslocal freq l m;

normalized_poslocal = zeros(p,3);

for index = 1:p
    normalized_poslocal(index, :) = poslocal(index, :) / norm(poslocal(index, :));
end

x = linspace(-1,1,imsize);

[PX, PY] = meshgrid(x,x);   % all combinations of p-coords (l,m,n) vectors
PZ = sqrt(1 - PX.^2 - PY.^2);

p_vectors = zeros(3,imsize.^2);     %list the p-vectors
for counter = 1:imsize.^2
    p_vectors(:,counter) = [PX(counter) PY(counter) PZ(counter)];

end

I_D = zeros(imsize .^ 2, 1);   %initialize image
B = zeros(imsize .^ 2, 1);     %initialize beam
pixel_counter = 1;

for pixel = p_vectors           %scan over all pixels
    if (imag(pixel(3)) == 0)    %if within bounds, compute
        for ix = 1:p
            exp_term = exp(1i .* (poslocal(ix,:) - poslocal(:,:)) * pixel) ;
            I_D(pixel_counter) =  I_D(pixel_counter) + Rh(ix,:) * exp_term ;
            B(pixel_counter) = B(pixel_counter) + sum(exp_term);
        end
    else
        I_D(pixel_counter) = 0;      %if not in bounds, set to 0
    end
    pixel_counter = pixel_counter + 1;    %go to next pixel
end

I_D = reshape(I_D, imsize, imsize);
B = reshape(B, imsize, imsize);

save('dirty_image.mat', 'I_D', 'B');
display_image(I_D)
display_image(B)

end