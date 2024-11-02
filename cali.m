clear 
clc
% rpm = 8000;
% Beta = 0;
pause(0)
Frequency = 50000;
steps = 5;
slope = 0.045;
Duration =20; % DAQ time in s
[datas,time] = Sound_DAQ_Ana(Frequency,Duration);
%[datas,time] = Sound_DAQ_Dig(Frequency,Duration);
path = 'Calibrition\';
%filename = ['SoundMeasurement_rpm_',num2str(rpm),'_Beta',num2str(Beta)];
[f,spl]=data_treat_f(datas,steps,Frequency,slope);
set(gca, 'XScale', 'log')
%filename = 'SoundCalibrition_17344_20191107';
filename = 'SoundCalibrition_24925_20191107';
save([path,filename]);
% disp(['finish rpm:' ,num2str(rpm)]);
% msgbox(['rpm Done: ',num2str(rpm)],'Message');
