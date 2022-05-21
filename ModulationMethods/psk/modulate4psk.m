# modulate4Ask
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

function retval = modulate4psk(data, frequency, fs)
  # Calculate amount of samples in one period
  periodLength = 1 / frequency;
  samplesPerPeriod = (periodLength / (1 / fs));
  t = 0 : 1 / fs : periodLength - 1 / fs;
  
  # Define carrier
  sin0 = sin(2 * pi * frequency * t)
  sin90 = sin(2 * pi * frequency * t + pi / 2);
  sin180 = sin(2 * pi * frequency * t + pi);
  sin270 = sin(2 * pi * frequency * t + 3 * pi / 2);    
  
  bitValue2 = data(samplesPerPeriod + 1)
  counter2 = 0;
  
  for i = 1 : 2 : length(data) - length(samplesPerPeriod)
    counter2 += 1;
    
    if (mod(i, samplesPerPeriod) == 0)
       bitValue2 = data(i + samplesPerPeriod)
    endif
    
    waveSample = mod(counter2, samplesPerPeriod);
    if(waveSample == 0)
      waveSample = samplesPerPeriod;
    endif
    
    if (data(counter2) == 0 && bitValue2 == 0)
      modulatedSignal(counter2) = sin0(waveSample);  
    elseif (data(counter2) == 0 && bitValue2 == 1)
      modulatedSignal(counter2) = sin90(waveSample);    
    elseif (data(counter2) == 1 && bitValue2 == 0)
      modulatedSignal(counter2) = sin180(waveSample);    
    else
      modulatedSignal(counter2) = sin270(waveSample);
    endif    
  endfor  
        
  retval = modulatedSignal;
endfunction
