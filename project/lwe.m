% function [y1,...,yN] = myfun(x1,...,xM)
% -- function name: myfun
% -- function args: x1, ..., xM
% -- function retn: y1, ..., yN

n = 12;
m = 4;

% prms = primes(n * randi(10000));
% p = prms(randi(length(prms)));
q = 23;

S = [4; 7; 5; 5];


% stdDev = sqrt(n) + p;
A = unifrnd(0, 1, [n, m]);

e = normrnd(0, 1, [n, 1]);

B = mod(A*S, q);
b = B + e;


M = 1;
sampleSize = 5;

u = mod(sum(A(randsample(1:length(A), sampleSize),:)), q); %%%%%%%%%% Population must be a vector
v = mod(sum(B(randsample(1:length(B), sampleSize),:)) - M * floor(q/2), q);



% B = 
