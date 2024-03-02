function entropy = calcEntropy(Y)
    entropy_temp = 0;
    [hist, ~] = histcounts(Y, 2048, 'Normalization','probability');
    for i = 1:1:length(hist)
        if hist(i) == 0
            continue
        end
        entropy_temp = entropy_temp - hist(i)*log2(hist(i));
    end
    entropy = entropy_temp;
end