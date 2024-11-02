load_path = 'result_baselineV8\Beta0\';
%load_path = 'result_swept30_V8_2\Beta135\';
load_filename = 'SoundMeasurement_rpm_4500_Beta0.mat';
load([load_path,load_filename]);

% [file,path] = uigetfile('*.mat');
% if isequal(file,0)
%    disp('User selected Cancel');
% else
%    disp(['User selected ', fullfile(path,file)]);
% end
% load([path,file]);
datas = datas(1:Frequency*100);
len = length(datas);
dur = 4;% duration of each step
slope = 0.045;
steps =len/Frequency/dur;
num_row = dur*Frequency;
 

data_cal = reshape(datas,num_row,steps);
P_step = zeros(num_row/2+1, steps);
p_BB_setp = zeros(num_row/2+1, steps);
p_t_setp = zeros(num_row/2+1, steps);
medFilt = dsp.MedianFilter('WindowLength',2);
for i = 1:steps
    dat = data_cal(:,i);
    [P1,f] = Sound_fft(dat,Frequency);
    P_BB = medfilt1(P1,500);% broad band noise
    p_t = P1 - P_BB;% tonal noise
    P_step(:,i) = P_cal(P1,slope);
end
P_ave = mean(P_step,2);
P_BB = medfilt1(P_ave,500); % broad band noise
spl = spl_air(P_ave);
spl_BB = spl_air(P_BB);
Ospl = Ospl_air(P_ave);
Ospl_BB = Ospl_air(P_BB);
bpf = f/(2*rpm/60);
plot(bpf,spl); 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('Sound Pressure Level (dB)')
hold on
plot(bpf,spl_BB);
%plot(bpf,spl_T);
axis([2,200,-20,80])
%axis([20,1e5,0,80])
set(gca, 'XScale', 'log')