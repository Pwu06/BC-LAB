%BC Lab
close all
clear

%Parameter Initialisation
N0 = 1; %PSD of noise, average noise power
lamda = 0.2; %Lagrangian Multiplier
mu = 0.2; %Lagrangian Multiplier
h = [0.1+0.1i,0.2+0.8i,0.01+0.2i,0.1+0.9i,0.3+0.1i,0.1+0.7i,0.09+0.02i,0.1+0.8i,0.4+0.8i,0.1+0.3i]; % Filter taps
Nc = 10; % Number of complex channel filter tap

%Initialise the size of vectors
Pn = zeros(Nc,1); % Power allocation for each sub-channel
Pnoise = zeros(Nc,1); % Carrier noise 
water_level = zeros(Nc,1); % Water level, which is decided by lagarange multiplier
Waterlevel = zeros(1,Nc); 
option = 2;

for i = 1:Nc 
   [Pnoise(i),Pn(i),water_level(i)] = power_allocation(option,lamda,N0,h(i),mu);
end

figure;
bar(1:Nc,[Pnoise'; Pn'], 'stacked');
for i = 1:Nc
    Waterlevel(i) = line([0, Nc + 1], [water_level(i), water_level(i)],'Color',rand(1,3),'linestyle','--');
end
xlabel('Channel Index');
ylabel('Power (N0 / |hn|^2)');
ylim([0 2 * max(water_level)]) % Limit the y label value to zoom in the Pn
title(['Optimal Power allocation with lamda: ',num2str(lamda),', mu: ',num2str(mu)]);
% legend('Noise', 'Power','Water Level 1','Water Level 2','Water Level 3','Water Level 4','Water Level 5', ...
%     'Water Level 6','Water Level 7','Water Level 8','Water Level 9','Water Level 10')
legend('Noise', 'Power','Water Level')