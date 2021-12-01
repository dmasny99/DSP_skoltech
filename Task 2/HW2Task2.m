Fpass = 20e6;
Fstop = 25e6;
Fs = 100e6;
Ripple = 0.2;
Attenuation = 60;
Ws = 2 * Fstop / Fs; % normilize the frequency
Wp = 2 * Fpass / Fs; % normilize the frequency
[n, Wp] = cheb1ord(Wp, Ws, Ripple, Attenuation); % compute the order of designing filter
[b,a] = cheby1(n, Ripple, 2 * pi * Fpass, 's'); % analog filter design B(s)/A(s)
figure(1);
[bz, az] = impinvar(b,a,Fs); % design a digital prototype of the analog filter B(z)/A(z)
% the following steps are similar to the seminar
[r, p] = residue(b, a); % find direct term of a Partial Fraction Expansion of the ratio of two polynomials
t = linspace(0, 100 / Fs, 1000);
h = real(r.'*exp(p.*t) / Fs); % analog filter impulse response
plot(t, h)
hold on;
impz(bz, az, [], Fs); % digital filter impulse invariance
legend('Analog filter', 'Digital filter')
grid on;
hold off;

figure(2);
[H, W] = freqz(bz, az);
[H_an] = freqs(b, a, W * Fs);
H_dig_db = 20 * log10(abs(H)); % convert magnitude to dB
H_an_db = 20 * log10(abs(H_an));
plot(W / pi, H_an_db);
hold on;
plot(W / pi, H_dig_db);
legend('Analog filter', 'Digital filter')
title('Frequency responses of analog and digital filters')
ylabel('Madnitude (dB)')
xlabel('Normalized frequency (x \pi rad)')
grid on;
hold off;
