%BC Lab
close all
clear

%Parameter Initialisation
N0 = 1; %PSD of noise, average noise power
lamda = 0.2; %Lagrangian Multiplier
upart = 0:0.01:0.24;
lpart = 0.26:0.01:0.5;
mu = [upart lpart];
% mu = 0:0.01:0.4; %Lagrangian Multiplier
h = [0.1+0.1i,0.2+0.8i,0.01+0.2i,0.1+0.9i,0.3+0.1i,0.1+0.7i,0.09+0.02i,0.1+0.8i,0.4+0.8i,0.1+0.3i]; % Filter taps
gain = abs(h).^2; %The fading coefficient of each filter taps
Nc = 10; % Number of complex channel filter tap

%Initialise the size of vectors
Len = length(mu); %Calculate the length of mu
Pn = zeros(Nc,Len); % Power allocation for each sub-channel
Pnoise = zeros(Nc,1); % Carrier noise
water_level = zeros(Nc,Len); % Water level, which is decided by lagarange multiplier
Total_PTx = zeros(Len,1); %Total power at the transmitter
Total_PRx = zeros(Len,1); %Total power at the Receiver
option = 2;

for i = 1:Len
    %Calculate the Pnoise, Pn, waterlevel with given lamda and mu
    for j = 1:Nc 
        [Pnoise(j),Pn(j,i),water_level(j,i)] = power_allocation(option,lamda,N0,h(j),mu(i));
    end

    %Calculate the total power
    PowerRx = gain.' .* Pn(:,i);
    Total_PTx(i) = sum(Pn(:,i));
    Total_PRx(i) = sum(PowerRx);
end
PT = Total_PRx./Total_PTx;

%Generate the power allocation plot
figure;
plot(mu,PT)
xlabel('Mu');
ylabel('Power Rx / Power Tx');
title('Power Efficiency');

% Find the upper bond of mu
% Reset the mu's value to 0.01, increase its value by iteration until the
% total allocated power is equal to 0.
mu_max = 0.01;
while sum(Pn)>0
    for i = 1:Nc 
        [Pnoise(i),Pn(i),~] = power_allocation(option,lamda,N0,h(i),mu_max);
    end
    mu_max = mu_max + 0.01;
end
mu_max = mu_max - 0.01;