function f_DMP=DMP_theta_alt(X,phi,p,r,k,s,beta,alpha0,alpha1,theta)

w=X(1);
v=X(2);
u=v/theta;

M=alpha0*u^(alpha1)*v^(1-alpha1);
q=M/v;
f=theta*q;

f_DMP(1)=w-beta*(p+k*theta)+f*phi;  % altered equilibrium wage curve
f_DMP(2)=(p-w)/(r+s)-k/q;  % job creation condition