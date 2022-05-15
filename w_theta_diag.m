clear all
%%
%initial parameter values
b = 0.4;        % unemployment benefits relative to wages
phi = 0.6;      % 'full basic income' relative to wages
p = 1;           % productivity
r = 0.0025;      % interest rate
k = 0.2;         % vacancy Cost
s = 0.3;         % job destruction rate
beta = 0.5;      % worker bargaining power 
alpha0 = 0.3;   % level in matching function 
alpha1 = 0.5;    % elasticity of the matching function 

Options=optimset('Display','off','TolFun',1e-20,'TolX',1e-20,'MaxIter',200000,'MaxFunEvals',200000);

%%
% comparative statics
% initial equilibrium

theta_space=linspace(0,3); % range of theta

w_space=zeros(1,100); 
wage_space=zeros(1,100);

for i = 1:100
    
    theta = theta_space(i);
    
    wage = b+beta*(p-b)+beta*k*theta; % wage at each point of theta
    wage_space(i) = wage;
    
    X00 =[0.8,0.5]; % initial w and v values for fsolve
    X=fsolve(@DMP_theta,X00,Options,b,p,r,k,s,beta,alpha0,alpha1,theta); %fsolve function

    w=X(1);
    v=X(2);
    u=v/theta;

    w_space(i)=w;
    v_space(i)=v;

end
    
figure(1)
plot(theta_space,wage_space,...
    'LineWidth',2,...
    'color',[0 0 1]); hold on, 
plot(theta_space,w_space,...
    'LineWidth',2,...
    'color',[0.9 0.2 .4])
ylabel('Wages')
xlabel('Market Tightness')
ylim([0.65,1])
legend('Wage Curve','Job Creation')

hold on

% equilibrium theta = 0.9917

%%
% comparative statics

clear X00 X

theta_space=linspace(0.0001,8); % range of theta

w_space=zeros(1,100); 
wage_space=zeros(1,100);

for i = 1:100
    
    theta = theta_space(i);
    
    X00 =[0.8,0.5]; % initial w and v values for fsolve
    X=fsolve(@DMP_theta_alt,X00,Options,phi,p,r,k,s,beta,alpha0,alpha1,theta); %fsolve function

    w=X(1);
    v=X(2);
    u=v/theta;

    M=alpha0*u^(alpha1)*v^(1-alpha1);   % matching function
    q=M/v;                              % job filling rate
    f=theta*q;                          % job finding rate

    wage = beta*(p+k*theta)-f*phi;      % wage at each point of theta
    wage_space(i) = wage;

    w_space(i)=w;

end
    
figure(3)
plot(theta_space,wage_space,...
    'LineWidth',2,...
    'color',[0 0 1]); hold on, 
plot(theta_space,w_space,...
    'LineWidth',2,...
    'color',[0.9 0.2 .4])
ylabel('Wages')
xlabel('Market Tightness')
xlim([0,8]), ylim([0.3,1])
legend('Wage Curve','Job Creation')

hold on

% equilibrium theta = 4.5384
