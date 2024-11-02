function rst=soundAna(datas,dur,Frequency,slope,fRange,window)
% soundAna(datas,dur,Frequency,slope,window,fRange)
% datas - data vector for fft
% dur - duration for each data section
% Frequency  - sample rate
% slope - sensitivity of microphone
% window - window size of medfilter
% fRange - range of frequency
if nargin <= 5
    window = 500;
end
    
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
if nargin > 4
  indx = find(f>=fRange(1)&f<=fRange(2));
  f = f(indx);
  P_ave = P_ave(indx);
end
P_BB = medfilt1(P_ave,window); % broad band noise
P_hm =sqrt(P_ave.^2 - P_BB.^2);
rst.P_ave = P_ave;
rst.P_BB = P_BB;
rst.P_hm = P_hm;
rst.spl = spl_air(P_ave);
rst.Ospl = Ospl_air_3(P_ave,f);
rst.f = f;
rst.spl_BB = spl_air(P_BB);
rst.Ospl_BB = Ospl_air_3(P_BB,f);
rst.spl_hm = spl_air(P_hm);
rst.Ospl_hm = Ospl_air_3(P_hm,f);



%plot(f,spl); 

% title('Single-Sided Amplitude Spectrum')
% xlabel('f (Hz)')
% ylabel('Sound Pressure Level (dB)')
% %axis([20,1e5,0,80])
% set(gca, 'XScale', 'log')