%% Sound Test
close all
clear
clc
Fs = 2^17;
dt = 1 / Fs;
T = 1;
t = 0 : dt : T; t(end) = [];
x = cos(2 * pi * 19950 * t);
playblocking(audioplayer(x, Fs));

%% C major
Fs = 2^13;
dt = 1 / Fs;
T = 0.4; %-- 0.4 [sec]
cMajor = [];
for n = [-9, -7, -5, -4, -2, 0, 2, 3, 2, 0, -2, -4, -5, -7, -9]
cMajor = [cMajor; MakeNote(n, T, dt)];
end
playblocking(audioplayer(cMajor, Fs));
%% section 3.2.2
Fs = 2^13;
dt = 2^-13;
T = 0.4;
Cb = 1;
RE = 5;
Mb = 6;
D = 3;
notes = [Cb, Cb, RE, RE, RE, RE, RE, RE, Mb, Cb, Cb, Cb, Cb, RE, RE, RE, RE, RE, RE, D, Cb, Cb, Cb, Cb, RE, RE, RE, RE, D, Cb, Cb, Cb, Cb, Cb];
times = [T, T, T, 2*T, T/2, T/2, T/2, T/2, T, T/2, T/2, T/2, T/2, T, 2*T, T/2, T/2, T/2, T/2, T/2, T/2, T/2, T/2, T, T, 2*T, T, T, T, T/2, T/2, T/2, T/2, T];
x = [];
for i = 1: length(notes)
    x = [x; MakeNote(notes(i), times(i), dt)];
end 
playblocking(audioplayer(x, Fs));
%% section 5

N = length(x);
t = (0 : (N - 1))' * dt;
M = 2000;
f = linspace(0, 1000, M)';
subplot(2,1,1)
plot(t,x)
title('x(t)')
legend('x(t)')
xlabel('t[sec]')

W = 2.*pi.*f;
Xf = FourierTransform(x, t, W);
subplot(2,1,2)
plot(f,abs(Xf), 'r')
title('x^F(w)')
legend('x^F(w)')
xlabel('f[Hz]');

%% section 7
figure; spectrogram(x, round(T * Fs), 0, 2^13, Fs, 'Yaxis'); ylim([0 0.6]);
%% section 8
load noise.mat %-- load noise (a row vector)
noise = noise(1:N); %-- noise -> column vector of length N
playblocking(audioplayer(noise, Fs));
%% section 9 
z = x + noise;
playblocking(audioplayer(z, Fs));
%% section 10
M = 2000;
w = 2 * pi * linspace(0, 1000, M)';
Zf = FourierTransform(z, t, w);
Xf = FourierTransform(x, t, w);
figure
subplot(2,1,1)
hold on
plot(w, abs(Zf))
title('|Zf|')
legend('|Zf|')
subplot(2,1,2)
hold on
plot(w, abs(Xf), 'r')
title('|Xf|')
legend('|Xf|')

%% section 11
t2 = (-2 : dt : 2)';
w1= 2700;
w2= 4100;
Sinc = @(t2) sinc(t2/pi);
h = (w2/pi)*Sinc(w2*t2)-(w1/pi)*Sinc(w1*t2);
Hf = FourierTransform(h, t2, w);
figure
subplot(3,1,1)
hold on
plot(w, abs(Zf))
title('|Zf|')
legend('|Zf|')
subplot(3,1,2)
hold on
plot(w, abs(Xf), 'r')
title('|Xf|')
legend('|Xf|')
subplot(3,1,3)
hold on
plot(w, abs(Hf), 'g')
title('|Hf|')
legend('|Hf|')
%% section 12
subplot(3,1,1)
hold on
plot(w, abs(Zf))
title('|Zf|')
legend('|Zf|')
subplot(3,1,2)
hold on
plot(w, abs(Xf), 'r')
title('|Xf|')
legend('|Xf|')
y = conv(z, h, 'Same') * dt;
Yf = FourierTransform(y, t, w);
subplot(3,1,3)
hold on
plot(w, abs(Yf),'m')
title('|Yf|')
legend('|Yf|')
%% section 13
playblocking(audioplayer(y, Fs));
%% section 3
function note = MakeNote(n, T, dt)
f0 = 440;
tau = 0.4;
t = 0 : dt : T; t(end) = [];
fn = f0*(2^(n/12));
note = (cos(2*pi*fn*t).*exp(-t/tau))';
end
%% functions
function Xf = FourierTransform(x, t, w)
dt = t(2)-t(1);
F = exp(1j*t*w');
Xf = (F'*x)*dt;
end
function x = InvFourierTransform(Xf, w, t)
x = FourierTransform(Xf, w, -t)/(2*pi);
end

