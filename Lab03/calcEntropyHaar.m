function entropy = calcEntropyHaar(H, n)

if (mod(size(H,1),2) ~= 0)
    error('height must be multiple of 2');
end
if (mod(size(H,2),2) ~= 0)
    error('width must be multiple of 2');
end

hx = size(H,2)/2;
hy = size(H,1)/2;

lolo = H(1:hy, 1:hx);

if n>1
    entropy_lolo = calcEntropyHaar(lolo, n-1);
else 
    entropy_lolo = calcEntropy(lolo);
end

entropy_hilo = calcEntropy(H(1:hy, hx + (1:hx)));
entropy_lohi = calcEntropy(H(hy + (1:hy), 1:hx));
entropy_hihi = calcEntropy(H(hy + (1:hy), hx + (1:hx)));

entropy = (entropy_lolo + entropy_hilo + entropy_lohi + entropy_hihi)/4;

