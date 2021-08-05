function [P,offset] = graycode(width,height)
%this code generates 2 gray codes for each pixel one for row location and other for column location.Each bit belongs to one pattern
%this code is same as bincode only offset is used for generating gray instead of binary
% % Define height and width of screen.
% width  = 1024;
% height = 768;

% Generate Gray codes for vertical and horizontal stripe patterns.
% See: http://en.wikipedia.org/wiki/Gray_code
P = cell(2,1);
offset = zeros(2,1);
for j = 1:2
   
   % Allocate storage for Gray code stripe pattern.
   if j == 1
      N = ceil(log2(width));
      offset(j) = floor((2^N-width)/2);  %offset is for gray code
   else
      N = ceil(log2(height));
      offset(j) = floor((2^N-height)/2);
   end
   P{j} = zeros(height,width,N,'uint8');
   
   % Generate N-bit Gray code sequence.
   B = zeros(2^N,N,'uint8');
   B_char = dec2bin(0:2^N-1);
   for i = 1:N
      B(:,i) = str2num(B_char(:,i));
   end
   G = zeros(2^N,N,'uint8');
   G(:,1) = B(:,1);
   for i = 2:N
      G(:,i) = xor(B(:,i-1),B(:,i));      %Binary to gray conversion
   end
   
   % Store Gray code stripe pattern.
   if j ==1 
      for i = 1:N
         P{j}(:,:,i) = repmat(G((1:width)+offset(j),i)',height,1);
      end
   else
      for i = 1:N
         P{j}(:,:,i) = repmat(G((1:height)+offset(j),i),1,width);
      end
   end
   
end

% % Decode Gray code stripe patterns.
% C = gray2dec(P{1})-offset(1);
% R = gray2dec(P{2})-offset(2);