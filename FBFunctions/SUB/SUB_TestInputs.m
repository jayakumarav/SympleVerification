TotTestCases = 10;
TestIters = 14;
TestInps = 1;
Inputs = int32([67108864,5000,67108864,4000;
          67108864,36950,67108864,26540;
         67108864,0,67108864,0;
         67108864,26540,67108864,36950;
         67108864,-2147483648,67108864,1;
          67108864,1,67108864,-2147483648;
          134217729,34567,134217731,90000;
          134217729,90000,134217731,34567;
          134217731,34567,134217729,90000;
          134217731,90000,134217729,34567;
          142606336,-2147483647,146800640,0;
          142606336,1,146800640,-2147483645;
          142606336,-2147483647,142606336,1;
          142606336,1,142606336,-2147483646;
          ])
ExpectedOutputs = int32([67108864,1000,0;
          67108864,10410,0;
          67108864,0,0;
          67108864,-10410,0;
          67108864,-2147483648,4;
          67108864,2147483647,8;
          134217730,-55433,0;
          150994942,55432,0;
          150994942,-55432,0;
          134217730,55433,0;
          138412032,-2147483648,0;
          138412032,2147483647,0;
          150994943,-2147483648,4;
          150994943,2147483647,8;
          ])
      
  %ActualOutputs = int32([0,0,0;
       %  0,0,0;
         % 0,0,0;
          %0,0,0;
          %0,0,0;
          %0,0,0;
          %])
      
      
tf = sltest.testmanager.TestFile('SUB')
ts = getTestSuites(tf)
tc = getTestCases(ts)
results = run(tc(1))
tcResults = getTestCaseResults(results);
iterResults = getIterationResults(tcResults);
Result = table([iterResults.Outcome].');
for i = 1:TestIters
   TestInps = i;
   sim('FBFunctions_Harness4',10);
   ActualOutputs(i,:) = Actops(i,:,51)
end

t = table(Inputs, ExpectedOutputs, ActualOutputs, Result)



 