
function [Decission1,Decission2,Decission3,Decission4] = decissionmssvdd(predict_label1,predict_label2)

%Decission making (AND GATE)i call it decission 1
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