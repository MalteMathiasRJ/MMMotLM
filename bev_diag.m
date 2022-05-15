clear all
%% Beveridge curve with initial model (unemployment benefits)
% Parameter values:
b = 0.25;        % unemployment benefits relative to wages
p = 1;           % productivity
r = 0.0025;      % interest rate
k = 0.2;         % vacancy Cost
s = 0.5;         % job destruction rate
beta = 0.5;      % worker bargaining power 
alpha0 = 0.55;   % level in matching function 
alpha1 = 0.5;    % elasticity of the matching function

Options=optimset('Display','off','TolFun',1e-20,'TolX',1e-20,'MaxIter',200000,'MaxFunEvals',200000); % define options

u_space = linspace(0,1); % unemployment rate ranges from 0 to 1

for i = 1:100

    u = u_space(i);

X00 = [0.1,0.5,0.5]; % initial w, v and u values for fsolve
X = fsolve(@DMP_bev,X00,Options,b,p,r,k,s,beta,alpha0,alpha1); %fsolve function

w = X(1);
v = X(2);

    theta = 1.5069; % this theta value is obtained from the equilibrium from the other model!
    M = alpha0*u^(alpha1)*v^(1-alpha1);   % matching function
    q = M/v;                              % job filling rate
    f = theta*q;                          % job finding rate
    w = b+beta*(p+k*theta-b);             % equilibrium wage equation

    bc = s/(f+s);                         % Beveridge curve equation
    jc = theta*u;                         % job creation curve

u = v/theta; 

    bc_space(i)=bc; % defines the Beveridge curve as u changes
    jc_space(i)=jc; % defines the job creation curve as u changes

end

figure(3)
plot(u_space, bc_space,...
    'LineWidth',2,...
    'color',[0 0 1]); hold on, 
plot(u_space,jc_space,...
    'LineWidth',2,...
    'color',[0.9 0.2 .4])
ylabel('v')
xlabel('u')
xlim([0,1]),  ylim([0,1])
legend('Beveridge Curve','Job Creation Curve')

hold on


%% Beveridge curve with altered equations (universal basic income)
% Parameter values, now with phi:
phi = 0.35 ;     % 'full basic income' relative to wages
p = 1;           % productivity
r = 0.0025;      % interest rate
k = 0.2;         % vacancy Cost
s = 0.5;         % job destruction rate
beta = 0.5;      % worker bargaining power 
alpha0 = 0.55;   % level in matching function 
alpha1 = 0.5;    % elasticity of the matching function

Options=optimset('Display','off','TolFun',1e-20,'TolX',1e-20,'MaxIter',200000,'MaxFunEvals',200000); % define options

u_space = linspace(0,1); % unemployment rate ranges from 0 to 1

for i = 1:100

    u = u_space(i);
    
X00 = [0.1,0.5,0.5]; % initial w, v and u values for fsolve
X = fsolve(@DMP_bev_alt,X00,Options,phi,p,r,k,s,beta,alpha0,alpha1); %fsolve function

w = X(1);
v = X(2);

    theta = 5.2233; % this theta value is obtained from the equilibrium from the other model!
    M = alpha0*u^(alpha1)*v^(1-alpha1);   % matching function
    q = M/v;                              % job filling rate
    f = theta*q;                          % job finding rate
    w = beta*(p+k*theta)-f*phi;           % equilibrium wage equation

    bc = s/(f+s);                         % Beveridge curve equation
    jc = theta*u;                         % job creation curve

u = v/theta; 

    bc_space(i)=bc; % defines the Beveridge curve as u changes
    jc_space(i)=jc; % defines the job creation curve as u changes

end

figure(4)
plot(u_space,bc_space,...
    'LineWidth',2,...
    'color',[0 0 1]); hold on, 
plot(u_space,jc_space,...
    'LineWidth',2,...
    'color',[0.9 0.2 .4])
ylabel('v')
xlabel('u')
xlim([0,0.5]),  ylim([0,1])
legend('Beveridge Curve','Job Creation Curve')

hold on

