function plotnumbergamepredictions(hypotheses, priors, data)

% hypotheses = a matrix whose columns are particular hypotheses,
% represented as logical vectors reflecting datapoint membership
%
% priors = a vector of prior probabilities for each hypothesis
%
% data = a vector of observed numbers



dims = size(hypotheses);
N = dims(1);
predictive = zeros(N,1);

logicalData = zeros(1,N);
for i=1:N,
  if (find(data==i))
    logicalData(i) = 1;
  end
end
logicalData = logical(logicalData);

%disp('LOGICAL DATA:');
%disp(logicalData');

dims = size(hypotheses);
hyps = dims(2);
posteriors = zeros(1,hyps);
% compute the posterior for every hypothesis
Z = 0;
for h=1:hyps,
  cur = hypotheses(:,h);
  logJoint = log(priors(h)) + ...
      numbergamelikelihood(cur, logicalData);
  joint = exp(logJoint);
  Z = Z + joint;
  posteriors(h) = joint;
end

posteriors = posteriors / Z;

% compute the predictive contribution for each
% hypothesis and add it in to the predictive


for h=1:hyps,
  predictive = predictive + hypotheses(:,h) * posteriors(h);

end




% plot it as a bar chart, also plotting the top 10 hypotheses in
% decreasing order of posterior probability

figure;

%subplot(11,1,1);

str = 'Predictions given observations';
for i=1:N,
  if (logicalData(i))
    str = strcat(str, sprintf(' %d', i));
  end
end
bar(predictive);
title(str);
xlabel('Number')
ylabel('Likelihood of Inclusion')
axis tight;
