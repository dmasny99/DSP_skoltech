N = 10e5;
x = randn(1, N); % input - white noise
n = 100;
Fpass = 4e6;
Fs = 4*Fpass;
filter = fir1(n,2*Fpass/Fs,'low'); 
x_filtered = conv(x, filter); %filtering white noise
tr = triang(100);
y = conv(x_filtered, tr);
%fvtool(y); % task b - plotting freq resp of filtered white noise
fvtool(tr, 1, rectwin(100), 1) % plotting imp resp and freq resp of FOH and S&H
legend('FOH','S&H')

