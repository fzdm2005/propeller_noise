Frequency = 10000;                    % Sampling frequency
T = 1/Frequency;                     % Sampling period
L = 1000;                     % Length of signal
t = (0:L-1)*T; 
datas = cos(2*pi*39*t); 
Y=fft(datas);
L=length(datas);
T=1/Frequency;
P2=abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Frequency*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
set(gca, 'XScale', 'log')