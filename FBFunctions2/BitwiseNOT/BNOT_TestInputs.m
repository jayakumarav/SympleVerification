TotTestCases = 3;
TestIters = 6;
TestInps = 1;
TestCase = 1;

%Bool 16777216 00000001000000000000000000000000
% Safebool 33554432 00000010000000000000000000000000
%Int 67108864 00000100000000000000000000000000
%Qmn 142606337 00001000000000000000000000000000 
%Qmn will have fraction part with it.
%Safebool 0 = 1431655765 1 = -1431655766
%Inputs Type 1 Data1 Type2 Data2
Inputs = int32([67108864,5; % Int type
               67108864,-2147483648;% Int type
               67108864,2147483647;% Inttype
               67108864,0; % Int type
          33554432,1431655765;% Safebool type,0 
          16777216,1;
         ]);
              
ExpectedOutputs = int32([67108864,-6,0;
                         67108864,2147483647,0;
                         67108864,-2147483648,0;
                         67108864,-1,0;
                         33554432,-1431655766,256;
                         16777216,-2,256;
                        ]);
      
  %ActualOutputs = int32([0,0,0;
       %  0,0,0;
         % 0,0,0;
          %0,0,0;
          %0,0,0;
          %0,0,0;
          %])
      
      
tf = sltest.testmanager.TestFile('BNOT'); %name of the mldatx file
ts = getTestSuites(tf);
tc = getTestCases(ts);
results = run(tc(1));
tcResults = getTestCaseResults(results);
iterResults = getIterationResults(tcResults);
Result = table([iterResults.Outcome].');
for i = 1:TestIters
   TestInps = i;
   sim('FBFunctions_Harness_BNOT',6); % 
   ActualOutputs(i,:) = Actops(i,:,11); % 51 time at which I get outputs
end

t = table(Inputs, ExpectedOutputs, ActualOutputs, Result)




 