function [P_noise,alloc_power,water_level] = power_allocation(option,lamda,N0,h,mu)
% Calculate water filling solution for the optimal power allocation using
% KKT condition
   P_noise = N0./(abs(h)).^2; % Carrier noise power
   switch option
          case 1
                water_level = 1/lamda;
                water_level(water_level<0) = 0;
                alloc_power = water_level - P_noise;
                alloc_power(alloc_power<0) = 0;
          case 2
                water_level = 1/(lamda - mu*(round((abs(h).^2),5)));
                water_level(water_level<0) = 0;
                alloc_power = water_level - P_noise;
                alloc_power(alloc_power<0) = 0;
   end   
end