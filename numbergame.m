clear all
close all

%% Input Data

% data = [];
% data = [50];
% data = [7];
% data = [90 70 30];
% data = [21 91 11];
% data = [64 32 16];
% data = [2 4 6 8];
% data = [1 3 5 7 9];
% data = [5 23 77 91];
% data = [2 73 17 47 11];
% data = [51 52 57 58];
% data = [1 2 3 5 8];
 data = [4 8 15 16 23];

%% Initiate Variabless

N = 100; % This defines the range of numbers we are considering (up to 100)

% I initiate hypothesis matrix. Each column will represent a hypothesis, and each cell
% represents if the element that row represents is in the hypothesis or not
% by assigning a logical value.
hyps = zeros(N, 0); 

% I initiate the variable priors. Each column will contain the prior
% probability of the hypothesis in the corresponding column of hyps.
priors = zeros(1, 5176); 

% I initiate a counter for each hypothesis space: H1 is the group of raw
% magnitude hypotheses, H2 intuitive mathematical properties and H3
% non-intuitive mathematical properties. This will compute the number of
% hypotheses in each space.
countH1 = 0;
countH2 = 0;
countH3 = 0;

% I also assign each hypothesis space a prior. When filling out the
% variable priors, I will assign to each hypothesis in a space Hn the value
% priorHn / countHn, priorHn denoting the prior of the hypothesis space and
% countHn the number of hypotheses in each space.
priorH1 = 3/5;
priorH2 = 1/5;
priorH3 = 1/5;

%% Hypothesis

%TODO: Add your own code here which adds additional hypotheses to the
%hypothesis space (for d and e). Make sure to describe each hypothesis.

%% H1: Raw magnitude (5050) // p(H1) = 3/5
% Adds hypothesis for all intervals in [1;100]

for i = 1 : N
    for j = i : N
        hypload = zeros (N,1);
        for k = j : i
            hypload(k) = 1;
        end
        hyps = [hyps hypload];
        countH1 = countH1 + 1;
    end
end

%% H2: Intuitive Mathematical Properties (I came up with 27) // p(H2) = 1/5.

%% Multiples
% Adds hypotheses for all multiples of numbers you would find on a
% multiplication table (1:12).

% Credit to skeleton

for i = 1 : 12,
    hypload = zeros (N , 1);
    for j = i : i : N,
        if j < 101,
            hypload (j , 1) = 1;
        else
            break
        end
    end
    hyps = [hyps hypload];
    countH2 = countH2 + 1;
end

%% Odd Numbers
% Adds hypotheses for all odd numbers

% Credit to prompt

hypload = zeros (N , 1);
for i = 1 : N,
    if mod (i , 2) == 1, % If i is odd, the remainder of j/2 will be 1.
        hypload (i , 1) = 1;
    end
end
hyps = [hyps hypload];
countH2 = countH2 + 1;

%% Primes
% Adds hypothesis for Prime Numbers


for i = 1 : 100,
    hypload = zeros (N, 1);
    if sum (divisors (i)) == 1 + i, % If i is prime, it only has only two divisors: 1 and i, thus the sum of its divisors (sigma) will be equal to 1 + i.
        hypload (i,1) = 1;
    end
end
hyps = [hyps hypload];
countH2 = countH2 + 1;

%% Perfects
% Adds hypothesis for Perfect Numbers

for i = 1 : 100,
    hypload = zeros (N, 1);
    if sum (divisors (i)) - i == i
        % sum (divisors (i)) - i returns aliquot sum, or sum of perfect divisors.
        % If the aliquot sum of a number is equal to the number, then the number is perfect
        hypload (i,1) = 1;
    end
end
hyps = [hyps hypload];
countH2 = countH2 + 1;

%% Triangle and Square
% Adds hypotheses for triangle and square numbers (i = 3 : 2)

for i = 2 : 3,
    hypload = zeros (N, 1);
    for j = 1 : 13,
        X = (i - 2) * j * (j - 1) / 2 + j; 
        if X < 101, % Adds X to hypload (by changing element X to 1)
            hypload (X,1) = 1;
        else
            break % Breaks if the number is bigger than 100. This prevents unnecessary iterating
        end
    end
    hyps = [hyps hypload];
    countH2 = countH2 + 1;
end

%% Powers
% Adds hypotheses for powers of i (i = 2 : 10)

for i = 2 : 10,
    hypload = zeros (N, 1);
    for j = 1 : 10,
        X = j ^ i;
        if X < 101, % Adds X to hypload (by changing element X to 1)
            hypload (X,1) = 1;
        else
            break % Breaks if the number is bigger than 100. This prevents unnecessary iterating
        end
    end
    hyps = [hyps hypload];
    countH2 = countH2 + 1;
end

%% Fibonacci Sequence
% Adds hypothesis for Fibonacci Sequence (as many people of science know
% the first elements by heart.)

X = zeros (10, 1);
hypload = zeros (N, 1);
for i = 1 : 10,
    if i <= 2,
        X (i) = 1; % Sets first two terms of the sequence to 1.
        hypload (X(i), 1) = 1; % Adds X(i) to hypload (by changing element X to 1)
    else
        X (i) = X (i - 1) + X (i - 2); % Computes following terms;
        hypload (X (i), 1) = 1; % Adds X(i) to hypload (by changing element X to 1)
    end
end
hyps = [hyps hypload];
countH2 = countH2 + 1;

%% H3: Non-intuitive math properties (I came up with 99) // p(H3) = 1/5.

%% Abundant Numbers
% Adds hypothesis for Abundant Numbers

hypload = zeros (N, 1);
for i = 1 : 100,
    if sum (divisors (i)) - i > i
        % sum (divisors (i)) - i returns aliquot sum, or sum of perfect divisors.
        % If the aliquot sum of a number is greater than the number, then the number is
        % abundant.
        hypload (i,1) = 1;
    end
end
hyps = [hyps hypload];
countH3 = countH3 + 1;

%% Deficient Numbers
% Adds hypothesis for Deficient Numbers

hypload = zeros (N, 1);
for i = 1 : N,
    if sum (divisors (i)) - i < i,
        % sum (divisors (i)) - i returns aliquot sum, or sum of perfect divisors.
        % If the aliquot sum of a number is inferior to the number, then the number is
        % deficient.
        hypload (i,1) = 1;
    end
end
hyps = [hyps hypload];
countH3 = countH3 + 1;

%% Polygonals
% Adds hypotheses for less well known polygonal numbers (i = 5 : 8)

for i = 5 : 8,
    hypload = zeros (N, 1);
    for j = 1 : 13,
        X = (i - 2) * j * (j - 1) / 2 + j; % For i sides, the j-th element is equal to (i - 2) * j * (j - 1) / 2 + j
        if X < 101, % Adds X to hypload (by changing element X to 1)
            hypload (X,1) = 1;
        else
            break % Breaks if the number is bigger than 100. This prevents unnecessary iterating
        end
    end
    hyps = [hyps hypload];
    countH3 = countH3 + 1;
end

%% Exponents
% Adds hypotheses for n = 1 : 10 to the power of i = 2 : 6

for i = 2 : 6,
    hypload = zeros (N, 1);
    for n = 1 : 10,
        X = n ^ i;
        if X < 101, % Adds X to hypload (by changing element X to 1)
            hypload (X,1) = 1;
        else
            break % Breaks if the number is bigger than 100. This prevents unnecessary iterating
        end
    end
    hyps = [hyps hypload];
    countH3 = countH3 + 1;
end

%% Multiples
% Adds hypotheses for all multiples of numbers up to N that wouldn't be on a multiplication table.

% Credit to skeleton

for i=13:N,
    hypload=zeros(N,1);
    for j=i:i:N
        hypload(j,1)=1;
    end
    hyps = [hyps hypload];
    countH3 = countH3 + 1;
end

%% Compute Priors

% EXTRA CREDIT: Find a more principled way of defining the priors, to fit
% human data better. For more extra credit, try a generative approach: Assign
% priors to hypotheses based on rules that make rules

% The default is a uniform prior - all hypotheses are given equal weight
% priors=ones(1,size(hyps,2));
% priors=priors/sum(priors);

% Computes priors for each hypothesis in H1
priors (1 : countH1) = priorH1 / countH1; 

% Computes priors for hypotheses in hypothesis space H2 (Intuitive Mathematical Properties)
priors (countH1 + 1 : countH1 + countH2) = priorH2 / countH2;

% Computes priors for hypotheses in hypothesis space H3 (less intuitive mathematical properties)
priors (countH1 + countH2 + 1 : countH1 + countH2 + countH3) = priorH3 / countH3; 

%% Graph Output
plotnumbergamepredictions(hyps,priors,data)


