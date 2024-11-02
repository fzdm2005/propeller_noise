%% Test condition
slope = 0.0045; % Sensitivity of mic
dur = 2; % time span of each step
fRange = [50,15000];
%% DFS 
sound_path = [uigetdir('E:\Seafile\ISU\Propeller performance data treatment\results\Sound_result','Choose root path'),'\'];
mFiles = [];
[mFiles, FilesCount] = DeepTravel(sound_path,mFiles,0);
mFiles = mFiles';
%% find result data
result_valid = regexpi(mFiles, 'SoundMeasurement\w*\s*.mat');
%% data check
rpm_set = zeros(FilesCount,1);
ospl_set = zeros(FilesCount,1);
osplBB_set = zeros(FilesCount,1);
for i = 1: FilesCount
    if isempty(result_valid{i})
        continue;
    end
    D = load(mFiles{i});
    key_dist = D.dist;
    key_beta = D.Beta;
    key_rpm = D.rpm;
    datas = D.datas;
    Frequency = D.Frequency;
    rst = soundAna(datas,dur,Frequency,slope,fRange);
    rpm_set(i) = D.rpm;
    ospl_set(i) = rst.Ospl;
    osplBB_set(i) = rst.Ospl_BB;
    
%     bpf = rst.f/(2*D.rpm/60);
%     plot(bpf,rst.spl); 
%     title('Single-Sided Amplitude Spectrum')
%     xlabel('f (Hz)')
%     ylabel('Sound Pressure Level (dB)')
%     hold on
%     axis([2,200,-20,80])
%     %axis([20,1e5,-20,80])
%     set(gca, 'XScale', 'log')
end

% figure
% plot(rpm_set,ospl_set);

% figure
plot(rpm_set,ospl_set);
title('Overall SPL Beta = 0')
xlabel('rpm')
ylabel('Sound Pressure Level (dB)')
hold on