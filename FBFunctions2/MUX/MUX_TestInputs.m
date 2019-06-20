TotTestCases = 3;
TestIters = 17;
TestInps = 1;
TestCase = 1;

%Bool 16777216 00000001000000000000000000000000
% Safebool 33554432 00000010000000000000000000000000
%Int 67108864 00000100000000000000000000000000
%Qmn 142606337 00001000000000000000000000000000 
%Qmn will have fraction part with it.
%Safebool 0 = 1431655765 1 = -1431655766
%Inputs Type 1 Data1 Type2 Data2
Inputs = int32([67108864,674,67108864,673; % Int type, greater int part, val1 and val2 +ve
          67108864,673,67108864,674;% Int type, lesser int part, val1 and val2 +ve
          67108864,-2147483647,67108864,-2147483648;% Int type, greater int part, val1 and val2 -ve
          67108864,-2147483648,67108864,2147483647;% Int type, lesser int part, val1 -ve and val2 +ve
          142606336,2147483647,142606337,2147483647;% Qmn type, same +ve int part, but greater fractional part
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
          142606337,0,142606338,0; % Qmn type, same int part, but lesser fractional part
           ])
ExpectedOutputs = int32([16777216,673,0;
          16777216,673,0;
          16777216,-2147483648,0;
          16777216,-2147483648,0;
          142606336,2147483647,0;
          142606336,-2147483647,0;
          142606337,-2147483648,0;
          142606337,6000,0;
         134217728,0,0;
         142606337,1,0;
         67108864,-2147483648,0;
         142606337,-2147483648,256;
         67108864,-2147483648,256;
        268435456,-2147483648,256;
         67108864,-2147483648,256;
         33554432,-2147483648,256;
         142606337,0,256;
          ])
            
tf = sltest.testmanager.TestFile('MUX'); %name of the mldatx file
ts = getTestSuites(tf);
tc = getTestCases(ts);
results = run(tc(1));
tcResults = getTestCaseResults(results);
iterResults = getIterationResults(tcResults);
Result = table([iterResults.Outcome].');
for i = 1:TestIters
   TestInps = i;
   sim('FBFunctions_Harness_MUX',10); % 
   ActualOutputs(i,:) = Actops(i,:,11); % 51 time at which I get outputs
end

t = table(Inputs, ExpectedOutputs, ActualOutputs, Result)




 