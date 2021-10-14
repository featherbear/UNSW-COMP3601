classdef lwe; methods(Static)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function S = generatePrivateKey(m)
    global q;

    % Generate m random ints that are less than q
    S = randi(q, [m, 1]); % uniform distribution
end

function [A, B] = generatePublicKey(S, m, n)
  global q;

  A = randi(q, [n, m]); % uniform distribution

  %%%% sqrt(n) <= std_dev << q
  %stdDev = sqrt(m) + randi(fix(0.1 * q));
  %e = fix(normrnd(0, stdDev, [n, 1]));
  
  e = round(randn(n, 1));
  
  % B = mod(A*S, q); % no error 
  B = mod(A*S, q) + e;
end

function [u, v] = encryptBit(M, A, B)
  global q;

  % sampleSize ~= n / 4
  sampleSize = fix(numel(B) / 4);
  samplesChoices = randsample(1:length(B), sampleSize);
  u = mod(sum(A(samplesChoices,:)), q);
  v = mod(sum(B(samplesChoices,:)) - M * fix(q/2), q);
end

function M = decryptBit(u, v, S)
  global q;

  
  D = mod(v - dot(S, u), q);   % D is always positive
 
  % M = 0 when -q/4 <= D <= q/4
  %        aka. D < q/4 or D > 3q/4
  
  M = D > q/4 & D < 3*q/4; 

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end end
