function [datas,time] = Sound_DAQ_Dig(fs,Dur)
Bits = 8;
Frequency=fs;
dt = 1/Frequency;
time = dt:dt:Dur;
recObj = audiorecorder(Frequency,Bits,1);
disp('Start speaking.')
recordblocking(recObj,Dur);
disp('End of Recording.');
datas = getaudiodata(recObj);
