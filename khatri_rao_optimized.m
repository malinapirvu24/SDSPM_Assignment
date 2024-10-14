function C = khatri_rao_optimized(A, B)
    % Check if A and B have the same number of columns
    [m_A, n_A] = size(A);
    [m_B, n_B] = size(B);
    
    if n_A ~= n_B
        error('Matrices must have the same number of columns');
    end

    % Preallocate the result based on dimensions - reduce RAM
    C = sparse(m_A * m_B, n_A);
    
    % Calculate the Khatri-Rao product
    for i = 1:n_A
        C(:, i) = kron(A(:, i), B(:, i));
    end
end