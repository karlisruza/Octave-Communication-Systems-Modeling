# demod4ASK
# Author Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

function retval = demod4Ask (receivedSignal, frequency, fs)
  periodLength = 1 / frequency;
  samplesPerPeriod = periodLength / (1 / fs);
  
  rectifiedSignal = abs(receivedSignal);
  filteredSignal = butterLowpass(rectifiedSignal, frequency, fs, 560, 2);
  demodulatedSignal = [];
  maxValue = max(filteredSignal);
  
  for i = 0: length(filteredSignal) - 1
    if (mod(i, samplesPerPeriod) == round(samplesPerPeriod / 2))
      if (filteredSignal(i) < maxValue / 4)
        demodulatedSignal = [demodulatedSignal, 0, 0];
      elseif (filteredSignal(i) < maxValue / 4 * 2)
        demodulatedSignal = [demodulatedSignal, 0, 1];
      elseif (filteredSignal(i) < maxValue / 4 * 3)
        demodulatedSignal = [demodulatedSignal, 1, 0];
      else
        demodulatedSignal = [demodulatedSignal, 1, 1];
      endif
    endif
  endfor
  
  retval = dataToSignal(demodulatedSignal, samplesPerPeriod);
endfunction
