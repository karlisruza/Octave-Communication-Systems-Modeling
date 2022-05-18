# demodBpsk
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

function retval = demodBpsk (receivedSignal, frequency, fs)
  periodLength = 1 / frequency;
  samplesPerPeriod = (periodLength / (1 / fs)) + 1;
  
  t = 0 : 1 / fs : periodLength;
    
  sin0 = sin(t * 2 * pi * frequency);
  sin180 = sin(t * 2 * pi * frequency + pi);
  
  # Define ooutput
  demodulatedSignal = [];
  periodCount = length(receivedSignal) / samplesPerPeriod;
  
  for i = 1 : periodCount
    sectionStart = (i - 1) * samplesPerPeriod + 1;
    sectionEnd = i * samplesPerPeriod;
    currentPeriod = receivedSignal(sectionStart : sectionEnd);

    if(sum(abs(currentPeriod - sin0)) < sum(abs(currentPeriod - sin180)))
     demodulatedSignal = [demodulatedSignal, 0];
    else
     demodulatedSignal = [demodulatedSignal, 1];
    endif
  endfor
  
  retval = dataToSignal(demodulatedSignal, samplesPerPeriod);
endfunction
