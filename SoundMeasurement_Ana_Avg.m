%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Ni USB-6009 data acquisition %%%%%%%%
%%%%%%%%%%%%%%% For Sound Measurement %%%%%%%%%%%
%%%%%%%%%%%%%%%% coded by Nianhong %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc
Frequency=50000;
slope = 0.045;% sensitivity of mic
rpm=3000;
Beta=0;
steps = 20;% run times for average
s = daq.createSession('ni');
devices = daq.getDevices;
s.Rate =Frequency;
ch(1) = addAnalogInputChannel(s, 'cDAQ2Mod1', 'ai0','Voltage');%Fx
s.DurationInSeconds=10;
length = Frequency * s.DurationInSeconds;
lh = addlistener(s,'DataAvailable', @(src,event) plot(event.TimeStamps, event.Data));
DATA = zeros(length,steps);
P_data = zeros(length/2+1, steps);
for i =1:steps
disp(['step:' ,num2str(i),'/',num2str(steps)]);
[datas,time] = startForeground(s);
DATA(:,i)=datas;
s.wait();
release(s);
%%%%%%%%%%%%%%%%%%%% fft %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%datas=WienerScalart96(datas,Frequency,0.7);
[P1,f]=Sound_fft(datas,Frequency);
P_data(:,i) = P_cal(P1);
end
delete(lh);
release(s);
P = mean(P_data,2);
spl = spl_air(P);
plot(f,spl); 
title(['Single-Sided Amplitude Spectrum of SPL(f)_RPM_',num2str(rpm)],'Interpreter','none');
xlabel('f (Hz)')
ylabel('Sound Pressure Level (dB)')
axis([0,1e5,0,100])
set(gca, 'XScale', 'log')
path = 'result_9443_plastic\Mic_17344\';
filename = [path 'SoundMeasurement_3_rpm_',num2str(rpm),'_Beta',num2str(Beta)];
save(filename);
%audiowrite([filename,'.wav'],datas,Frequency);
%saveas(1, filename, 'jpg')




