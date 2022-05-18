# modulate4Ask
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

function retval = modulate4psk(data, frequency, fs)
  # Calculate amount of samples in one period
  periodLength = 1 / frequency;
  samplesPerPeriod = (periodLength / (1 / fs)) + 1;
  t = 0 : 1 / fs : periodLength;
  
  # Define carrier
  sin0 = sin(2 * pi * frequency * t);
  sin90 = sin(2 * pi * frequency * t + pi / 2);
  sin180 = sin(2 * pi * frequency * t + pi);
  sin270 = sin(2 * pi * frequency * t + 2 * pi / 3);
    
  for i = 1 : length(data)
    if (data(i) == 0 && data(i + samplesPerPeriod) == 0)
      modulatedSignal(i) = sin0(mod(i, samplesPerPeriod) + 1);
    elseif (data(i) == 0 && data(i + samplesPerPeriod) == 1)
      modulatedSignal(i) = sin90(mod(i, samplesPerPeriod) + 1);    
    elseif (data(i) == 1 && data(i + samplesPerPeriod) == 0)
      modulatedSignal(i) = sin180(mod(i, samplesPerPeriod) + 1);    
    else
      modulatedSignal(i) = sin270(mod(i, samplesPerPeriod) + 1);
    endif
    
    if (i == length(data))
      i = i + samplesPerPeriod;
    endif
  endfor  
        
  retval = modulatedSignal;
endfunction
