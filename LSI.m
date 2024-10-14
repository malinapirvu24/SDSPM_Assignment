function [I_lsi] = LSI(imsize, image , A)

    global c p lambda dist D Rh poslocal freq l m;

    I_lsi = zeros(size(reshape(image, [], 1 )));
    r_vec = reshape(Rh,  [], 1);

    I_lsi = (1/ p^2) * (khatri_rao_optimized(conj(A), A))' * r_vec;

    I_lsi = reshape(I_lsi, imsize, imsize);
    save('lsi_image.mat', 'I_lsi');

end