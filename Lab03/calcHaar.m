function H = calcHaar(I, n)
    if (mod(size(I,1),2) ~= 0)
        error('height must be multiple of 2');
    end
    if (mod(size(I,2),2) ~= 0)
        error('width must be multiple of 2');
    end
    
    % Calculate the level 1 Haar transform
    Itemp = calcHaarLevel1(I);
    xSize = size(Itemp, 2);
    ySize = size(Itemp, 1);

    % Apply the Haar Transform to the LoLo section of the resulting matrix.
    % This corresponds to applying the Haar transform to the upper left
    % quarant of the matrix.
    for i = 1:n-1
        Itemp(1:ySize/(2^i), 1:xSize/(2^i)) = calcHaarLevel1(Itemp(1:ySize/(2^i), 1:xSize/(2^i)));
    end

    H = Itemp;
end