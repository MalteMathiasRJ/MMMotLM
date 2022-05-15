function f_DMP = DMP_bev(X,b,p,r,k,s,beta,alpha0,alpha1)

w = X(1);
u = X(2);
v = X(3);

theta=v/u;                          % market tightness
M=alpha0*u^(alpha1)*v^(1-alpha1);   % match function
q=M/v;                              % job filling rate
f=theta*q;                          % job finding rate

f_DMP(1) = u-s/(f+s);               % Beveridge curve
f_DMP(2) = (p-w)/(r+s)-k/q;         % job creation
f_DMP(3) = w-b-beta*(p-b)-beta*p*k*theta; %wage curve

end