TotTestCases = 2;
TestIters = 16;
TestInps = 1;
Inputs = int32([67108864,674,67108864,673; % Int type, greater int part, val1 and val2 +ve
          67108864,673,67108864,674;% Int type, lesser int part, val1 and val2 +ve
          67108864,-2147483647,67108864,-2147483648;% Int type, greater int part, val1 and val2 -ve
          67108864,-2147483648,67108864,2147483647;% Int type, lesser int part, val1 -ve and val2 +ve
          142606337,2147483647,142606336,2147483647;% Qmn type, same +ve int part, but greater fractional part
           142606337,-2147483647,142606336,-2147483647;% Qmn type, same -ve int part, but greater fractional part
           142606337,-2147483647,142606337,-2147483648; % Qmn type, greater -ve int part, but same fractional part
           142606337,6000,134217728,7000; % Qmn type, lesser int part, but greater fractional part
           142606337,0,134217728,0; % Qmn type, same int part, but greater fractional part
           142606337,1,142606337,1;% Qmn type, same values
           67108864,-2147483648,67108864,-2147483648; % Int type, same values
           67108864,-2147483647,142606337,-2147483648; % Different datatypes for value1 and 2  Int type for val1
           142606337,-2147483647,67108864,-2147483648; % Different datatypes for value1 and 2, Qmn type for val1
           268435456,-2147483647,268435456,-2147483648; % Same invalid datatypes for value1 and 2, Qmn type for val1
           16777216,-2147483647,67108864,-2147483648; % Different datatypes for value1 and 2, Invalid type for val1
           67108864,-2147483647,33554432,-2147483648; % Different datatypes for value1 and 2, Invalid type for val2
          ])
ExpectedOutputs = int32([16777216,1,0;
          16777216,0,0;
          16777216,1,0;
          16777216,0,0;
          16777216,1,0;
          16777216,0,0;
          16777216,1,0;
          16777216,0,0;
          16777216,1,0;
          16777216,0,0;
          16777216,0,0;
          16777216,1,256;
          16777216,1,256;
          16777216,1,256;
          16777216,1,256;
          16777216,1,256;
          ])
      
  %ActualOutputs = int32([0,0,0;
       %  0,0,0;
         % 0,0,0;
          %0,0,0;
          %0,0,0;
          %0,0,0;
          %])
      
      
tf = sltest.testmanager.TestFile('GRT');
ts = getTestSuites(tf);
tc = getTestCases(ts);
results = run(tc(1));
tcResults = getTestCaseResults(results);
iterResults = getIterationResults(tcResults);
Result = table([iterResults.Outcome].');
for i = 1:TestIters
   TestInps = i;
   sim('FBFunctions_GT_Harness',10);
   ActualOutputs(i,:) = Actops(i,:,51);
end

t = table(Inputs, ExpectedOutputs, ActualOutputs, Result




 