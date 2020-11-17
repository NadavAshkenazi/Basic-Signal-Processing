close all
clear
clc
%% section 1
dt = 0.005;
Ws = 2 * pi / dt;
T = 1.5;
t = (-T : dt : T)'; t(end) = [];
N = length(t);
w = Ws / 2 * linspace(-1, 1, N + 1)'; w(end) = [];
x = 3*cos(2*pi*2*t) + 3*sin(2*pi*8*t) + 2*cos(2*pi*11*t);
%% section 2
w1 = 2*2*pi;
w2 = 8*2*pi;
Wc = (w1+w2)/2;
A = Wc/pi;
Sinc = @(t) sinc(t/pi);
%% section 3
figure
h = A*Sinc(Wc*t);
Hf = FourierTransform(h, t, w);
Xf = FourierTransform(x, t, w);
Yf = Xf.*Hf;
y = InvFourierTransform(Yf,w,t);

subplot(3,2,1)
plot(t,x,'b')
title('x(t)')
legend('x(t)')
xlabel('t')
axis([-1.5 1.5 -10 10])

subplot(3,2,2)
stem(w,abs(Xf), 'b')
title('|X^F(w)|')
legend('|X^F(w)|')
xlabel('w')
axis([-200 200 0 6])

subplot(3,2,3)
plot(t,h, 'g')
title('h(t)')
legend('h(t)')
xlabel('t')
axis([-1.5 1.5 -10 10])

subplot(3,2,4)
plot(w,Hf, 'g')
title('H^F(w)')
legend('H^F(w)')
xlabel('w')
axis([-200 200 -2 2])

subplot(3,2,5)
plot(t,y, 'r')
title('y(t)')
legend('y(t)')
xlabel('t')
axis([-1.5 1.5 -10 10])

subplot(3,2,6)
stem(w,abs(Xf), 'b')
hold on
plot(w,Hf, 'g')
hold on
stem(w,Yf, 'r')
hold on
legend('|X^F(w)|', 'H^F(w)', 'Y^F(w)');
xlabel('w')
axis([-200 200 0 6])
%% section 5
x1 = sin(2*pi*5*t) + sin(2*pi*13*t);
x2 = sin(2*pi*5*t);
x3 = cos(2*pi*11*t) + exp((-8)*(t.^2));
x4 = exp(-8*(t.^2));

X1f = FourierTransform(x1, t, w);
X2f = FourierTransform(x2, t, w);
X3f = FourierTransform(x3, t, w);
X4f = FourierTransform(x4, t, w);

Wc = 50;
A = Wc/pi;

h = A*Sinc(Wc*t);
Hf = FourierTransform(h, t, w);

Y1f = X1f.*Hf;
Y2f = X2f.*Hf;
Y3f = X3f.*Hf;
Y4f = X4f.*Hf;

figure
subplot(2,2,1)
plot(w,abs(Y1f), 'b')
title('|X1^F*H^F|')
legend('|X1^F*H^F|')
xlabel('w')
axis ([-100 100 0 1])

subplot(2,2,2)
plot(w,abs(Y2f), 'r')
title('|X2^F*H^F|')
legend('|X2^F*H^F|')
xlabel('w')
axis ([-100 100 0 1])

subplot(2,2,3)
plot(w,abs(Y3f), 'g')
title('|X3^F*H^F|')
legend('|X3^F*H^F|')
xlabel('w')
axis ([-100 100 0 1])

subplot(2,2,4)
plot(w,abs(Y4f), 'm')
title('|X4^F*H^F|')
legend('|X4^F*H^f|)')
xlabel('w')
axis ([-100 100 0 1])



%% functions
function Xf = FourierTransform(x, t, w)
dt = t(2)-t(1);
F = exp(1j*t*w');
Xf = (F'*x)*dt;
end

function x = InvFourierTransform(Xf, w, t)
x = FourierTransform(Xf, w, -t)/(2*pi);
end

