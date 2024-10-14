function [I_aar, A_aar] = AAR(imsize)
    global c p lambda dist D Rh poslocal freq l m;

    I_aar = zeros(imsize .^ 2, 1); %initialize image

    x = linspace(-1,1,imsize);  %make pixel list
    
    [PX, PY] = meshgrid(x,x);   %all combinations of p-coords (l,m,n) vectors
    PZ = sqrt(1 - PX.^2 - PY.^2);
    
    p_vectors = zeros(3,imsize.^2); %list the p-vectors
    for counter = 1:imsize.^2
        p_vectors(:,counter) = [PX(counter) PY(counter) PZ(counter)];
    
    end

    pixel_counter = 1;
    A_aar = zeros(p, imsize.^2);
    Rh_inv = inv(Rh);   %compute Rh^-1
    Rh_minus_2 = Rh_inv^2;   %compute Rh^-2

    for pixel = p_vectors
        if (imag(pixel(3)) == 0)  %if within bounds, compute
            a_vector = exp(-1i * poslocal * pixel);
            num = (a_vector'  * Rh_inv * a_vector);  
            denom = ( a_vector'  * Rh_minus_2 * a_vector)^2;
            I_aar(pixel_counter) =  num ./ denom;
            A_aar( :, pixel_counter) = a_vector;
        else
            I_aar(pixel_counter) = 0;  %if not in bounds, set to 0
        end
        pixel_counter = pixel_counter + 1;
    end

    I_aar = reshape(I_aar, imsize, imsize);
    save('aar_image.mat', 'I_aar', 'A_aar');
    
end