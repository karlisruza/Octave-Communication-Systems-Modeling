#https://www.diva-portal.org/smash/get/diva2:831827/FULLTEXT01.pdf


clc
close

fc = 140;
fs = 5000;

[b,a] = butter(6,fc/(fs/2), 'low');


#subplot(2,1,1)
#ylim([-100 20])
#----------------------------------------------------------------------

f = 2000
t = 0 : 0.00001 : 1/f;


one_bit = sin(2*pi*f*t);
zero_bit = zeros(size(t));

signal = [one_bit, zero_bit, one_bit, zero_bit];
rectified_signal = abs(signal);


#{
order = 5;
lowcut = 1999;
lowcut = lowcut * 2 /f;
[b,a] = butter(order,lowcut,'low');
#}

lowfilt = filtfilt(b,a,rectified_signal);
#plot(abs(lowfilt), "linewidth", 3, "color", 'k')

zeros2 = zeros(size(rectified_signal))
ones2 = ones(size(rectified_signal))

result = [ones2, zeros2, ones2, zeros2]
plot(result, "linewidth", 3, "color", 'k')


#plot(lowfilt, "linewidth", 3, "color", 'k')
#specgram(rectified_signal, 512, f);
