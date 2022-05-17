# ASK BER TEST
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022
clc;

frequency = 400; # 550 Khz
fs = frequency * 20;
periodLength = 1 / frequency;
samplesPerPeriod = periodLength / (1 / fs);

fd = fopen('input.txt');
data = rot90(fread(fd) - 48);

dataSignal = dataToSignal(data, samplesPerPeriod);
modulatedSignal = modulate4Ask(dataSignal, frequency, fs);

snr = 300;
receivedSignal = awgn(modulatedSignal, snr, 'measured');

demodThreshold = 0.4;
demodulatedSignal = demod4Ask(receivedSignal, frequency, fs);

decodedData = signalToData(demodulatedSignal, samplesPerPeriod);
[ber, percent] = biterr(data,  decodedData)