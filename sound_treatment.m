[y,Fs] = audioread('caliberat_yeti.wav');
[P1,f]=Sound_fft(y,Fs);
P = P_cal(P1);
spl = spl_air(P);
plot(f,spl); 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
axis([0,1e5,0,100])
set(gca, 'XScale', 'log')