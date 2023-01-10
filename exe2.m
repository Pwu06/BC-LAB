%BC Lab
close all
clear

%Parameter Initialisation
N0 = 1; %PSD of noise, average noise power
lamda = 0.28; %Lagrangian Multiplier
mu = 0; %here mu is not required, mu is intialised to zero
h = [0.1+0.1i,0.2+0.8i,0.01+0.2i,0.1+0.9i,0.3+0.1i,0.1+0.7i,0.09+0.02i,0.1+0.8i,0.4+0.8i,0.1+0.3i]; % Filter taps
Nc = 10; % Number of complex channel filter tap

%Initialise the size of vectors
Pn = zeros(Nc,1); % Power allocation for each sub-channel
Pnoise = zeros(Nc,1); % Carrier noise 
water_level = zeros(Nc,1); % Water level, which is decided by lagarange multiplier
option = 1;

for j = 1:Nc 
   [Pnoise(j),Pn(j),water_level(j)] = power_allocation(option,lamda,N0,h(j),mu);
end

figure;
bar(1:Nc,[Pnoise'; Pn'], 'stacked');
line([0, Nc + 1], [water_level, water_level],'Color','Red','linestyle','--');
xlabel('Channel Index');
ylabel('Power (N0 / |hn|^2)');
ylim([0 2 * water_level(1)]) % Limit the y label value to zoom in the Pn
title(['Optimal Power allocation with lamda: ',num2str(lamda)]);
legend('Noise', 'Power', 'Water Level')