# ASK BER TEST
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

# Initial setup
clc;
pkg load communications;
addpath('Util');
addpath('ECC/Threes');
addpath('ECC/Hamming47');
addpath('TestData');
addpath('ModulationMethods/ask');
addpath('NoiseChannels');

frequency = 400; # 550 Khz
fs = frequency * 20;
periodLength = 1 / frequency;
samplesPerPeriod = periodLength / (1 / fs);

fd = fopen('input.txt');
originalData = rot90(fread(fd) - 48);
data = encode3s(originalData);

dataSignal = dataToSignal(data, samplesPerPeriod);
modulatedSignal = modulateAsk(dataSignal, frequency, fs);

errors = [];

#for i = 0 : 1
snr = 1;

#receivedSignal = awgn(modulatedSignal, snr, 'measured');
receivedSignal = rayleighFading(modulatedSignal, snr);

demodThreshold = 0.4;
demodulatedSignal = demodAsk(receivedSignal, frequency, fs, demodThreshold);

decodedData = signalToData(demodulatedSignal, samplesPerPeriod);
decodedData = decode3s(decodedData);
[ber, percent] = biterr(originalData,  decodedData)
errors = [errors, percent];

#endfor

errors
result = sum(errors) / length(errors)
