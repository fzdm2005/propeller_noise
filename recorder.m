clear
Fs = 48000;
Bits = 8;
recObj = audiorecorder(Fs,Bits,1);
pause(0);
disp('Start speaking.')
recordblocking(recObj, 5);
disp('End of Recording.');
% �ط�¼������
%play(recObj);
% ��ȡ¼������
myRecording = getaudiodata(recObj);
% ����¼�����ݲ���
plot(myRecording);
%�洢�����ź�
filename = 'data.wav'; 
audiowrite(filename,myRecording,Fs);