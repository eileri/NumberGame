function logLikelihood = numbergamelikelihood(hypothesis, data)
% NUMBERGAMELIKELIHOOD calculates the log likelihood of the data under
% the given hypothesis. Using logarithms is common in problems like these
% since we often need to compare very small numbers. Two small numbers can
% each get accidentally rounded to zero in the computer's memory (this is
% called "underflow error") while the logs of two very small numbers are
% just very negative and are thus easier to work with.
% 
% Inputs: HYPOTHESIS - a logical (0 or 1) vector on N elements, where
% hypothesis(i) = 1 iff i is contained in the extension of the concept
% represented by hypothesis: for hypothesis multiples of ten, think of all
% multiples of 10
%
% DATA - a vector where data(i) = 1 iff i is contained in the observed
% dataset. EX: data(10) = 1 if 10 is on the presented data set, ie.
% 10, 20, 50
%
% Note that length(hypothesis) == length(data) unless the caller of this
% procedure messed up.
%
% Output: LOGLIKELIHOOD - the log likelihood of the data under the given
% hypothesis
%
% TODO: We've accounted for the edge cases in this function. All you should
% need to do is *fill in the the log likelihood equation itself* (this
% should be one line line of code). 


% Edge cases: First check if data is consistent with the given hypothesis.
% if it isn't, P(D|H) = 0.

probDgH = 1;

[Xh,~] = size(hypothesis);

hypthSize = 0;
dataSize = 0;

counter = 0;
%loop over the data and hypothesis set until a data set element is
%encountered that contradicts the hypothesis, or the end of the data sets
%are reached
while probDgH ~= 0 && counter < Xh,
    %increment the counter for indexing
    counter = counter + 1;
    
    %if the current index of hypothesis is 1, that is, the integer
    %'counter' holds for the hypothesis
    if(hypothesis(counter)==1),
        %increment the size of the hypothesis by 1
        hypthSize = hypthSize + 1;
        
        %if the data set also contains this number
        if(data(counter)==1),
             %increment the size of data by 1
            dataSize = dataSize + 1;
        end
    end
    %if the hypothesis doesn't hold for any element of the data set, P(D|H)
    %is 0 which breaks the loop
    if(hypothesis(counter)==0) && (data(counter)== 1),
        probDgH = 0;
    end
end


% TODO: under strong sampling WITH REPLACEMENT, every consistent hypothesis
% assigns probability 1/(#options) to each data draw.

%if probDgH has not been altered, compute the log of it using the size of
%the hypothesis and data set]

%SIZE PRINCIPLE EXPLANATION: the larger the hypothesis size, the smaller
%(1/hypthSize). This value, exponentiated by the size of the observed data
%set will result in a still smaller number. A small hypothesis size will
%result in a larger P(D|H) than a large hypothesis size. As the value of
%P(D|H) decreases with each multiplication, the larger the data set, the
%smaller the value of P(D|H) will become.  The size of the data set is
%consistent across the testing of all hypotheses, so whether the size of
%the data set is large or small will not affect the relative probabilities
%of each hypothesis.
if(probDgH == 1)
    
    %---Your Code Here---
    
    logLikelihood = log10(1/hypthSize);
    
    %--------------------  
    
%otherwise, the likelihood is 0
else
    logLikelihood = -inf;
end
