clear
close
path2='result_9443_carbon\Beta_00\';
path1='result_9443_plastic\Beta_00\';
path_save='fig_save_beta0_2\';
s1= dir([path1 '*.mat']);
s2= dir([path2 '*.mat']);
num1 = length(s1);
num2 = length(s2);
if num1~= num2
    warning('Number of .mat file not same');
    return
end
for i=1:num1
    close all
    load([path1 s1(i).name]);
    plot_fft
    hold on
    load([path2 s2(i).name]);
    plot_fft
    title(['Single-Sided Amplitude Spectrum Rpm ',num2str(rpm)]);
    legend('9443 plastic','9443 carbon')
    axis([40,25000,0,80])
    saveas(1,[path_save,'rpm_',num2str(rpm)],'jpg');
end
