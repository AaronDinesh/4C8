function Y = calcInvHaar(H, n)
% inverse Haar transform
%    calcInvHaar(H, n) computes the inverse of the Haar transform
%    H is the input Haar image
%    n is the number of levels of the Haar transform

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
    lolo = calcInvHaar(lolo, n-1);
end

hilo = H(1:hy, hx + (1:hx));
lohi = H(hy + (1:hy), 1:hx);
hihi = H(hy + (1:hy), hx + (1:hx));

a = (lolo+hilo+lohi+hihi)/2;
b = (lolo-hilo+lohi-hihi)/2;
c = (lolo+hilo-lohi-hihi)/2;
d = (lolo-hilo-lohi+hihi)/2;

Y = zeros(size(H));

Y(1:2:end, 1:2:end) = a;
Y(1:2:end, 2:2:end) = b;
Y(2:2:end, 1:2:end) = c;
Y(2:2:end, 2:2:end) = d;


