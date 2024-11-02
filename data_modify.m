propeller = 'baselineV8';
maindir = char(strcat('D:\SoundMeasurment\result_',propeller,'\'));
subdir  = dir( maindir );
D_pro = 238.76/1000; % propeller diameters in m;
rou = 1.225; % air density
%voltage = 12;
dur = 4; %duration of each step
slope= 0.045;
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' )||...
        isequal( subdir( i ).name, '..')||...
        ~subdir( i ).isdir)               
        continue;
    end
    subdirpath = fullfile( maindir, subdir( i ).name, 'Sound*.mat' );
    dat = dir( subdirpath );               % find data file

    for j = 1 : length( dat )
        datpath = fullfile( maindir, subdir( i ).name, dat( j ).name);
        D = load(datpath);
        Sound_rst = soundAna(D.datas, dur, D.Frequency, slope);
        Sound_rst.bpf = f/(2*rpm/60);
        save(datpath,'Sound_rst','-append');
    end
end
