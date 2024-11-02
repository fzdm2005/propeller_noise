clear
close
path1='result_9443_carbon\Mic_17344\';
path2='result_9443_plastic\Mic_17344\';
path_save='fig_save_beta0_linear\';
slope1 = 0.045;
slope2 = 0.045;
steps1 = 50;
steps2 = 50;
s1= dir([path1 '*.mat']);   
s2= dir([path2 '*.mat']);
num1 = length(s1);
num2 = length(s2);
if num1~= num2
    warning('Number of .mat file not same');
    return
end
for k=1:num1
    close all
    load([path1 s1(k).name]);
    data_treat_f(datas,steps1,Frequency,slope1);
    hold on
    load([path2 s2(k).name]);
    data_treat_f(datas,steps2,Frequency,slope2);
    title(['Single-Sided Amplitude Spectrum Rpm ',num2str(rpm)]);
    legend('9443 carbon','9443 plastic')
    xlabel('f (Hz)')
    ylabel('Sound Pressure Level (dB)')
    axis([40,30000,-20,100])
    saveas(1,[path_save,'rpm_',num2str(rpm)],'jpg');
end
