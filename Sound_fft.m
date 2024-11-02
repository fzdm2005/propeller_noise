function [P1,f] = Sound_fft(datas,Frequency)
Y=fft(datas);
L=length(datas);
T=1/Frequency;
P2=abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Frequency*(0:(L/2))/L;
