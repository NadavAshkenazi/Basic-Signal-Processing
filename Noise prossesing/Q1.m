close all
clear
clc
dt = 0.005;
Ws = 2 * pi / dt;
T = 1.5;
t = (-T : dt : T)'; t(end) = [];
N = length(t);
w = Ws / 2 * linspace(-1, 1, N + 1)'; w(end) = [];
%% Random Test:
x = randn(N, 1) + 1j * randn(N, 1);
Xf = FourierTransform(x, t, w);
norm(x - InvFourierTransform(Xf, w, t));

%% secttion 1.4.2
x = 5*cos(2*pi*4*t) + 2*sin(2*pi*9*t) + 4;
subplot(3,1,1), plot(t,x,'linewidth', 2),title('x(t)'),legend('x(t)')
Xf = FourierTransform(x, t, w);
    
subplot(3,1,2),stem(w,abs(Xf), 'r'),title('|X^F(w)|'), legend('|X^F(w)|')
subplot(3,1,3), plot(t,x, '-b','linewidth', 2)
hold on
plot(t,InvFourierTransform(Xf, w, t), ':g','linewidth', 2)
legend('x(t)','xtag(t)')

%% section 1.3
function Xf = FourierTransform(x, t, w)
dt = t(2)-t(1);
F = exp(1j*t*w');
Xf = (F'*x)*dt;
end
%% section 1.3.2
function x = InvFourierTransform(Xf, w, t)
x = FourierTransform(Xf, w, -t)/(2*pi);
end
