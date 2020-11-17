clear all;
close;
clc;

%% section 1
f0 = 100;
Fs = 2e3;
N = 1e3;
t = (0 : (N - 1))' / Fs;
x = cos(2*pi*f0*t);
th = pi * linspace(-1, 1, N + 1)';
th(end) = [];
w = th * Fs;
figure; hold on; grid on;
plot(t, x, 'LineWidth', 1);
xF = fftshift((fft(x))) / sqrt(N);
figure;
subplot(2,1,1); hold on; grid on; set(gca, 'FontSize', 16);
plot(th, abs(xF), 'g', 'LineWidth', 2);
title('$|X_s^f(\theta)|$', 'Interpreter', 'latex');
xlabel('$\theta$', 'Interpreter', 'latex');
subplot(2,1,2); hold on; grid on; set(gca, 'FontSize', 16);
plot(w, abs(xF), 'b', 'LineWidth', 2);
title('$|\tilde{X}_s^F(\omega)|$', 'Interpreter', 'latex');
xlabel('$\omega$', 'Interpreter', 'latex');

%% section 2
figure;
for ii = 1 : 9
Fs = 6250 - (ii-1) * 500;
Ts = 1 / Fs;
T = 1;
t = 0 : Ts : T; t(end) = [];
x = cos(2 * pi * 1800 * t);
N = length(x);
f = Fs / 2 * linspace(-1, 1, N + 1); f(end) = [];
Xf = fftshift((fft(x))) / sqrt(N);
subplot(3,3,ii); grid on; hold on; set(gca, 'FontSize', 14);
plot(f, abs(Xf), 'LineWidth', 2);
title(['$f_s = ', num2str(Fs), '$'], 'Interpreter', 'latex');
xlabel('$\omega$', 'Interpreter', 'latex');
ylabel('$X_{s}^{f}\left(\omega T_{s}\right)$', 'Interpreter', 'latex');
xlim([-3000, 3000]);
sPlay = audioplayer(x, Fs);
playblocking(sPlay)
end

