# modulate8qam
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

function retval = modulate16qam(data, frequency, fs)
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
  bitValue4 = data(3 * samplesPerPeriod + 1);
    
  counter2 = 0;
  modulatedSignal = [];
    
  for i = 1 : 4 : length(data)
    counter2 += 1;
    
    waveSample = mod(counter2, samplesPerPeriod);
    if(waveSample == 0)
      waveSample = samplesPerPeriod;
    endif
    
    if (waveSample == 1 && i != 1)
        counter2 += 3 * samplesPerPeriod;
        
        if (counter2 + samplesPerPeriod < length(data))
          bitValue2 = data(counter2 + samplesPerPeriod);     #Track the bit vlaue 1 period ahead
          bitValue3 = data(counter2 + 2 * samplesPerPeriod); #Track the bit vlaue 2 period ahead
          bitValue4 = data(counter2 + 3 * samplesPerPeriod); #Track the bit vlaue 2 period ahead
        endif
    endif
         
    # 0000 => 1 * sin0
    # 0001 => 1 * sin90
    # 0010 => 1 * sin180
    # 0011 => 1 * sin270
    # 0100 => 0.75 * sin0
    # 0101 => 0.75 * sin90
    # 0110 => 0.75 * sin180
    # 0111 => 0.75 * sin270
    # 1000 => 0.5 * sin0
    # 1001 => 0.5 * sin90
    # 1010 => 0.5 * sin180
    # 1011 => 0.5 * sin270
    # 1100 => 0.25 * sin0
    # 1101 => 0.25 * sin90
    # 1110 => 0.25 * sin180
    # 1111 => 0.25 * sin270
       
    if (data(counter2) == 0 && bitValue2 == 0 && bitValue3 == 0 && bitValue4 == 0)
      modulatedSignal = [modulatedSignal, sin0(waveSample)];  
    elseif (data(counter2) == 0 && bitValue2 == 0 && bitValue3 == 0 && bitValue4 == 1)
      modulatedSignal = [modulatedSignal, sin90(waveSample)];
    elseif (data(counter2) == 0 && bitValue2 == 0 && bitValue3 == 1 && bitValue4 == 0)
      modulatedSignal = [modulatedSignal, sin180(waveSample)];
    elseif (data(counter2) == 0 && bitValue2 == 0 && bitValue3 == 1 && bitValue4 == 1)
      modulatedSignal = [modulatedSignal, sin270(waveSample)];   
      
    elseif (data(counter2) == 0 && bitValue2 == 1 && bitValue3 == 0 && bitValue4 == 0)
      modulatedSignal = [modulatedSignal, 0.75 * sin0(waveSample)];  
    elseif (data(counter2) == 0 && bitValue2 == 1 && bitValue3 == 0 && bitValue4 == 1)
      modulatedSignal = [modulatedSignal, 0.75 * sin90(waveSample)];
    elseif (data(counter2) == 0 && bitValue2 == 1 && bitValue3 == 1 && bitValue4 == 0)
      modulatedSignal = [modulatedSignal, 0.75 * sin180(waveSample)];
    elseif (data(counter2) == 0 && bitValue2 == 1 && bitValue3 == 1 && bitValue4 == 1)
      modulatedSignal = [modulatedSignal, 0.75 * sin270(waveSample)];
      
    elseif (data(counter2) == 1 && bitValue2 == 0 && bitValue3 == 0 && bitValue4 == 0)
      modulatedSignal = [modulatedSignal, 0.5 * sin0(waveSample)];  
    elseif (data(counter2) == 1 && bitValue2 == 0 && bitValue3 == 0 && bitValue4 == 1)
      modulatedSignal = [modulatedSignal, 0.5 * sin90(waveSample)];
    elseif (data(counter2) == 1 && bitValue2 == 0 && bitValue3 == 1 && bitValue4 == 0)
      modulatedSignal = [modulatedSignal, 0.5 * sin180(waveSample)];
    elseif (data(counter2) == 1 && bitValue2 == 0 && bitValue3 == 1 && bitValue4 == 1)
      modulatedSignal = [modulatedSignal, 0.5 * sin270(waveSample)];    
      
    elseif (data(counter2) == 1 && bitValue2 == 1 && bitValue3 == 0 && bitValue4 == 0)
      modulatedSignal = [modulatedSignal, 0.25 * sin0(waveSample)];  
    elseif (data(counter2) == 1 && bitValue2 == 1 && bitValue3 == 0 && bitValue4 == 1)
      modulatedSignal = [modulatedSignal, 0.25 * sin90(waveSample)];
    elseif (data(counter2) == 1 && bitValue2 == 1 && bitValue3 == 1 && bitValue4 == 0)
      modulatedSignal = [modulatedSignal, 0.25 * sin180(waveSample)];
    elseif (data(counter2) == 1 && bitValue2 == 1 && bitValue3 == 1 && bitValue4 == 1)
      modulatedSignal = [modulatedSignal, 0.25 * sin270(waveSample)];     
    endif    
  endfor  
        
  retval = modulatedSignal;
endfunction
