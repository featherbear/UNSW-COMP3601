% function [y1,...,yN] = myfun(x1,...,xM)
% -- function name: myfun
% -- function args: x1, ..., xM
% -- function retn: y1, ..., yN

function untitled()
    n_tests = 10000;
    count = 0;

    testVal = 1;
    for i = 1:n_tests
      count = count + (runTest(testVal) == testVal);
    end

    fprintf("Statistics: %u / %u (%u%%)", count, n_tests, count / n_tests * 100)
end

function m = runTest(M)

  global q;

  %%%%%%% SHARED
  q = 8191;
  %%%%%%% SHARED

  m = 4;
  n = 12;

  % bob generates a private key
  S = generatePrivateKey(m);
  % S = [4; 7; 5; 5];


  [A, B] = generatePublicKey(S, m, n);

  [u, v] = encryptBit(M, A, B);
  m = decryptBit(u, v, S);
end


function S = generatePrivateKey(m)
    global q;

    % Generate m random ints that are less than q
    S = randi(q, [m, 1]); % uniform distribution
end

function [A, B] = generatePublicKey(S, m, n)
  global q;

  A = randi(q, [n, m]); % uniform distribution

  % TODO: what standard deviation goes here?
  % sqrt(n) <= std_dev << q
  stdDev = sqrt(n) + randi(fix(0.1 * q));
  e = fix(normrnd(0, stdDev, [n, 1]));

  % B = mod(A*S, q); % no error
  B = mod(A*S + e, q);
end

function [u, v] = encryptBit(M, A, B)
  global q;

  % sampleSize = n / 4
  sampleSize = fix(numel(B) / 4);

  u = mod(sum(A(randsample(1:length(A), sampleSize),:)), q); %%%%%%%%%% Population must be a vector
  v = mod(sum(B(randsample(1:length(B), sampleSize),:)) - M * fix(q/2), q);
end

function M = decryptBit(u, v, S)
  global q;

  D = mod(v - dot(u, S), q);
  % M = -fix(q / 4) <= D | D <= fix(q / 4);
  
  
  % fprintf("Decoded D: %u\n", D);
  % fprintf("q/2 is %u\n", q/2);


  % M = abs(D) > fix(q / 4);
  
  % M = abs(D - q/2) <= q/4;

  if D > q/4 && D < 3*q/4
      M = 1;
  else
      M = 0;
  end
end
