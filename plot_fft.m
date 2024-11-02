plot(f,spl); 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('Sound Pressure Level (dB)')
axis([20,22000,0,80])
set(gca, 'XScale', 'log')