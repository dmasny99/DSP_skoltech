bz = [0 0 1 2];
az = [3 4 5 6];

figure(1);
hold on;
impz(bz, az);
grid on;
hold off;

figure(2);
[H, W] = freqz(bz, az);
H_dig_db = 20 * log10(abs(H)); % convert magnitude to dB
hold on;
plot(W / pi, H_dig_db);
title('Frequency response of the linear system')
ylabel('Madnitude (dB)')
xlabel('Normalized frequency (x \pi rad)')
grid on;
hold off;
