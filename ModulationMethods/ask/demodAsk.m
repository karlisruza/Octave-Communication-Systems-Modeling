# demodASK
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

function retval = demodAsk (receivedSignal, frequency, fs, compareThreshold)
  periodLength = 1 / frequency;
  samplesPerPeriod = periodLength / (1 / fs);
  
  rectifiedSignal = abs(receivedSignal);
  filteredSignal = butterLowpass(rectifiedSignal, frequency, fs, 560, 2);
  demodulatedSignal = [];
  
  for i = 0: length(filteredSignal) - 1
    if (mod(i, samplesPerPeriod) == round(samplesPerPeriod / 2))
      if (filteredSignal(i) > compareThreshold)
        demodulatedSignal = [demodulatedSignal, 1];
      else  
        demodulatedSignal = [demodulatedSignal, 0];
      endif
    endif
  endfor
  
  retval = dataToSignal(demodulatedSignal, samplesPerPeriod);
endfunction
