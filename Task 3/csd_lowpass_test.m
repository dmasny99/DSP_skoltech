%function [b_opt,B]= csd_lowpass(ntaps,nbits,fpass,fstop,fs) 
% 10/30/2016 Neil Robertson
%
% Synthesize FIR LPF with CSD coeffs
%
% ntaps     number of FIR coeffs
% nbits     number of bits per coeff
% fpass     passband edge freq, Hz, kHz, or MHz
% fstop     stopband edge freq, Hz, kHz, or MHz
% fs        sample freq, Hz, kHz, or MHz
%
% b_opt     decimal integer coefficients of LPF
% B         CSD coefficients of LPF (exactly equivalent to b_opt)
%
% Examples
% csd_lowpass(17,9,10,30,100);
% csd_lowpass(27,11,10,25,100);
%
function [b_opt,B]= csd_lowpass(ntaps,nbits,fpass,fstop,fs)
% 1.  Synthesize floating-point LPF using Parks-McClellan algorithm
N= ntaps-1;
f= [0 fpass fstop fs/2]/(fs/2);  % frequency vector
a= [1 1 0 0];                    % response goal vector
b= firpm(N,f,a);                 % Parks-McClellan filter synthesis
%b= remez(N,f,a);
% 2.  SEARCH for CSD coeffs with lowest number of signed digits (nsd)
b= b/max(b);                  % make maintap= 1
nsd_thresh= 2;                % threshold used to compute error
if nbits > 10
   nsd_thresh=3;
end
stop= fix(2/3*2^nbits);       % max allowed CSD value for coeff of length nbit
start= max(2^(nbits-1),stop-600); % starting maintap value. start > stop -600
emin= 999999;                 
for maintap= start:stop
   b_int=round(b*maintap);      % decimal integer coefficients
   Y= dec2csd1(b_int,nbits);     % compute CSD representation of b_int
   for i=1:ntaps
      nsd(i)= sum(abs(Y(i,:)));     % number of signed digits in coeff i
   end
   m= find(nsd> nsd_thresh);     %find indeces of coeffs that have nsd > nsd_thresh
   e= sum(nsd(m));               % sum of nsd's for those coeffs
   if e <=emin
      emin= e;
      Yopt= Y;                   % CSD coeffs with least nsd's.
      b_opt= b_int;              % integer version of above
   end
end
%
% 3.  Compute nsd of coeffs and external gain value
for i= 1:ntaps
   nsd(i)= sum(abs(Yopt(i,:)));        % number of signed digits in coeff i
end
gain_ext= 2^(nbits+1)/sum(b_opt);    % gain to make overall dc gain = 1
gain_approx= round(gain_ext*16)/16;    % approx gain
gain_rat= rats(gain_approx);
disp(' ')
disp(['coeff denominator = ',num2str(2^(nbits+1))])
disp(['external gain for unity overall gain: ',num2str(gain_ext)])
disp(['approximate external gain =',num2str(gain_rat)])
% 4.  List coeff values in decimal and CSD formats
disp(' ')
disp('fixed-point coeff values')
disp(b_opt')
B = [fliplr(Yopt)];
disp('CSD coeffs, MSB on left;    nsd')
disp(' ')
for i= 1:ntaps
    disp([num2str(B(i,:)),'     ',num2str(nsd(i))])
end