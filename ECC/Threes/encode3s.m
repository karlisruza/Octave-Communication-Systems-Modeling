# encode3s
# Author Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

function retval = encode3s (data)
  encodedData = [];
  
  for i = 1 : length(data)
    if (data(i) == 0)
      encodedData = [encodedData, 0, 0, 0];
    elseif (data(i) == 1)
      encodedData = [encodedData, 1, 1, 1];
    endif
  endfor
  
  retval = encodedData;
endfunction
