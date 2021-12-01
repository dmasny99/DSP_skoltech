%попробовать fir1 fir2 firls с разными параметрами и выбрать с наименьшими коэф
% задача на проведение "исследований"
Fpass = 5e6;
Fstop = 6e6;
Fs = 50e6;
%fir1
n = 300;
delta = 0.007; % because default attenuation in wpass = -6dB, so I need to shift magn. resp.
f1 = fir1(n, 2 * Fpass / Fs + delta, blackman(n + 1));
%fvtool(f1);
%fir2
delta = 0.01;
freq = [0 2*Fpass/Fs (2*Fstop/Fs - delta) 1]; % substruction delta is necessary for the proper filter design
mag = [1 1 0 0];
n = 210;
f2 = fir2(n, freq, mag);
%fvtool(f2);
%fir ls
freq = [0 2*Fpass/Fs 2*Fstop/Fs  1]; 
mag = [1 1 0 0];
n = 185;
f3 = firls(n, freq, mag);
fvtool(f3);

