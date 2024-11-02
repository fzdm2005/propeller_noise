clear
Fs = 48000;
Bits = 8;
recObj = audiorecorder(Fs,Bits,1);
pause(0);
disp('Start speaking.')
recordblocking(recObj, 5);
disp('End of Recording.');
% 回放录音数据
%play(recObj);
% 获取录音数据
myRecording = getaudiodata(recObj);
% 绘制录音数据波形
plot(myRecording);
%存储语音信号
filename = 'data.wav'; 
audiowrite(filename,myRecording,Fs);