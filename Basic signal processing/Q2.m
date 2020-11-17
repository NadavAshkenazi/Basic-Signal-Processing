close all;
clear;
clc;

%% section 2.1
N = 1200;
t = linspace(0, 12, N+1); t(end) = [];

x = (1/4)*cos(2*pi*5*t) + 2*sin(2*pi*0.5*t);

y = ThresholdSystem(x);
figure; hold on; grid on;
plot(t, x, 'b', 'LineWidth', 2)
plot(t, y, ':r', 'LineWidth', 2)
legend('x(t)', 'y(t)');
xlabel('Time');
ylabel('Value');
title('Threshold System.');



%% section 2.2

x = sin(2*pi*0.2*t) + randn(1,N)/10;
figure; hold on; grid on;
plot(t, x, 'b', 'LineWidth', 2)
legend('x(t)');
xlabel('Time');
ylabel('Value');
title('x(t)');

[y, ty] = MovingAverage(x, t);
figure; hold on; grid on;
plot(t, x, 'b', 'LineWidth', 1)
plot(ty, y, 'r', 'LineWidth', 2)
legend('x(t)', 'y(t)');
xlabel('Time');
ylabel('Value');
title('Moving average System.');






%% functions
function y = ThresholdSystem(x)

    y = x;
    y(x<-1.25) = -1.25;
    y(x>1.25) = 1.25;    
  
end

function [y, t2] = MovingAverage(x, t)
%-- Input: 1. x - input vector.
%-- 2. t - time vector.
%-- Output: 1. y - output vector s.t. y = Psi{x}.
%-- 2. t - valid output time vector.
Ts = t(2) - t(1);
Fs = round(1 / Ts);
X = cumsum(x) * Ts;
X1 = X(2*Fs+1 : end); 
X2 = X(1 : end-2*Fs);
t2 = t(Fs+1 : end-Fs);
y = 0.5*(X1 - X2);
end





