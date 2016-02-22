    
%% Building the Number Game
% (With some help from Josh Tenenbaum...)


%% b) Simple Hypotheses
% Now take a look at the script *numbergame.m* This script creates a simple
% hypothesis space, and then plots the probability that each given number
% from 1 to 100 is in the set, given some data. A hypothesis is just a
% column vector, where the nth entry is 1 if the number is in the set
% specified by the hypothesis and zero otherwise. The script has been set
% so that it initially only considers hypotheses of the form "multiples of
% x," where x is a number from 1 to 100. We'll expand on this hypothesis
% space below. This script will call your log_likelihood function, so make
% sure that this is working before you try. Try out the following data sets
% on this program (by setting the 'data = []' matrix equal to them in
% numbergame.m:
 
%[50]
%[7]
%[90 70 30]
%[21 91 11]
%[64 32 16]
%[2 4 6 8]
%[1 3 5 7 9]
%[5 23 77 91]
%[2 73 17 47 11]
%[51 52 57 58]
%[1 2 3 5 8]
%[4 8 15 16 23]

% Note: Some of these won't work very well in your program -- we'll change
% this soon.


%% c) Adding a Hypothesis 

% You'll notice that the program doesn't do very well with the example
% [1 3 5 7 9]. To make it work better on this problem, let's give it a
% hypothesis that represents "odd numbers." We can add a hypothesis using
% the following code:
 
%     hypload=zeros(N,1);
%     for j=1:N
%         if mod(j,2)==1
%             hypload(j)=1;
%         end
%     endhyps = [hyps hypload];


%% d) Adding More Hypotheses 
% Use the above code as a template for adding new hypotheses (The code has
% been set up so that you can append an arbitrary number of hypotheses this
% way -- each will be assigned equal prior probability). The first thing to
% do is to add intervals to your hypothesis space: for instance, all numbers
% between 50 and 60, or all numbers between 75 and 100. Beyond this, try to
% construct a hypothesis space that captures your own intuitions about the
% number game. Don't worry if you don't have strong intuitions about one or
% two of the sets of numbers in the example data we provide above - some
% may be random. Describe the hypotheses you added. 



%% e) Real Cognitive Science!
% Now you will actually model data that you collect yourself - this is real
% computational cognitive science!

% Give at least three friends the data sets
% from question 2 and ask them to list some candidate numbers that come
% quickly to mind as other members of the set. (You don't need to ask them
% for the probability of each and every number from 1 to 100). Compare your
% data to the output of your program. If you've modeled the data well, then
% the numbers that come to mind first should correspond to the numbers
% assigned high probability by your model. When (and if) there is a
% disparity, try to add concepts to your hypothesis space that attempt to
% bridge the gap. Describe the results of your survey and what changes you
% made. You don't need to model the data perfectly - just try to move in
% the right direction.


%% f) Experimental Results
% After changing your hypothesis space, test the predictions of your new
% model. For instance, imagine people kept saying "80" when you gave them
% [24 72]. You might say that this is because there is a concept "years in
% the 20th century in which a Republican was elected president of the
% United States." You should now test your model on new predictions - for
% instance when you say [52 20], people should say "88," but not "48."
% (This prediction probably wouldn't hold up.) Come up with three new sets
% (hopefully better ones!) for your revised model and test them on three
% more friends. Report your results. It's okay if your results disconfirm
% your model. The process of testing is the important part. Compare your
% data to the output of your program. If you've modeled the data well, then
% the numbers that come to mind first should correspond to the numbers
% assigned high probability by your model. When (and if) there is a
% disparity, try to add concepts to your hypothesis space that attempt to
% bridge the gap. Describe the results of your survey and what changes you
% made. You don't need to model the data perfectly - just try to move in
% the right direction. 


%% Extra Credit! 
% For extra credit, try changing not just the hypotheses, but the way that
% prior probabilities are assigned, in order to fit human data better. (See
% the *Extra Credit* section of the numbergame.m file for more detail. For
% even more extra credit, try a generative approach: Assign priors to
% hypotheses based on rules that make rules.


%-------------------------%
%% ------WRITE UP------- %%
%-------------------------%

% What does this program think about the number 37, now that is has "odd
% numbers" as a hypothesis? What does the program do when you remove this
% hypothesis?


% How, if at all, did changing the hypothesis space change the output of the
% program? What does this tell us about how learning new concepts can change
% our ability to make predictions about the real world? Can you give at least
% one example?


%-------------------------%
%% --------DONE--------- %%
%-------------------------%

% a) Log Likelihood 
% Start by opening the file *number_game_likelihood.m* and filling in the 
% required line of code. This function should return the log likelihood of 
% the data given a hypothesis, or log[Pr(D|H)]. Using logarithms is common 
% in problems like these since we often need to compare very small numbers. 
% Two small numbers can each get accidentally rounded to zero in the computer's 
% memory (this is called "underflow error") while the logs of two very small
% numbers are just very negative and are thus easier to work with. Recall 
% that adding the logarithms of two numbers is just like multiplying them
% together. *You'll need to write code that assigns log_likelihood with a value
% and then save the function.* The rest of the skeleton code will take care 
% of things like the sum and the priors. 

% If done properly your code will implicitly instantiate the size principle: 
% Hypotheses which make very specific predictions (small sets, in this case) 
% are given a big boost when those predictions come true, while hypotheses
% that make very general predictions (large sets) are given only a small boost. 
% For instance, "20, 40, 60" boosts the likelihood of the hypothesis 
% "multiples of 10" more than the hypothesis "even numbers." Remember that  
% you do not need to do anything extra to capture the size principle. Doing 
% the math properly will capture it for free.

%-------------------------%
%----------PROMPT---------%
%% ---The Number Game--- %%
%-------------------------%

% CLPS 1291 Assignment 2 Last Updated: February 2016

% _This lab is adapted from a problem set devised and generously provided
% by Josh Tenenbaum_

% Josh Tenenbaum (2000) presented participants with a version of the
% following game: An experimenter tells you a set of numbers (for instance,
% 10, 20 and 50) between 1 and 100 that are members of a certain concept
% that he/she has in mind. You tell the experimenter your belief that
% another given number is part of the concept. Intuitively, most of us
% judge 40 to be much more likely than 37, because the "rule of the game"
% seems likely to be the concept "multiples of ten." In this lab, you will
% write a program that plays the number game.
%%
% Mathematically, we will make the assumption that the experimenter chooses
% a concept and then randomly generates numbers between *1 and 100* from
% that concept. The concept specifies a set S. So, for instance, if he/she
% chooses the concept "all multiples of 20," then the set is 20, 40, 60,
% 80, 100. She is then equally likely to say any given number from this
% set. We will assume that this happens "with replacement": she is allowed
% to say the same number multiple times (e.g., "20, 20, 40" is allowed).
%%
% The probability that a given number is in the set is just the sum over
% all possible concepts, multiplied by how likely the concept is a priori,
% and how well the concept fits the data that we have been given so far.
%%
% Remember that the probability of a series of independently generated data
% points is just the probability of each one multiplied together.
%%
% We will write a program that will take a set of numbers as input and
% output a plot of the probability, for each number between 1 and 100, that
% the given number is in the set the experimenter has in mind. Luckily,
% Josh shared his code with us so we won't have to code this from scratch.
% But we will have to fill in some code.


