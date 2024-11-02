clear
Frequency=48000; %sample Fs
slope = 0.0045; % sensitivity of mic
rpm=5300;
Beta = 0;
Bits = 8;
recObj = audiorecorder(Frequency,Bits,1);
pause(30);
disp('Start speaking.')
recordblocking(recObj,20);
disp('End of Recording.');
% �ط�¼������
%play(recObj);
% ��ȡ¼������
datas = getaudiodata(recObj);
% ����¼�����ݲ���
plot(datas);
[P1,f]=Sound_fft(datas,Frequency);
P = P_cal(P1,slope);
spl = spl_air(P);
plot(f,spl); 
%title(['Single-Sided Amplitude Spectrum of SPL(f)_RPM_',num2str(rpm)],'Interpreter','none');
xlabel('f (Hz)')
ylabel('Sound Pressure Level (dB)')
axis([0,1e5,0,120])
set(gca, 'XScale', 'log')
path = 'Dig\';
filename = [path 'SoundMeasurement_Dig_rpm_',num2str(rpm),'_Beta',num2str(Beta)];
audiowrite([filename,'.wav'],datas,Frequency);
save(filename);
%saveas(1, filename, 'jpg')