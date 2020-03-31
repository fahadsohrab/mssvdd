 function EVAL = Evaluate_ellipse(ACTUAL,PREDICTED)
% This fucntion evaluates the performance of a classification model by 
% calculating the common performance measures: Accuracy, Sensitivity, 
% Specificity, Precision, Recall, F-Measure, G-mean.
% Input: ACTUAL = Column matrix with actual class labels of the training
%                 examples
%        PREDICTED = Column matrix with predicted class labels by the
%                    classification model
% Output: EVAL = Row matrix with all the performance measures


idx = (ACTUAL()==1);

p = length(ACTUAL(idx));
n = length(ACTUAL(~idx));
N = p+n;

tp = sum(ACTUAL(idx)==PREDICTED(idx));
tn = sum(ACTUAL(~idx)==PREDICTED(~idx));
fp = n-tn;
fn = p-tp;

tp_rate = tp/p;
tn_rate = tn/n;

accuracy = (tp+tn)/N;
sensitivity = tp_rate;
specificity = tn_rate;
precision = tp/(tp+fp);
precision(isnan(precision))=0;

recall = sensitivity;
f_measure = 2*((precision*recall)/(precision + recall));

f_measure(isnan(f_measure))=0; 

sensitivity(isnan(sensitivity))=0; % to avoind NANs
tp_rate(isnan(tp_rate))=0; 
tn_rate(isnan(tn_rate))=0; 

gmean = sqrt(tp_rate*tn_rate);

avg_senspec=((sensitivity+specificity)/2);

EVAL = [accuracy sensitivity specificity precision recall f_measure gmean avg_senspec];
