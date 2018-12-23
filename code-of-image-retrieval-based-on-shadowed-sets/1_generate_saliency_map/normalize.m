function normVals=normalize(newVals,oldVals)
%function normVals=normalize(newVals,oldVals) normalizes the range of
%newVals to the range of oldVals such that every column is normalized
%independantly
%
%Inputs:    newVals - NxP matrix of new values to be normalized to the
%               range of oldVals
%           oldVals - Optional NxP matrix of original values (for 
%               arbitrary K).  Defaults to normalizing range to [0,1]
%
%Outputs:   normVals - NxP matrix of newVals normalized (columnwise) to 
%               the range of oldVals
%
%
%Initialize
[N P]=size(newVals);

%Supply optional argument, if required
if nargin == 1
    oldVals=[zeros(1,P);ones(1,P)];
end

%Find original minima/maxima
minVal=min(oldVals,[],1);
maxVal=max(oldVals,[],1);

%Find current minima/maxima
minNewVal=min(newVals,[],1);
maxNewVal=max(newVals,[],1);

%Perform normalization
warning off MATLAB:divideByZero %Error for divide by zero handled below
normVals=newVals-ones(N,1)*minNewVal;
normVals=normVals.*(ones(N,1)*(maxVal-minVal))./ ...
    (ones(N,1)*max(normVals,[],1));
normVals=normVals+ones(N,1)*minVal;
warning on MATLAB:divideByZero

%Error check for completely uniform inputs
uniformIndex=find(minNewVal==maxNewVal);
normVals(:,uniformIndex)=ones(N,1)*minNewVal(:,uniformIndex);
