clear all
close all

N = 100; % This defines the range of numbers we are considering (up to 100)

%---Your Code Here ---- (Input different data sets, one set at a time.)

data =[];

%---------------------------------

% Note to self. Once done writing code for hypotheses, add up number of
% hypotheses to be produced and write that as the number of columns hyps
% should have (zeros(N,col)).
hyps = zeros(N, 0);

% I initiate the variable priors. When done writing hypotheses, I will
% replace size(hyps, 2) with the number of columns hyps should have.
priors = ones(1, size(hyps, 2));


%% Hypothesis

%TODO: Add your own code here which adds additional hypotheses to the
%hypothesis space (for d and e). Make sure to describe each hypothesis!

%---Your Code Here---

% H1: Raw magnitude (5050) // p(H1) = 3/5

% Adds hypothesis for all intervals in [1;100]
% Note to self: this should yield 5050 hypotheses (5050 col to hyps)

for i = 1 : N
    for j = i : N
        hypload = zeros (N,1);
        for k = j : i
            hypload(k) = 1;
        end
        hyps = [hyps hypload];
    end
end

% H2: Intuitive math properties (I came up with 26) // p(H2) = 1/5.

% Adds hypotheses for all multiples of numbers you would find on a
% multiplication table (1:12).
% Credit to skeleton
% Note to self: this should yield 12 hypotheses (12 col to hyps)

for i=1:12,
    hypload=zeros(N,1);
    for j=i:i:N
        hypload(j,1)=1;
    end
    hyps=[hyps hypload];
end

% Adds hypotheses for all odd numbers
% Credit to prompt
% Note to self: this should yield 1 hypotheses (1 col to hyps)

hypload=zeros(N,1);
for j=1:N
    if mod(j,2)==1
        hypload(j,1)=1;
    end
end
hyps = [hyps hypload];

% Adds hypothesis for Prime Numbers

for i = 1 : 100,
    hypload = zeros (N, 1);
    if sum (divisors (i)) == 1 + i, % If i is prime, it only has only two divisors: 1 and i, thus the sum of its divisors (sigma) will be equal to 1 + i.
        hypload (i,1) = 1;
    end
    hyps = [hyps hypload];
end

% Adds hypothesis for Perfect Numbers
% sum (divisors (i)) - i returns aliquot sum, or sum of perfect divisors.
% If the aliquot sum of a number is equal to the number, then the number is
% perfect
% Note to self: this should yield 1 hypotheses (1 col to hyps)

for i = 1 : 100,
    hypload = zeros (N, 1);
    if sum (divisors (i)) - i == i
        hypload (i,1) = 1;
    end
    hyps = [hyps hypload];
end

% Adds hypotheses for trangle and square numbers (s = 3 : 2)
% For s sides, the n-th element is equal to
% (s - 2) * n * (n - 1) / 2 + n
% Note to self: this should yield 2 hypotheses--one for each polygon (2 col to hyps)


for s = 2 : 3,
    hypload = zeros (N, 1);
    for n = 1 : 13,
        X = (s - 2) * n * (n - 1) / 2 + n;
        if X < 101, % Adds X to hypload (by changing element X to 1)
            hypload (X,1) = 1;
            hyps = [hyps hypload];
        else
            break % Breaks if the number is bigger than 100. This prevents unnecessary iterating
        end
    end
end

% Adds hypotheses for powers of i (i = 2 : 10)
% Note to self: this should yield 9 hypotheses (9 col to hyps)

for i = 2 : 10,
    hypload = zeros (N, 1);
    for n = 1 : 10,
        X = n ^ i;
        if X < 101, % Adds X to hypload (by changing element X to 1)
            hypload (X,1) = 1;
            hyps = [hyps hypload];
        else
            break % Breaks if the number is bigger than 100. This prevents unnecessary iterating
        end
    end
end

%% Fibonacci Sequence
% Adds hypothesis for Fibonacci Sequence (as many people of science know
% the first elements by heart.)

X = zeros (10, 1);
hypload = zeros (N, 1);
for i = 1:10,
    if i <=2,
        X (i) = 1; % Sets first two terms of the sequence to 1.
        hypload ( X(i ),1) = 1; % Adds X(i) to hypload (by changing element X to 1)
    else
        X (i) = X (i - 1) + X (i - 2); % Computes following terms;
        hypload ( X(i ),1) = 1; % Adds X(i) to hypload (by changing element X to 1)
    end
end
hyps = [hyps hypload];

%% H3: Non-intuitive math properties (I came up with 100) // p(H3) = 1/5.

%% Abundant Numbers
% Adds hypothesis for Abundant Numbers
% sum (divisors (i)) - i returns aliquot sum, or sum of perfect divisors.
% If the aliquot sum of a number is greater than the number, then the number is
% abundant.
% Note to self: this should yield 1 hypotheses (1 col to hyps)


for i = 1 : 100,
    hypload = zeros (N, 1);
    if sum (divisors (i)) - i > i
        hypload (i,1) = 1;
    end
    hyps = [hyps hypload];
end

%% Deficient Numbers
% Adds hypothesis for Deficient Numbers
% sum (divisors (i)) - i returns aliquot sum, or sum of perfect divisors.
% If the aliquot sum of a number is inferior to the number, then the number is
% deficient.
% Note to self: this should yield 1 hypotheses (1 col to hyps)


for i = 1 : 100,
    hypload = zeros (N, 1);
    if sum (divisors (i)) - i < i
        hypload (i,1) = 1;
    end
    hyps = [hyps hypload];
end

%% Polygonals
% Adds hypotheses for less well known polygonal numbers (s = 5 : 8)
% For s sides, the n-th element is equal to
% (s - 2) * n * (n - 1) / 2 + n
% Note to self: this should yield 4 hypotheses--one for each polygon (4 col to hyps)


for s = 5 : 8,
    hypload = zeros (N, 1);
    for n = 1 : 13,
        X = (s - 2) * n * (n - 1) / 2 + n;
        if X < 101, % Adds X to hypload (by changing element X to 1)
            hypload (X,1) = 1;
            hyps = [hyps hypload];
        else
            break % Breaks if the number is bigger than 100. This prevents unnecessary iterating
        end
    end
end

%% Exponents
% Adds hypotheses for n = 1 : 10 to the power of i = 2 : 6
% Note to self: this should yield 5 hypotheses (5 col to hyps)

for i = 2 : 6,
    hypload = zeros (N, 1);
    for n = 1 : 10,
        X = n ^ i;
        if X < 101, % Adds X to hypload (by changing element X to 1)
            hypload (X,1) = 1;
            hyps = [hyps hypload];
        else
            break % Breaks if the number is bigger than 100. This prevents unnecessary iterating
        end
    end
end

%% Multiples
% Adds hypotheses for all multiples of numbers up to N that wouldn't be on
% a multiplication table.
% Credit to skeleton
% Note to self: this should yield 88 hypotheses (88 col to hyps)

for i=13:N,
    hypload=zeros(N,1);
    for j=i:i:N
        hypload(j,1)=1;
    end
    hyps=[hyps hypload];
end

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


