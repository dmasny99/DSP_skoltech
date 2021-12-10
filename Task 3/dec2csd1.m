% Y= dec2csd1(b_int,nbits)          10/25/16  Neil Robertson
%
% Convert signed decimal integers to binary CSD representation
% See Ruiz and Granda, "Efficient Canonic Signed DigitRecoding",
%      Microelectronics Journal 42, p 1090-1097, 2011
%
% b_int = vector of decimal integer coefficients
% nbits = number of bits in b_int coeffs
% Y = matrix of CSD coeffs
% A = matrix of binary coeffs
%
%                    -- j= 1:nbits --
%                   _                 _
%                  | ---- coeff 1 ---- |
%                  | ---- coeff 2 ---- |
%                  |  .      .      .  |
%       Y,A =      | ---- coeff i ---- |
%                  |  .      .      .  |
%                  | -- coeff ntaps -- |
%                   -                 -
% 1.  convert decimal integers to binary integers
function Y= dec2csd1(b_int,nbits)
ntaps= length(b_int);       % number of coeffs
for i= 1:ntaps              % coeff index (row index)
   u= abs(b_int(i));
   for j= 1:nbits           % binary digit index (column index)
   A(i,j)= mod(u,2);     % coeff magnitudes note:  MSB is on right.
   u= fix(u/2);
   end
end
% 2.  convert binary integers to CSD
s= sign(b_int);            % signs of coeffs
z= zeros(ntaps,1);
x= [A z];                  % MSB is on right. append 0 as MSB
for i= 1:ntaps                % coeff index (row index)
   c= 0;
   for j= 1:nbits         % binary digit index (column index)
   d= xor(x(i,j),c);
   ys= x(i,j+1)&d;               % sign bit    0 == pos, 1 == negative
   yd= ~x(i,j+1)&d;              % data bit
   Y(i,j)= yd - ys;              % signed digit
   c_next = (x(i,j)&x(i,j+1)) | ((x(i,j)|x(i,j+1))&c);      % carry
   c= c_next;
   end
Y(i,:) = Y(i,:)*s(i);            % multiply CSD coeff magnitude by coeff sign
end