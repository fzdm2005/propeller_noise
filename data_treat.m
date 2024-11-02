%load_path = 'result_baselineV8\Beta135\';
% %load_path = 'result_swept30_V8_2\Beta135\';
% load_filename = 'SoundMeasurement_rpm_4500_Beta135.mat';
% load([load_path,load_filename]);

[file,path] = uigetfile('*.mat');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
end
load([path,file]);
datas = datas(1:Frequency*100);
len = length(datas);
dur = 4;% duration of each step
slope = 0.045;
steps =len/Frequency/dur;
num_row = dur*Frequency;
 

data_cal = reshape(datas,num_row,steps);
P_step = zeros(num_row/2+1, steps);
for i = 1:steps
    dat = data_cal(:,i);
    [P1,f] = Sound_fft(dat,Frequency);
    P_step(:,i) = P_cal(P1,slope);
end
P_ave = mean(P_step,2);
spl = spl_air(P_ave);
Ospl = Ospl_air(P_ave);
bpf = f/(2*rpm/60);
plot(bpf,spl); 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('Sound Pressure Level (dB)')
hold on
axis([2,200,-20,80])
%axis([20,1e5,0,80])
set(gca, 'XScale', 'log')