function [datas,time] = Sound_DAQ_Ana(fs,Dur)
Frequency=fs;
s = daq.createSession('ni');
devices = daq.getDevices;
s.Rate =Frequency;
ch(1) = addAnalogInputChannel(s, 'cDAQ2Mod1', 'ai0','Voltage');
ch(2) = addAnalogInputChannel(s, 'cDAQ2Mod1', 'ai1','Voltage');
s.DurationInSeconds=Dur;
lh = addlistener(s,'DataAvailable', @(src,event) plot(event.TimeStamps, event.Data));
[datas,time] = startForeground(s);
s.wait()
delete(lh);
release(s);






