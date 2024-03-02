function testHaar()
% test the Haar transform

load('testHaar.mat')

if (exist('calcHaarLevel1','file'))
    myH1test = calcHaarLevel1(Ytest);
    e = sum(sum(abs(myH1test - H1test)));
    if (sum(sum(abs(myH1test - H1test))) < 1e-7)
        fprintf('calcHaarLevel1: OK\n');
    else 
        fprintf('calcHaarLevel1: FAILED (err=%f)\n', e);
    end
else 
   fprintf('calcHaarLevel1: NOT IMPLEMENTED\n');
end

if (exist('calcHaar','file'))
        myH4test = calcHaar(Ytest,4);
        e = sum(sum(abs(myH4test - H4test)));
    if (e < 1e-7)
        fprintf('calcHaar: OK\n');
    else 
        fprintf('calcHaar: FAILED (err=%f)\n', e);
    end
else 
   fprintf('calcHaar: NOT IMPLEMENTED\n');
end
