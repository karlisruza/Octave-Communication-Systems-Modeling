# ASK BER TEST
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

# Initial setup
clc;
pkg load communications;
addpath('Util');
addpath('ModulationMethods/ask');

frequency = 400; # 550 Khz
fs = frequency * 20;
periodLength = 1 / frequency;
samplesPerPeriod = periodLength / (1 / fs);

fd = fopen('input_test.txt');
data = rot90(fread(fd) - 48);

dataSignal = dataToSignal(data, samplesPerPeriod);
modulatedSignal = modulateAsk(dataSignal, frequency, fs);

snr = 5;
receivedSignal = awgn(modulatedSignal, snr, 'measured');
plot(receivedSignal)

demodThreshold = 0.4;
demodulatedSignal = demodAsk(receivedSignal, frequency, fs, demodThreshold);

length(demodulatedSignal)

decodedData = signalToData(demodulatedSignal, samplesPerPeriod);
[ber, percent] = biterr(data,  decodedData)