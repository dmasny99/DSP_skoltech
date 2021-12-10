n = linspace(-47, 47, 94);
h_id  = (1-exp(-0.5-0.4.*pi.*n.*j))./(2.5+2.*j.*pi.*n) + (exp(-0.5+0.4.*pi.*n.*j)-1)./(-2.5+2.*j.*pi.*n);
win = blackman(length(n));
h = real(h_id) .* transpose(win);
fvtool(h)