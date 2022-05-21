# demod4psk
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

function retval = demod8qam (receivedSignal, frequency, fs)
  # Calculate amount of samples in one period
  periodLength = 1 / frequency;
  samplesPerPeriod = (periodLength / (1 / fs));
  t = 0 : 1 / fs : periodLength - 1 / fs;
  
  # Define reference carrier
  sin0 = sin(2 * pi * frequency * t);
  sin90 = sin(2 * pi * frequency * t + pi / 2);
  sin180 = sin(2 * pi * frequency * t + pi);
  sin270 = sin(2 * pi * frequency * t + 3 * pi / 2);   
  
  # Define ooutput
  demodulatedSignal = [];
  periodCount = length(receivedSignal) / samplesPerPeriod;
  
  decodedData = [];
  
  sum0 = 0;
  sum90 = 0;
  sum180 = 0;
  sum270 = 0;
  sum0half = 0;
  sum90half = 0;
  sum180half = 0;
  sum270half = 0;
      
  for i = 1 : length(receivedSignal)   
    waveSample = mod(i, samplesPerPeriod);
    if(waveSample == 0)
      waveSample = samplesPerPeriod;
    endif
    
    sum0 = sum0 + abs(receivedSignal(i) - sin0(waveSample));         #00
    sum90 = sum90 + abs(receivedSignal(i) - sin90(waveSample));      #01
    sum180 = sum180 + abs(receivedSignal(i) - sin180(waveSample));   #10
    sum270 = sum270 + abs(receivedSignal(i) - sin270(waveSample));   #11
    sum0half = sum0half + abs(receivedSignal(i) - 0.5 * sin0(waveSample));         #00
    sum90half = sum90half + abs(receivedSignal(i) - 0.5 * sin90(waveSample));      #01
    sum180half = sum180half + abs(receivedSignal(i) - 0.5 * sin180(waveSample));   #10
    sum270half = sum270half + abs(receivedSignal(i) - 0.5 * sin270(waveSample));   #11
    
    # Compare
    if (mod(i, samplesPerPeriod) == 0)
      lowest = sum0;
      
      if (sum90 < lowest)
        lowest = sum90;
      endif
      if (sum180 < lowest);
        lowest = sum180;
      endif
      if (sum270 < lowest);
        lowest = sum270;
      endif
      if (sum0half < lowest);
        lowest = sum0half;
      endif
      if (sum90half < lowest);   
        lowest = sum90half;        
      endif
      if (sum180half < lowest);
        lowest = sum180half;   
      endif     
      if (sum270half < lowest);
        lowest = sum270half;        
      endif     
      
      if (lowest == sum0)
        decodedData = [decodedData, 0, 0, 0];
      elseif (lowest == sum90)
        decodedData = [decodedData, 0, 0, 1];
      elseif (lowest == sum180)
        decodedData = [decodedData, 0, 1, 0];
      elseif (lowest == sum270)
        decodedData = [decodedData, 0, 1, 1];
      elseif (lowest == sum0half)
        decodedData = [decodedData, 1, 0, 0];
      elseif (lowest == sum90half)
        decodedData = [decodedData, 1, 0, 1];
      elseif (lowest == sum180half)
        decodedData = [decodedData, 1, 1, 0];
      elseif (lowest == sum270half)
        decodedData = [decodedData, 1, 1, 1];
      endif
      
      sum0 = 0;
      sum90 = 0;
      sum180 = 0;
      sum270 = 0;
      sum0half = 0;
      sum90half = 0;
      sum180half = 0;
      sum270half = 0;
      lowest = 0;
    endif
  endfor
  
  decodedData
  
  retval = dataToSignal(decodedData, samplesPerPeriod + 1);
endfunction
