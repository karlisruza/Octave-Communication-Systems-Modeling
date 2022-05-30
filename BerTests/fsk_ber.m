# FSK BER TEST
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

# Initial setup
clc;
pkg load communications;
addpath('Util');
addpath('ModulationMethods/fsk');

# Main logic
frequency = 400; # 550 Khz
fs = frequency * 20;
periodLength = 1 / frequency;
samplesPerPeriod = periodLength / (1 / fs);

fd = fopen('TestData/input_test.txt');
data = rot90(fread(fd) - 48);

dataSignal = dataToSignal(data, samplesPerPeriod);
modulatedSignal = modulateFsk(dataSignal, frequency, fs, 30);

snr = 300;
receivedSignal = awgn(modulatedSignal, snr, 'measured');

demodulatedSignal = demodFsk(receivedSignal, frequency, fs, 30);

decodedData = signalToData(demodulatedSignal, samplesPerPeriod);
[ber, percent] = biterr(data,  decodedData)

