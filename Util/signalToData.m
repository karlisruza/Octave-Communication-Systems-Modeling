# signalToData
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

function retval = signalToData (signal, pulseWidth)
  data = [];
  
  for i = 0 : length(signal) - 1
    if (mod(i, pulseWidth) == round(pulseWidth / 2))
      if (signal(i) == 1)
        data = [data, 1];
      else
        data = [data, 0];
      endif
    endif
  endfor
  
  retval = data;
endfunction

