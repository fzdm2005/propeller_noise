clear 
clc
% rpm = 8000;
% Beta = 0;
pause(3)
Frequency = 50000;
Duration =20; % DAQ time in s
[datas,time] = Sound_DAQ_Ana(Frequency,Duration);
path = 'Calibrition\';
%filename = ['SoundMeasurement_rpm_',num2str(rpm),'_Beta',num2str(Beta)];
filename = 'SoundCalibrition_M31_160964';
save([path,filename]);
% disp(['finish rpm:' ,num2str(rpm)]);
% msgbox(['rpm Done: ',num2str(rpm)],'Message');
