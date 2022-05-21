# demod16qam
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

function retval = demod16qam (receivedSignal, frequency, fs)
  # Calculate amount of samples in one period
  periodLength = 1 / frequency;
  samplesPerPeriod = (periodLength / (1 / fs));
  t = 0 : 1 / fs : periodLength - 1 / fs;
  
  # Define reference carrier
  sin0    = sin(2 * pi * frequency * t);
  sin90   = sin(2 * pi * frequency * t + pi / 2);
  sin180  = sin(2 * pi * frequency * t + pi);
  sin270  = sin(2 * pi * frequency * t + 3 * pi / 2);   
  
  # Define output
  demodulatedSignal = [];
  periodCount = length(receivedSignal) / samplesPerPeriod;
  
  decodedData = [];
  
  #Initialize buffers used for counting sum of absolute deviation
  sum0      = 0;
  sum90     = 0;
  sum180    = 0;
  sum270    = 0;
  sum0_2    = 0;
  sum90_2   = 0;
  sum180_2  = 0;
  sum270_2  = 0;
  sum0_3    = 0;
  sum90_3   = 0;
  sum180_3  = 0;
  sum270_3  = 0;
  sum0_4    = 0;
  sum90_4   = 0;
  sum180_4  = 0;
  sum270_4  = 0;
      
  for i = 1 : length(receivedSignal)   
    waveSample = mod(i, samplesPerPeriod);
    if(waveSample == 0)
      waveSample = samplesPerPeriod;
    endif
    
    # Update deviation sum
    sum0     = sum0      + abs(receivedSignal(i)  - 1.00 * sin0(waveSample));    #0000
    sum90    = sum90     + abs(receivedSignal(i)  - 1.00 * sin90(waveSample));   #0001
    sum180   = sum180    + abs(receivedSignal(i)  - 1.00 * sin180(waveSample));  #0010
    sum270   = sum270    + abs(receivedSignal(i)  - 1.00 * sin270(waveSample));  #0011
    sum0_2   = sum0_2    + abs(receivedSignal(i)  - 0.75 * sin0(waveSample));    #0100
    sum90_2  = sum90_2   + abs(receivedSignal(i)  - 0.75 * sin90(waveSample));   #0101
    sum180_2 = sum180_2  + abs(receivedSignal(i)  - 0.75 * sin180(waveSample));  #0110
    sum270_2 = sum270_2  + abs(receivedSignal(i)  - 0.75 * sin270(waveSample));  #0111
    sum0_3   = sum0_3    + abs(receivedSignal(i)  - 0.50 * sin0(waveSample));    #1000
    sum90_3  = sum90_3   + abs(receivedSignal(i)  - 0.50 * sin90(waveSample));   #1001
    sum180_3 = sum180_3  + abs(receivedSignal(i)  - 0.50 * sin180(waveSample));  #1010
    sum270_3 = sum270_3  + abs(receivedSignal(i)  - 0.50 * sin270(waveSample));  #1011
    sum0_4   = sum0_4    + abs(receivedSignal(i)  - 0.25 * sin0(waveSample));    #1100
    sum90_4  = sum90_4   + abs(receivedSignal(i)  - 0.25 * sin90(waveSample));   #1101
    sum180_4 = sum180_4  + abs(receivedSignal(i)  - 0.25 * sin180(waveSample));  #1110
    sum270_4 = sum270_4  + abs(receivedSignal(i)  - 0.25 * sin270(waveSample));  #1111
    
    # Compare
    if (mod(i, samplesPerPeriod) == 0)
      # Find lowest value to avoid writing a super huge if statement
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
      if (sum0_2 < lowest);
        lowest = sum0_2;
      endif
      if (sum90_2 < lowest);   
        lowest = sum90_2;        
      endif
      if (sum180_2 < lowest);
        lowest = sum180_2;   
      endif     
      if (sum270_2 < lowest);
        lowest = sum270_2;        
      endif
      if (sum0_3 < lowest)
        lowest = sum0_3;
      endif
      if (sum90_3 < lowest)
        lowest = sum90_3;
      endif
      if (sum180_3 < lowest);
        lowest = sum180_3;
      endif
      if (sum270_3 < lowest);
        lowest = sum270_3;
      endif
      if (sum0_4 < lowest);
        lowest = sum0_4;
      endif
      if (sum90_4 < lowest);   
        lowest = sum90_4;        
      endif
      if (sum180_4 < lowest);
        lowest = sum180_4;   
      endif     
      if (sum270_4 < lowest);
        lowest = sum270_4;        
      endif          
      
      # Write to output buffer
      if (lowest == sum0)
        decodedData = [decodedData, 0, 0, 0, 0];
      elseif (lowest == sum90)
        decodedData = [decodedData, 0, 0, 0, 1];
      elseif (lowest == sum180)
        decodedData = [decodedData, 0, 0, 1, 0];
      elseif (lowest == sum270)
        decodedData = [decodedData, 0, 0, 1, 1];
      elseif (lowest == sum0_2)
        decodedData = [decodedData, 0, 1, 0, 0];
      elseif (lowest == sum90_2)
        decodedData = [decodedData, 0, 1, 0, 1];
      elseif (lowest == sum180_2)
        decodedData = [decodedData, 0, 1, 1, 0];
      elseif (lowest == sum270_2)
        decodedData = [decodedData, 0, 1, 1, 1];
      elseif (lowest == sum0_3)
        decodedData = [decodedData, 1, 0, 0, 0];
      elseif (lowest == sum90_3)
        decodedData = [decodedData, 1, 0, 0, 1];
      elseif (lowest == sum180_3)
        decodedData = [decodedData, 1, 0, 1, 0];
      elseif (lowest == sum270_3)
        decodedData = [decodedData, 1, 0, 1, 1];
      elseif (lowest == sum0_4)
        decodedData = [decodedData, 1, 1, 0, 0];
      elseif (lowest == sum90_4)
        decodedData = [decodedData, 1, 1, 0, 1];
      elseif (lowest == sum180_4)
        decodedData = [decodedData, 1, 1, 1, 0];
      elseif (lowest == sum270_4)
        decodedData = [decodedData, 1, 1, 1, 1];
      endif
      
      # Reset buffers
      sum0     = 0;
      sum90    = 0;
      sum180   = 0;
      sum270   = 0;
      sum0_2   = 0;
      sum90_2  = 0;
      sum180_2 = 0;
      sum270_2 = 0;
      sum0_3   = 0;
      sum90_3  = 0;
      sum180_3 = 0;
      sum270_3 = 0;
      sum0_4   = 0;
      sum90_4  = 0;
      sum180_4 = 0;
      sum270_4 = 0;
      lowest   = 0;
    endif
  endfor
  
  decodedData;
  
  retval = dataToSignal(decodedData, samplesPerPeriod + 1);
endfunction
