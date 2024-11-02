clear
close
Beta = 90;
path1=['result_baselineV8\Beta',num2str(Beta),'\'];
path2=['result_swept30_V8\Beta',num2str(Beta),'\'];
path_save=['fig_comparison\swept30_V8 vs baselineV8_Beta',num2str(Beta),'\'];
mkdir(path_save);
slope1 = 0.045;
slope2 = 0.045;
dur1 = 4;
dur2 = 4;
s1= dir([path1 '*.mat']);   
s2= dir([path2 '*.mat']);
num1 = length(s1);
num2 = length(s2);
if num1~= num2
    warning('Number of .mat file not same');
end
for k1=1:num1
    close all
    flag = 0;
    D1=load([path1 s1(k1).name]);
    for k2 = 1:num2
        D2=load([path2 s2(k2).name]);
        if D2.rpm == D1.rpm
            flag = 1;
            break;
        end
    end
    if flag == 0
        disp(['rpm',num2str(D1.rpm),'is not found in ',path2] );
        continue;
    end
    rpm = D1.rpm;
    data_treat_f(D1.datas,dur1,D1.Frequency,slope1);
    hold on
    data_treat_f(D2.datas,dur2,D2.Frequency,slope2);
    title(['Single-Sided Amplitude Spectrum Rpm ',num2str(rpm),' ,Beta',num2str(Beta)]);
    legend('baseline','swept 30deg')
    xlabel('f (Hz)')
    ylabel('Sound Pressure Level (dB)')
    axis([40,10000,-20,40])
    set(gca, 'XScale', 'log')
    saveas(1,[path_save,'rpm_',num2str(rpm)],'jpg');
    disp([num2str(k1),'/',num2str(num1), ' finished'])
end
