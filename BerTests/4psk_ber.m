# BPSK BER TEST
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

# Initial setup
clc;
clear;
pkg load communications;
addpath('Util');
addpath('ModulationMethods/psk');
addpath('TestData');

# Main section
frequency = 400;
fs = frequency * 20;
periodLength = 1 / frequency;
samplesPerPeriod = (periodLength / (1 / fs));

# Read and rotate bits from txt file
fd = fopen('input.txt');
data = rot90(fread(fd) - 48);

dataSignal = dataToSignal(data, samplesPerPeriod);
modulatedSignal = modulate4psk(dataSignal, frequency, fs);

# Trnasmission - Apply noise
snr = 19;
receivedSignal = awgn(modulatedSignal, snr, 'measured');

# Demodulate and convert to binary form
demodulatedSignal = demod4psk(receivedSignal, frequency, fs);
length(demodulatedSignal)
decodedData = signalToData(demodulatedSignal, samplesPerPeriod);

[ber, percent] = biterr(data,  decodedData)
