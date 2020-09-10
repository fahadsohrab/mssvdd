% This fucntion is used for selection of regularization term for for "Multimodal subspace support vector data description"
% Input:  ConsType = type of regularization (omega) used 0,1,2,3,4,5,6
%         Cval= Cval value from SVDD used to identify support vectors etc
%         Q= Projection matrices as cell Q{modality1} Q{modality2}
%         Traindata = contains Data from different modes as cell Traindata{modality1} Traindata{modality2}
%         Alphavector = contains corresponding alpha vectors as cell Alphavector{modality1} Alphavector{modality1}
%         numofmodes= Number of total modalities
% Output: const_d = The regularization term expresses the covariance of data from different modalities in the new
% low-dimensional space

function [const_d]= constraintmssvdd(consType,Cval,Q,Traindata,Alphavector,numofmodes)

for M=1:numofmodes
    
    if consType==0
        const_d{M}=0;
        
    elseif consType==1
        const_d{M}= 2*Q{M}*Traindata{M}*Traindata{M}';
        
    elseif consType==2
        const_d{M}= 2*Q{M}*Traindata{M}*Alphavector{M}*Alphavector{M}'*Traindata{M}';
        
        
    elseif consType==3
        AlphavectorC{M}=Alphavector{M};
        AlphavectorC{M}(AlphavectorC{M}==Cval)=0;
        const_d{M}= 2*Q{M}*Traindata{M}*AlphavectorC{M}*AlphavectorC{M}'*Traindata{M}';
        
        
    elseif consType==4
        const_d{M}=(2*(Q{1}*Traindata{1}*Traindata{M}')); %The j=1 is here (to avoid initiliazation)
        for j=2:numofmodes
            const_d{M}=const_d{M}+(2*(Q{j}*Traindata{j}*Traindata{M}')); %start from j=2 because j=1 already added
        end
        
    elseif consType==5
        const_d{M}=(2*Q{1}*Traindata{1}*Alphavector{1}*Alphavector{M}'*Traindata{M}'); %The j=1 is here (to avoid initiliazation)
        for j=2:numofmodes
            const_d{M}=const_d{M}+(2*Q{j}*Traindata{j}*Alphavector{j}*Alphavector{M}'*Traindata{M}');%start from j=2 because j=1 already added
        end
        
    elseif consType==6
        for j=1:numofmodes %Not to be confused with summation loop, its about lambda stuff,it should start from j=1
            AlphavectorC{j}=Alphavector{j};
            AlphavectorC{j}(AlphavectorC{j}==Cval)=0;
        end
        const_d{M}=2*(Q{1}*(Traindata{1}*(AlphavectorC{1}*AlphavectorC{M}')*Traindata{M}')); %The j=1 is here (to avoid initiliazation)
        for j=2:numofmodes %start from j=2 because j=1 already added
            const_d{M}=const_d{M}+(2*(Q{j}*(Traindata{j}*(AlphavectorC{j}*AlphavectorC{M}')*Traindata{M}')));
        end
        
    else
        disp('ERROR! Regularization term types can only be 0,1,2,3,4,5,6')
    end
    
end
end
