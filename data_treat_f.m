function [f,spl,Ospl]=data_treat_f(datas,dur,Frequency,slope)
datas = datas(1:Frequency*100);
len = length(datas);
steps =len/Frequency/dur;
num_row = dur*Frequency;
 % duration of each step
data_cal = reshape(datas,num_row,steps);
P_step = zeros(num_row/2+1, steps);
for i = 1:steps
    dat = data_cal(:,i);
    [P1,f] = Sound_fft(dat,Frequency);
    P_step(:,i) = P_cal(P1,slope);
end
P_ave = mean(P_step,2);
spl = spl_air(P_ave);
Ospl = Ospl_air(P_ave(401:40001));% calculate overall spl from 100 Hz to 10000Hz
%plot(f,spl); 

% title('Single-Sided Amplitude Spectrum')
% xlabel('f (Hz)')
% ylabel('Sound Pressure Level (dB)')
% %axis([20,1e5,0,80])
% set(gca, 'XScale', 'log')