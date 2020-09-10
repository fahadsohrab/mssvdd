% This fucntion Orthogonalize and normalize the projection matrix Q
% Input:  Q = The projection matrix
% Output: Q = Orthogonalize and normalize the projection matrix Q

function Q = OandN_Q(Q)
%%% Orthogonalize Q
[tmpQ, ~]=qr(Q',0);  Q = tmpQ';
clear tmpQ;          clear R;

%%% Normalize each projection vector
tmpNorm = sqrt(diag(Q*Q'));
Q = Q./(repmat(tmpNorm',size(Q,2),1)');

end
