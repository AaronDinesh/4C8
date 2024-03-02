function H = calcHaarLevel1(Y)
    if (mod(size(Y,1),2) ~= 0)
        error('height must be multiple of 2');
    end
    if (mod(size(Y,2),2) ~= 0)
        error('width must be multiple of 2');
    end

    % Calculate the 4 parts the intermidate matrix
    a = Y(1:2:end, 1:2:end);
    b = Y(1:2:end, 2:2:end);
    c = Y(2:2:end, 1:2:end);
    d = Y(2:2:end, 2:2:end);
    
    % Mix them to create the 4 'entries'
    lolo = a + b + c + d;
    hilo = a - b + c - d;
    lohi = a - c + b - d;
    hihi = a - b - c + d;

    % Concat them togetht to form the transformed image
    H = (1/2)*vertcat(horzcat(lolo, hilo), horzcat(lohi, hihi));
end