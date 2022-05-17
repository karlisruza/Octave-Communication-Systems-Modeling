# dataToSignal
# Author  Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

function retval = dataToSignal (data, pulseWidth)
  # Convert data to square wave format, where 1 bit = pulseWidth wide
  counter2 = 0;
  for i = 0:length (data) * pulseWidth - 1
    if (mod (i, pulseWidth) == 0)
      counter2 = counter2 + 1;
    endif
    if (data (counter2) == 0)
      dataSignal (i + 1) = 0;
    else
      dataSignal (i + 1) = 1;
    endif
  endfor
  retval = dataSignal;
endfunction

