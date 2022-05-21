# modulate8qam
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

function retval = modulate8qam(data, frequency, fs)
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
  bitValue3 = data(2 * samplesPerPeriod + 1);
    
  counter2 = 0;
  modulatedSignal = [];
    
  for i = 1 : 3 : length(data)
    counter2 += 1;
    
    waveSample = mod(counter2, samplesPerPeriod);
    if(waveSample == 0)
      waveSample = samplesPerPeriod;
    endif
    
    if (waveSample == 1 && i != 1)
        counter2 += 2 * samplesPerPeriod;
        
        if (counter2 + samplesPerPeriod < length(data))
          bitValue2 = data(counter2 + samplesPerPeriod + 1); #Track the bit vlaue 1 period ahead
          bitValue3 = data(counter2 + 2 * samplesPerPeriod); #Track the bit vlaue 2 period ahead
        endif
    endif
         
    # 000 => 1 * sin0
    # 001 => 1 * sin90
    # 010 => 1 * sin180
    # 011 => 1 * sin270
    # 100 => 0.5 * sin0
    # 101 => 0.5 * sin90
    # 110 => 0.5 * sin180
    # 111 => 0.5 * sin270
       
    if (data(counter2) == 0 && bitValue2 == 0 && bitValue3 == 0)
      modulatedSignal = [modulatedSignal, sin0(waveSample)];  
    elseif (data(counter2) == 0 && bitValue2 == 0 && bitValue3 == 1)
      modulatedSignal = [modulatedSignal, sin90(waveSample)];
    elseif (data(counter2) == 0 && bitValue2 == 1 && bitValue3 == 0)
      modulatedSignal = [modulatedSignal, sin180(waveSample)];
    elseif (data(counter2) == 0 && bitValue2 == 1 && bitValue3 == 1)
      modulatedSignal = [modulatedSignal, sin270(waveSample)];    
    elseif (data(counter2) == 1 && bitValue2 == 0 && bitValue3 == 0)
      modulatedSignal = [modulatedSignal, 0.5 * sin0(waveSample)];  
    elseif (data(counter2) == 1 && bitValue2 == 0 && bitValue3 == 1)
      modulatedSignal = [modulatedSignal, 0.5 * sin90(waveSample)];
    elseif (data(counter2) == 1 && bitValue2 == 1 && bitValue3 == 0)
      modulatedSignal = [modulatedSignal, 0.5 * sin180(waveSample)];
    elseif (data(counter2) == 1 && bitValue2 == 1 && bitValue3 == 1)
      modulatedSignal = [modulatedSignal, 0.5 * sin270(waveSample)];    
    endif    
  endfor  
        
  retval = modulatedSignal;
endfunction
