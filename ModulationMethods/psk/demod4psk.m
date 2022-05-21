# demod4psk
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

function retval = demod4psk (receivedSignal, frequency, fs)
  # Calculate amount of samples in one period
  periodLength = 1 / frequency;
  samplesPerPeriod = (periodLength / (1 / fs));
  t = 0 : 1 / fs : periodLength - 1 / fs;
  
  # Define reference carrier
  sin0 = sin(2 * pi * frequency * t)
  sin90 = sin(2 * pi * frequency * t + pi / 2);
  sin180 = sin(2 * pi * frequency * t + pi);
  sin270 = sin(2 * pi * frequency * t + 3 * pi / 2);   
  
  # Define ooutput
  demodulatedSignal = [];
  periodCount = length(receivedSignal) / samplesPerPeriod;
  
  decodedData = [];
  
  for i = 1 : length(receivedSignal)
    if (mod(i, samplesPerPeriod) == 1)
      sum0 = 0;
      sum90 = 0;
      sum180 = 0;
      sum270 = 0;
    endif
    
    waveSample = mod(i, samplesPerPeriod);
    if(waveSample == 0)
      waveSample = samplesPerPeriod;
    endif
    
    sum0 = sum0 + abs(receivedSignal(i) - sin0(waveSample))         #00
    sum90 = sum90 + abs(receivedSignal(i) - sin90(waveSample))      #01
    sum180 = sum180 + abs(receivedSignal(i) - sin180(waveSample))   #10
    sum270 = sum270 + abs(receivedSignal(i) - sin270(waveSample))   #11
    
    # Compare
  
    if (mod(i, samplesPerPeriod) == 0)
      if (sum0 > sum90 && sum0 > sum180 && sum0 > sum270)
        decodedData = [decodedData, 0, 0]
      elseif (sum90 > sum0 && sum90 > sum180 && sum90 > sum270)
        decodedData = [decodedData, 0, 1]
      elseif (sum180 > sum0 && sum180 > sum90 && sum180 > sum270)
        decodedData = [decodedData, 1, 0]
      else
        decodedData = [decodedData, 1, 1]
      endif
    endif
  endfor
  
  retval = dataToSignal(decodedData, samplesPerPeriod);
endfunction
