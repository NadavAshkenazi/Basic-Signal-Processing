close all;
clear;
clc;

%% section 3.2

N = 1000;
t = linspace(-1.5, 1.5, N + 1)'; t(end) = [];

x1 = sin(2*pi * 1/3 * t);
x2 = sin(2*pi * 2/3 * t);
x3 = sin(2*pi * 1/2 * t);
x4 = sin(2*pi * 4/3 * t);


figure; hold on; grid on;
plot(t, x1, 'b', 'LineWidth', 2)
plot(t, x2, 'r', 'LineWidth', 2)
plot(t, x3, 'g', 'LineWidth', 2)
plot(t, x4, 'm', 'LineWidth', 2)
legend('x1', 'x2','x3','x4');
xlabel('Time');
ylabel('Value');

T0= 3;

X = [x1, x2, x3, x4];
G = X' * X / N

%% section 3.3

A1 = 2;
A2 = 4;
A3 = 9;

x = A1*sin(2*pi*3*t) + A2*cos(2*pi*2*t) + A3*sin(2*pi*t);

s1 = 2 * sin(2*pi * 1 * t);
s2 = 2 * sin(2*pi * 2 * t);
s3 = 2 * sin(2*pi * 3 * t);
c1 = 2 * cos(2*pi * 1 * t);
c2 = 2 * cos(2*pi * 2 * t);
c3 = 2 * cos(2*pi * 3 * t);

Base = [s1, s2, s3, c1, c2, c3];

G = (Base'*x) / N




