clear all 
close all

N = 100; % This defines the range of numbers we are considering (up to 100)

%---Your Code Here ---- (Input different data sets, one set at a time.)

data =[37];

%---------------------------------

hyps=zeros(N,0);


%% Multiples Hypothesis 
% Adds hypotheses for all multiples of numbers up to N

for i=2:100
    hypload=zeros(N,1);
  
    for j=i:i:N
        hypload(j,1)=1;
    end
    
    hyps=[hyps hypload];

end

hypload=zeros(N,1);
for j = 1:N
    if mod(j,2) == 1
        hypload(j) = 1;
    end
end
hyps = [hyps hypload];

%TODO: Add your own code here which adds additional hypotheses to the
%hypothesis space (for d and e). Make sure to describe each hypothesis!

%---Your Code Here---


%%
% EXTRA CREDIT: Find a more principled way of defining the priors, to fit
% human data better. For more extra credit, try a generative approach: Assign 
% priors to hypotheses based on rules that make rules

%The default is a uniform prior - all hypotheses are given equal weight
priors=ones(1,size(hyps,2));
priors=priors/sum(priors);

%---Your Code Here---
% Redefine 'priors'


%%
%---Don't change the code below - it graphs the output--
plotnumbergamepredictions(hyps,priors,data)


