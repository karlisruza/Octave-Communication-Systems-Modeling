# 4ASK BER TEST
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

# Initial setup
clc;
pkg load communications;
addpath('Util');
addpath('ModulationMethods/ask');

# Main logic
frequency = 400; # 550 Khz
fs = frequency * 20;
periodLength = 1 / frequency;
samplesPerPeriod = periodLength / (1 / fs);

fd = fopen('TestData/input_test.txt');
data = rot90(fread(fd) - 48);
dataSignal = dataToSignal(data, samplesPerPeriod);

modulatedSignal = modulate4Ask(dataSignal, frequency, fs);
rayleighFading(modulatedSignal, 3);
"modulatedSignal"
plot(modulatedSignal);

return

snr = 1;
receivedSignal = awgn(modulatedSignal, snr, 'measured');
"Received"
length(receivedSignal);


demodulatedSignal = demod4Ask(receivedSignal, frequency, fs);

decodedData = signalToData(demodulatedSignal, samplesPerPeriod);
[ber, percent] = biterr(data,  decodedData)
