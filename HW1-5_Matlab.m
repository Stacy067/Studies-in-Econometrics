clc;

clear;

load cps09mar.txt;
data = cps09mar;

% Restrict sample to white male hispanics.
restriction = (data(:,11)==1)&(data(:,2)==0)&(data(:,3)==1);
sample = data(restriction,:);
n = size(sample,1);

% Generate variables of interest
experience = sample(:,1) - sample(:,4) - 6;
education = sample(:,4);
earnings = sample(:,5);
hours = sample(:,6);
week = sample(:,7);
wage = earnings./(hours.*week); 
logwage = log(wage);  
experience_squared = (experience.^2)./100;   
constant = ones(n,1);

% Generate binary variables

% Regions
northeast = (sample(:,10)==1);
south = (sample(:,10)==3);
west = (sample(:,10)==4);

% Marital Status
married = (sample(:,12)<=3);
widowed = (sample(:,12)==4);
divorced = (sample(:,12)==5);
separated = (sample(:,12)==6);

display('3.21')
display(' ')

X = [education, experience, experience_squared, northeast, south, west, married, widowed, divorced, separated, constant];
k = size(X,2);
XX = (X'*X)\eye(k);
y = logwage;

beta_hat = XX*(X'*y);

Coefficients = table(beta_hat);
Coefficients.Properties.RowNames = {'education','experience','experience_squared','northeast', 'south', 'west', 'married', 'widowed', 'divorced', 'separated', 'constant'};
Coefficients
