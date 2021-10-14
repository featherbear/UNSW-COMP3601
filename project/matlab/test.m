

function test()
    
        parfor fuzz_b = 1:10000
    
            n_tests = 10000;
            count_0 = 0;
            count_1 = 0;
        
            m = fuzz_b; % 4
            n = 12;
            q = 23;
        
            for i = 1:n_tests
              count_0 = count_0 + (runTest(0, m, n, q) == 0);
            end
        
            for i = 1:n_tests
              count_1 = count_1 + (runTest(1, m, n, q) == 1);
            end
        
            
            %fprintf("m=%u, n=%u, q=%u, M0=%u, M1=%u\n", m, n, q, count_0, count_1);
    
            cmd = sprintf('echo m=%u, n=%u, q=%u, M0=%u, M1=%u >> %s', m, n, q, count_0, count_1, "logfile.txt");
            status = 1;
            while status
              status = system(cmd);
            end
            % fprintf("Statistics (%u tests) | M=0 %.2f%% | M=1 %.2f%%", n_tests, count_0 / n_tests * 100, count_1 / n_tests * 100)
       
        end
end

function m = runTest(M, sizeM, sizeN, sizeQ)
  % globalise q to indicate shared-ness
  global q;

  %%%%%%% SHARED
  q = sizeQ;
  %%%%%%% SHARED

  m = sizeM;
  n = sizeN;

  S = lwe.generatePrivateKey(m);

  [A, B] = lwe.generatePublicKey(S, m, n);

  [u, v] = lwe.encryptBit(M, A, B);
  m = lwe.decryptBit(u, v, S);
end

