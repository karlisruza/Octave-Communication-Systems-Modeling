# BPSK BER TEST
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022
clc;

frequency = 400; # 550 Khz
fs = frequency * 20;
periodLength = 1 / frequency;
samplesPerPeriod = (periodLength / (1 / fs)) + 1;

t = 0 : 1 / fs : periodLength;
sin0 = sin(t * 2 * pi * frequency);

fd = fopen('input_test.txt');
data = rot90(fread(fd) - 48);

dataSignal = dataToSignal(data, samplesPerPeriod);
modulatedSignal = modulateBpsk(dataSignal, frequency, fs);

#length(modulatedSignal)
#samplesPerPeriod


demodBpsk(modulatedSignal, frequency, fs);

#{
snr = 5;
receivedSignal = awgn(modulatedSignal, snr, 'measured');
plot(receivedSignal)

demodThreshold = 0.4;
demodulatedSignal = demodAsk(receivedSignal, frequency, fs, demodThreshold);

decodedData = signalToData(demodulatedSignal, samplesPerPeriod);
[ber, percent] = biterr(data,  decodedData)
#}
