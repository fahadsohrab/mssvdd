% Orthogonalize and normalize the matrix
function Q = OandN_Q(Q)
% % % Orthogonalize Q
[tmpQ, R]=qr(Q',0);  Q = tmpQ';
clear tmpQ;          clear R;

%%% Normalize each projection vector
tmpNorm = sqrt(diag(Q*Q'));
Q = Q./(repmat(tmpNorm',size(Q,2),1)');

end