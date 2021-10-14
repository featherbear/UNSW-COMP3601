function test_string() 
    n_tests = 10000;
    count = 0;
        
    tic
    for i = 1:n_tests
      count = count + (doTest() == 1);
    end
    toc

    fprintf("Statistics (%u tests) %.2f%%\n", n_tests, count / n_tests * 100)

end



function ret = doTest()
    global q;
    q = 23; % shared 

    m = 4;
    n = 12;
    
    S = lwe.generatePrivateKey(m);
    [A, B] = lwe.generatePublicKey(S, m, n);
    
    % Send public keys with maintained integrity

    stringSend = "Hello, world!";
    bitsToSend = dec2bin(char(stringSend), 8);
    
    theInternetOrSomethingForU = [];
    theInternetOrSomethingForV = [];

    for i = 1:length(bitsToSend)
        for j = 1:length(bitsToSend(i, :))
           [u,v] = lwe.encryptBit(bitsToSend(i, j), A, B);
           theInternetOrSomethingForU = [theInternetOrSomethingForU; u];
           theInternetOrSomethingForV = [theInternetOrSomethingForV; v];
        end
    end
    

    % whirrrrrrrrrrrrrrrrr
    
    % resultString;
    stringRecv = [];
    letterBits = [];
    for i = 1:length(theInternetOrSomethingForU)
        m = lwe.decryptBit(theInternetOrSomethingForU(i, :), theInternetOrSomethingForV(i), S);
        letterBits = [letterBits, m];
        if (length(letterBits) == 8) 
            stringRecv = [stringRecv; letterBits];
            letterBits = [];
        end
    end

    resultString = char(reshape(bin2dec(num2str(stringRecv)), 1, []));
    
    ret = strcmp(resultString, stringSend);
end

