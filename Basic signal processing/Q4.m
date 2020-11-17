close all;
clear;
clc;

%% section 4.3

N = 10000;
t = linspace(-pi, pi, N + 1)'; t(end) = [];
x = -t;

figure; hold on; grid on;
plot(t, x, 'b', 'LineWidth', 2)
legend('x(t)');
xlabel('Time');
ylabel('Value');
title(' x = -t');

%% section 4.5

M = 1;
k = -M : M;
T0 =2*pi;
om0 = 2*pi/T0;
F = exp(1j * om0 * t * k);
G = F'*x / N

%% section 4.6

figure; hold on; grid on;
plot(t, x, 'b', 'LineWidth', 2)
plot(t, F*G, 'r', 'LineWIdth', 2)
legend('x(t)', 'fourier signal');
xlabel('Time');
ylabel('Value');

%% section 4.7
N=10000;
t = linspace(-3*pi, 3*pi, N + 1)'; t(end) = [];
x = -t;
X=pi*sawtooth(-pi+x);

M=1;
om0=1;
k = -M:M;
F = exp(1j*om0*t*k);
A = (F'*x)/N;
G1=F*A;

M=5;
om0=1;
k = -M:M;
F = exp(1j*om0*t*k);
A = (F'*x)/N;
G2=F*A;

M=25;
om0=1;
k = -M:M;
F = exp(1j*om0*t*k);
A = (F'*x)/N;
G3=F*A;

figure; hold on; grid on;
plot(t, X, ':k', 'LineWidth', 2)
plot(t, G1, 'b', 'LineWidth', 1)
plot(t, G2, 'r', 'LineWidth', 1)
plot(t, G3, 'y', 'LineWidth', 1)
legend('x(t)','1','5','25');
title('signals with changing M');
xlabel('t');

%% section 4.8

N=10000;
t= linspace (-pi, pi, N+1)';
t(end)=[];
x=-t;

for M=1:1:100
    om0=1;
    k = -M:M;
    F = exp(1j*om0*t*k);
    A = (F'*x)/N;
    G=F*A;
    err(M)=norm(x-G);
    
end
M=1:1:100;
figure; hold on; grid on;
plot(M, err(M), 'c', 'LineWidth', 2)
legend('err');

title('norm calculation');
xlabel('M');


