function [Model,Q]=mssvdd(Traindata,Trainlabel,maxIter,numofmodes,Cval,omega,Bta,eta,D,d)


%Initialize the Q{i} for each modality
for i=1:numofmodes
tempQ = pca(Traindata{i}');
Q{i}=tempQ(:,1:d)';
reducedData{i} = Q{i} * Traindata{i};
end

for ii=1:maxIter
    ReducedcombinedTraindata=[];
    combinedTrainLabel=[];
for i=1: numofmodes
    ReducedcombinedTraindata=[ReducedcombinedTraindata reducedData{i}];
    combinedTrainLabel=[combinedTrainLabel; Trainlabel];
end

Model = svmtrain(combinedTrainLabel, ReducedcombinedTraindata', ['-s 5 -t 0 -c ',num2str(Cval)]);
    
%Get the bigAlphaVector which is vector of all alphas for all concatenated data
Alphaindex=Model.sv_indices; %Indices where alpha is non-zero
AlphaValue=Model.sv_coef; %values of Alpha
BigAlphavector=zeros(size(ReducedcombinedTraindata,2),1); %Generate a vector of zeros
for qq=1:size(Alphaindex,1)
BigAlphavector(Alphaindex(qq))=AlphaValue(qq);
end
%Here get the Alphavector{i} for corresponding modality
j=0; i=1; 
while(j<size(BigAlphavector,1))
Alphavector{i}= BigAlphavector(j+1:j+size(reducedData{i},2));
j=j+size(reducedData{i},2);
i=i+1;
end
   
const_d= constraintmssvdd(omega,Cval,Q,Traindata,Alphavector,numofmodes); %Type of regularization term used
     
    for M_num=1:numofmodes %M_num = mode number
    %compute the gradient and update the matrix Q{i}
    Sum1=2*Q{M_num}*Traindata{M_num}*diag(Alphavector{M_num})*Traindata{M_num}';

loopsum2j=zeros(d,D{M_num});
    for j=1:numofmodes
             sum=Q{j}*Traindata{j}*Alphavector{j};
             loopsum2j=loopsum2j+sum;
    end  
  Sum2=2*loopsum2j*diag(Alphavector{M_num}'*Traindata{M_num}');
   
    Grad{M_num} = Sum1-Sum2+(Bta*const_d{M_num});  
    Q{M_num} = Q{M_num} - eta*Grad{M_num}; % I
    %orthogonalize and normalize Q{i}
    Q{M_num} = OandN_Q(Q{M_num});
    reducedData{M_num} = Q{M_num} * Traindata{M_num};
    end
end
end