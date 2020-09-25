% This is a sample demo code for Multimodal Subspace Support Vector Data Description
% The demo code is provided for 2 modalities Linear case MS-SVDD
% Please contact fahad.sohrab@tuni.fi for any errors/bugs
clc
close all
clear

%%Generate Random Data
noOfTrainData = 500; noOfTestData = 100;
D{1} = 5; D{2}= 4; %Original dimentionality differnet modalities
Traindata{1} = rand(D{1},noOfTrainData); %Training Data/Features from modality 1
Traindata{2} = rand(D{2},noOfTrainData); %Training Data/Features from modality 2
trainlabels = ones(noOfTrainData,1); %Training labels (all +1s)

testlabels = -ones(noOfTestData,1);
perm = randperm(noOfTestData);
positiveSamples = floor(noOfTestData/2);
testlabels(perm(1:positiveSamples))=1; % test labels, +1 for target, -1 for outliers
Testdata{1} = rand(D{1},noOfTestData); %Testing Data/Features from modality 1
Testdata{2} = rand(D{2},noOfTestData); %Testing Data/Features from modality 2

%%Setting hyperparameters, regularization term(omega) and decission type
omega=1; % 0 for no regularizaterm used other options 1,2,3,4,5,6
DecissionNumber=1; %1=AND, 2=OR, 3=1st modality, 4=2nd modality
maxIter = 100;
eta = 0.1;      %Used as step size for gradient
Bta=10^-1;      %Controling the importance of regularization term
d=2;            %data in lower dimension, make sure its < D{1} and D{2}
Cval=0.1;       %Value of hyperparameter C
numofmodes=2;   %Total number of modalities
sigma=10^-3;    %For non-linear usage

%For non-linear cases, apply NPT.m (for Non-linear projection trick) or
%kernel_rbf.m (for kernel trick) on the data and then use MS-SVDD

[Model,Q]=mssvdd(Traindata,trainlabels,maxIter,numofmodes,Cval,omega,Bta,eta,D,d);

RedTestdata1=Q{1} * Testdata{1}; %Test Data1 after maping from D1 to d
RedTestdata2=Q{2} * Testdata{2}; %Test Data2 after maping from D2 to d

predict_label1 = svmpredict(testlabels, RedTestdata1', Model);
predict_label2 = svmpredict(testlabels, RedTestdata2', Model);

[Decission1,Decission2,Decission3,Decission4] = decissionmssvdd(predict_label1,predict_label2);
eval(['predict_label=Decission' num2str(DecissionNumber) ';']);

EVAL = Evaluate(testlabels,predict_label);

accuracy =EVAL(1)
sensitivity =EVAL(2)
specificity =EVAL(3)
precision =EVAL(4)
recall =EVAL(5)
f_measure =EVAL(6)
gmean=EVAL(7)
