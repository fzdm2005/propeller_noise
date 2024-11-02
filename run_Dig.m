clear 
clc
rpm = 3000;
Beta = 0;
Frequency = 48000;
Duration =200; % DAQ time in s
datas= Sound_DAQ_Dig(Frequency,Duration);
path = 'result_9443_carbon\Mic_Yeti\';
filename = ['SoundMeasurement_rpm_',num2str(rpm),'_Beta',num2str(Beta)];
save([path,filename]);
disp(['finish rpm:' ,num2str(rpm)]);
msgbox(['rpm Done: ',num2str(rpm)],'Message');
