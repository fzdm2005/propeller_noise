clear
Frequency=48000; %sample Fs
Duration = 5;% time in s
rpm='ccccc';
Beta = 0;
Bits = 8;
recObj = audiorecorder(Frequency,Bits,1);
pause(0);
steps = 1;
for i = 1:steps
disp(['step:' ,num2str(i),'/',num2str(steps)]);
disp('Start speaking.')
recordblocking(recObj,Duration);
disp('End of Recording.');
% 回放录音数据
%play(recObj);
% 获取录音数据
datas = getaudiodata(recObj);
[P1,f]=Sound_fft(datas,Frequency);
P_data(:,i) = P_cal(P1);
end
P = mean(P_data,2);
plot_fft;
title(['Single-Sided Amplitude Spectrum of SPL(f)_RPM_',num2str(rpm)],'Interpreter','none');
xlabel('f (Hz)')
ylabel('|P1(f)|')
axis([0,1e5,0,100])
set(gca, 'XScale', 'log')
path = 'Dig\';
filename = [path 'SoundMeasurement_Dig_rpm_',num2str(rpm),'_Beta',num2str(Beta)];
audiowrite([filename,'.wav'],datas,Frequency);
save(filename);
%saveas(1, filename, 'jpg')