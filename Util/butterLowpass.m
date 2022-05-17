# butterLowpass
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

function retval = butterLowpass (signal, frequency, fs, cutoff, order)
  [b,a] = butter(6, cutoff /(fs/2), 'low');
  filteredSignal = filtfilt(b,a,signal);
  retval = filteredSignal;
endfunction
