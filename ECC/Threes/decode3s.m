# decode3s
# Author Karlis Edgars Ruza
# Bakalaura Darbs 
# 2022

function retval = decode3s (data)
  decodedData = [];
  
  for i = 1 : 3 : length(data)
    zeros = 0;
    ones = 0;
    for x = 0 : 2
      if (data(i + x) == 0)
        zeros += 1;
      else 
        ones + 1;
      endif
    endfor
    
    if (zeros > ones)
      decodedData = [decodedData, 0];
    else
      decodedData = [decodedData, 1];
    endif
  endfor
  
  retval = decodedData;
endfunction
