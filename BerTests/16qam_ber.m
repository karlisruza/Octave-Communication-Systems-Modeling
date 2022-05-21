# 16qam BER TEST
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

# Initial setup
clc;
pkg load communications;
addpath('Util');
addpath('ModulationMethods/qam');

# Main logic
frequency = 400; # 550 Khz
fs = frequency * 20;
periodLength = 1 / frequency;
samplesPerPeriod = (periodLength / (1 / fs)) + 1;

fd = fopen('TestData/input.txt');
data = rot90(fread(fd) - 48);

dataSignal = dataToSignal(data, samplesPerPeriod  - 1);
modulatedSignal = modulate16qam(dataSignal, frequency, fs);

plot(modulatedSignal);

snr = 7;
receivedSignal = awgn(modulatedSignal, snr, 'measured');

demodulatedSignal = demod16qam(receivedSignal, frequency, fs);

decodedData = signalToData(demodulatedSignal, samplesPerPeriod);
[ber, percent] = biterr(data,  decodedData)