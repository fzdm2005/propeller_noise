
Fs = 50000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 10000000;             % Length of signal
t = (0:L-1)*T;        % Time vector
S = datas';
X = S;
winvec = hanning(length(X));
X1 = X'.*winvec;
Y = fft(X);
Y2 = fft(X1);
P2_1 = abs(Y/L);
P1_1 = P2_1(1:L/2+1);
P1_1(2:end-1) = 2*P1_1(2:end-1);
f1 = Fs*(0:(L/2))/L;
plot(f1,P1_1)
hold on

P2_2 = abs(Y2/L);
P1_2 = P2_2(1:L/2+1);
P1_2(2:end-1) = 2*P1_2(2:end-1);
f2 = Fs*(0:(L/2))/L;
plot(f2,2*P1_2)
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')