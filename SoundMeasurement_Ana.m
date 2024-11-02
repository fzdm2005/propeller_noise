%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Ni USB-6009 data acquisition %%%%%%%%
%%%%%%%%%%%%%%% For Sound Measurement %%%%%%%%%%%
%%%%%%%%%%%%%%%% coded by Nianhong %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc
Frequency=50000;
rpm=8000;
Beta = 0;
s = daq.createSession('ni');
devices = daq.getDevices;
s.Rate =Frequency;
ch(1) = addAnalogInputChannel(s, 'cDAQ2Mod1', 'ai0','Voltage');%Fx
%ch(1).Range=[-10,10];
% ch(2).Range=[-10,10];
% ch(3).Range=[-10,10];
% ch(7).Range=[-10,10];
% ch(1).TerminalConfig = 'SingleEnded';
% ch(2).TerminalConfig = 'SingleEnded';
% ch(3).TerminalConfig = 'SingleEnded';
s.DurationInSeconds=20;
lh = addlistener(s,'DataAvailable', @(src,event) plot(event.TimeStamps, event.Data));
%s.NotifyWhenDataAvailableExceeds = 1000;
[datas,time] = startForeground(s);
s.wait()
delete(lh);
% result=[time,datas];
% filename=['Data_record\SoundMeasurement',datestr(now, 'mm-dd-HH-MM')];
% xlswrite(filename,result);

release(s);


% P = P_cal(datas);
% spl = spl_air(P);

%%%%%%%%%%%%%%%%%%%% fft %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%datas=WienerScalart96(datas,Frequency,0.7);
[P1,f]=Sound_fft(datas,Frequency);
P = P_cal(P1);
spl = spl_air(P);
plot(f,spl); 
title(['Single-Sided Amplitude Spectrum of SPL(f)_RPM_',num2str(rpm)],'Interpreter','none');
xlabel('f (Hz)')
ylabel('Sound Pressure Level (dB)')
axis([0,1e5,0,100])
set(gca, 'XScale', 'log')
filename = ['SoundMeasurement_rpm_',num2str(rpm),'_Beta',num2str(Beta)];
audiowrite([filename,'.wav'],datas,Frequency);
%save(filename);
%saveas(1, filename, 'jpg')




