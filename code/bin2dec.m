function D = gray2dec(B)

% Extract height, width, and length of Gray code.
height = size(B,1);     %number of bits
width  = size(B,2);     %number of pixels   
N      = size(B,3);		%number of patterns

% Convert per-pixel binary code to decimal.
D = zeros(height,width);
for i = N:-1:1
   D = D + 2^(N-i)*double(B(:,:,i));  % Its just binary to decimal conversion D = D + (2^(n-1))* binary bit
end
D = D + 1;