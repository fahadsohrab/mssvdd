% This fucntion is for implemention the decision strategies for "Multimodal subspace support vector data description"
% Input:  predict_label1 = Predicted labels from modality 1
%         predict_label2 = Predicted labels from modality 2
% Output: Decission1 = Decision strategy 1 (also called the AND gate)
%         Decission2 = Decision strategy 2 (also called as the OR gate)
%         Decission3 = The final classifcation decision is made on the basis of first modality
%         Decission4 = The final classifcation decision is made on the basis of second modality

function [Decission1,Decission2,Decission3,Decission4] = decissionmssvdd(predict_label1,predict_label2)

%Decission making (AND GATE)
Decission1=(predict_label1+predict_label2);
Decission1(Decission1==0) = -1;
Decission1(Decission1==2) = 1;
Decission1(Decission1==-2) = -1;

%Decission making (OR GATE)i call it decission 2
Decission2=(predict_label1+predict_label2);
Decission2(Decission2==0) = 1;
Decission2(Decission2==2) = 1;
Decission2(Decission2==-2) = -1;

%Decission based on predict_label1
Decission3=predict_label1;

%Decission based on predict_label2
Decission4=predict_label2;

end
