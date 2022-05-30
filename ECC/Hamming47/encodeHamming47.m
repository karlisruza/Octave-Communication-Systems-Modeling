function retval = encodeHamming47(data)
  # Generation matrix
  G = [
        1 0 0 0 0 1 1;
        0 1 0 0 1 0 1;      
        0 0 1 0 1 1 0;
        0 0 0 1 1 1 1;
  ]; 
  decodedData = [];
  
  for i = 1 : 4 : length(data)
    word = [data(i), data(i + 1), data(i + 2), data(i + 3)];
    decodedData = [decodedData, word * G];  
  endfor
  
  retval = mod(decodedData, 2);
endfunction