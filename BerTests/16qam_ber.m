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

fd = fopen('TestData/input_test.txt');
data = rot90(fread(fd) - 48);

dataSignal = dataToSignal(data, samplesPerPeriod  - 1);
modulatedSignal = modulate16qam(dataSignal, frequency, fs);
errors = [];

snr = 200;
receivedSignal = awgn(modulatedSignal, snr, 'measured');
length(receivedSignal)

demodulatedSignal = demod16qam(receivedSignal, frequency, fs);
plot(demodulatedSignal)
length(demodulatedSignal)
decodedData = signalToData(demodulatedSignal, samplesPerPeriod);
length(decodedData)
[ber, percent] = biterr(data,  decodedData)

errors = [errors, percent];

errors
result = sum(errors) / length(errors)