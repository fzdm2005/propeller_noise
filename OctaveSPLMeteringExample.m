%% Octave SPL Metering
% The |splMeter| enables you to monitor sound pressure level for octave and
% fractional-octave bands. In this example, you monitor the
% equivalent-continuous sound pressure level of 1/3-octave bands.

% Copyright 2018 The MathWorks, Inc.

%%
% Create a |dsp.AudioFileReader| object to read in an audio file frame by
% frame. Create an |audioDeviceWriter| object so you can listen to the
% audio signal. Create an |splMeter| to measure
% the octave sound pressure level of the audio file. Use the default
% calibration factor of 1. Create a |dsp.ArrayPlot| object to visualize the
% equivalent-continuous SPL for each octave band.
%

source = dsp.AudioFileReader('Datum.wav');
fs = source.SampleRate;

player = audioDeviceWriter('SampleRate',fs);

SPL = splMeter( ...
    'Bandwidth','1/3 octave', ...
    'SampleRate',fs);
centerFrequencies = getCenterFrequencies(SPL);

scope  = dsp.ArrayPlot(...
    'XDataMode','Custom', ...
    'CustomXData',centerFrequencies, ...
    'XLabel','Octave Band Center Frequencies (Hz)', ...
    'YLabel','Equivalent-Continuous Sound Level (dB)', ...
    'YLimits',[20 90], ...
    'ShowGrid',true, ...
    'Name','Sound Pressure Level Meter');

%% 
% In an audio stream loop:
%
% # Read in the audio signal frame.
% # Play the audio signal to your output device.
% # Call the SPL meter to return the equivalent-continuous sound pressure
% level in dB.
% # Display the sound levels using the scope. Update the scope only when
% the equivalent-continuous sound pressure level has changed.
%
% As a best practice, release your objects once complete.
%

LeqPrevious = zeros(size(centerFrequencies));
while ~isDone(source)
    x = source();
    player(x);
    [~,Leq] = SPL(x);
    
    for i = 1:size(Leq,1)
        if LeqPrevious ~= Leq(i,:)
            scope(Leq(i,:)')
            LeqPrevious = Leq(i,:);
        end
    end
    
end

release(source)
release(player)
release(SPL)
release(scope)