clear 
clc
rpm_set = [3000];
Beta = 90;
Frequency = 50000;
Duration = 200; % DAQ time in s
len = length(rpm_set);
for i=1:len
f = msgbox(['set rpm to ',num2str(rpm_set(i)),' and click OK']);
uiwait(f); 
rpm = rpm_set(i);
disp(['start rpm:' ,num2str(rpm),',Beta:',num2str(Beta),',',num2str(i),'/',num2str(len)]);
[datas,time] = Sound_DAQ_Ana(Frequency,Duration);
%[datas,time] = Sound_DAQ_Dig(Frequency,Duration);
path = 'result_maple\Mic_M31_160964\Beta90';
filename = ['SoundMeasurement_rpm_',num2str(rpm),'_Beta',num2str(Beta)];
save([path,filename],'Beta','Frequency','Duration','rpm','datas','time');
disp(['finish rpm:' ,num2str(rpm),',',num2str(i),'/',num2str(len)]);
end
    msgbox('Test completed');