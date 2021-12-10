Fpass = 4e6;
Fstop = 6e6;
Fs = 20e6;
Attenuation = 40;
%filter 1
nbits = 11;% defines the quality of approximation
n = 21;
f1 = fir1(n,2*Fpass/Fs, 'low');
%fvtool(f1)
approx_coeff1 = csd_lowpass(f1, n, nbits);
f1 = f1/max(f1); % normalization
approx_coeff1 = approx_coeff1/max(approx_coeff1); % normalization
%fvtool(f1, 1, approx_coeff1, 1); %orange one is approximated
%legend('Original filter', 'Multiplierless filter')
%filter 2
nbits = 20;% defines the quality of approximation
n = 23;
f2 = fir1(n,2*Fpass/Fs, 'low', chebwin(n+1));
%fvtool(f2)
approx_coeff2 = csd_lowpass(f2, n, nbits);
f2 = f2/max(f2); % normalization
approx_coeff2 = approx_coeff2/max(approx_coeff2); % normalization
%fvtool(f2, 1, approx_coeff2, 1); %orange one is approximated
%legend('Original filter', 'Multiplierless filter')
% filter 3
nbits = 20;% defines the quality of approximation
n = 25;
f3 = fir1(n,2*Fpass/Fs, 'low', blackmanharris(n+1));
%fvtool(f3)
approx_coeff3 = csd_lowpass(f3, n, nbits);
f3 = f3/max(f3); % normalization
approx_coeff3 = approx_coeff3/max(approx_coeff3); % normalization
fvtool(f3, 1, approx_coeff3, 1); %orange one is approximated
legend('Original filter', 'Multiplierless filter')