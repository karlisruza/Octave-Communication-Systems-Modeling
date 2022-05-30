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
  sin0 = sin(2 * pi * frequency * t);
  sin90 = sin(2 * pi * frequency * t + pi / 2);
  sin180 = sin(2 * pi * frequency * t + pi);
  sin270 = sin(2 * pi * frequency * t + 3 * pi / 2);    
  
  bitValue2 = data(samplesPerPeriod + 1);
  counter2 = 0;
  modulatedSignal = [];
  
  for i = 1 : 2 : length(data) - length(samplesPerPeriod)
    counter2 += 1;
    
    waveSample = mod(counter2, samplesPerPeriod);
    if(waveSample == 0)
      waveSample = samplesPerPeriod;
    endif
    
    if (waveSample == 1 && i != 1)
        counter2 += samplesPerPeriod;
        
        if (counter2 + samplesPerPeriod < length(data))
          bitValue2 = data(counter2 + samplesPerPeriod + 1); #Track the bit vlaue 1 period ahead
        endif
    endif
    
    if (data(counter2) == 0 && bitValue2 == 0)
      modulatedSignal = [modulatedSignal, sin0(waveSample)];  
    elseif (data(counter2) == 0 && bitValue2 == 1)
      modulatedSignal = [modulatedSignal, sin90(waveSample)];    
    elseif (data(counter2) == 1 && bitValue2 == 0)
      modulatedSignal = [modulatedSignal, sin180(waveSample)];    
    else
      modulatedSignal = [modulatedSignal, sin270(waveSample)];
    endif    
  endfor  
        
  retval = modulatedSignal;
endfunction
