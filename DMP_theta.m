function f_DMP=DMP_theta(X,b,p,r,k,s,beta,alpha0,alpha1,theta)

w=X(1);
v=X(2);
u=v/theta;

M=alpha0*u^(alpha1)*v^(1-alpha1);
q=M/v;


f_DMP(1)=w-b-beta*(p-b)-beta*k*theta;  % initial equilibrium wage curve
f_DMP(2)=(p-w)/(r+s)-k/q;  % job creation condition
