%This fucntion is for initializing the projection matrix Q for "Multimodal subspace support vector data description"
% Input: D = Original dimensinality of the data
%        d = dimensinality of the data in lower d-dimensional subspace
% Output:Q = initialized Projection matrix

function Q = initialize_Q(D,d)

% rng(1234)
%%%% Projection Matrix
Q=randn(d,D); %19200);
[Q_Pos R]=qr(Q',0); % create an orthogonal matrix Q for witch it holds Q*Q'=I but not Q'*Q=I
Q=Q_Pos';
%Q_init=Q;
clear Q_Pos;
clear R;
A=sqrt(sum(Q'.^2));
for i=1:length(A)
    Q(i,:)=Q(i,:)/A(i);
end
