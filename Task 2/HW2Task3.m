Fs = 20;
b = [0 1 2.5];
a = [1 2.5 4];
[bz, az] = bilinear(b,a,Fs);
[r, p] = residue(b, a); % find direct term of a Partial Fraction Expansion of the ratio of two polynomials
t = linspace(0, 100 / Fs, 1000);
h = real(r.'*exp(p.*t) / Fs); % analog filter impulse response
figure(1);
plot(t, h);
hold on;
impz(bz, az, [], Fs);
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