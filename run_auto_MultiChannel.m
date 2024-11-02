clear 
clc
rpm_set = [2000,2500,3000,3500,4000,4500,5000,5500,6000];
Frequency = 50000;
Duration = 100; % DAQ time in s
len = length(rpm_set);
num_ch = 2;
Betas(1) = 45;
Betas(2) = 135;
paths{1}=['result_baselineV8\Beta',num2str(Betas(1)),'\'];
paths{2}=['result_baselineV8\Beta',num2str(Betas(2)),'\'];
mkdir(paths{1});
mkdir(paths{2});
for i=1:len
 f = msgbox(['set rpm to ',num2str(rpm_set(i)),' and click OK']);
 uiwait(f); 
rpm = rpm_set(i);
disp(['start rpm:' ,num2str(rpm),',',num2str(i),'/',num2str(len)]);
[data,time] = Sound_DAQ_Ana(Frequency,Duration);
    for n = 1:num_ch
        path = paths{n};
        Beta = Betas(n);
        datas = data(:,n);
        filename = ['SoundMeasurement_rpm_',num2str(rpm),'_Beta',num2str(Beta)];
        save([path,filename],'Beta','Frequency','Duration','rpm','datas','time');
    end
disp(['finish rpm:' ,num2str(rpm),',',num2str(i),'/',num2str(len)]);
end
f=msgbox('Test completed');
uiwait(f);
close;