# modulate4Ask
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

function retval = modulate4Ask(data, frequency, fs)
  # Calculate amount of samples in one period
  periodLength = 1 / frequency;
  samplesPerPeriod = periodLength / (1 / fs);
  
  # Define carrier
  t = 0 : 1 / fs : periodLength;
  carrier = sin(2 * pi * frequency * t);
  modulatedSignal = [];

  
  for i = 0 : length(data) - 1 - samplesPerPeriod
    if (mod(i, samplesPerPeriod * 2) < samplesPerPeriod)
      if (data(i + 1) == 0 && data(i + samplesPerPeriod) == 0)
        modulatedSignal = [modulatedSignal, carrier(mod(i, samplesPerPeriod) + 1) * 0.25];
      elseif (data(i + 1) == 0 && data(i + samplesPerPeriod) == 1)
        modulatedSignal = [modulatedSignal, carrier(mod(i, samplesPerPeriod) + 1) * 0.5];
      elseif (data(i + 1) == 1 && data(i + samplesPerPeriod) == 0)
        modulatedSignal = [modulatedSignal, carrier(mod(i, samplesPerPeriod) + 1) * 0.75];
      elseif (data(i + 1) == 1 && data(i + samplesPerPeriod) == 1)
        modulatedSignal = [modulatedSignal, carrier(mod(i, samplesPerPeriod) + 1)];
      endif
    endif
  endfor  
      
  retval = modulatedSignal;
endfunction
