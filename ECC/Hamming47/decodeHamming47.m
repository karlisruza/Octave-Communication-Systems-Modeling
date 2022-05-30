function retval = decodeHamming47(data)
  # Parity check matrix
  H = [
    0, 1, 1, 1, 1, 0, 0;
    1, 0, 1, 1, 0, 1, 0;
    1, 1, 0, 1, 0, 0, 1;
  ]; 
  
  decodedData = [];
  
  for i = 1 : 7 : length(data)
    word = [data(i); data(i + 1); data(i + 2); data(i + 3); data(i + 4); data(i + 5); data(i + 6)];
    syndrome = mod(H * word, 2);
    
    if (sum(syndrome) != 0)
        for x = 1 : 4    
          vector = H(:, x)  ;   
          
          if (vector(1) == syndrome(1) && vector(2) == syndrome(2) && vector(3) == syndrome(3))     
            if (word(x) == 0)
              word(x) = 1;              
            else 
              word(x) = 0;
            endif
          endif
        endfor
    endif        
    
    decodedData = [decodedData, word(1), word(2), word(3), word(4)];
  endfor
  
  retval = mod(decodedData, 2);
endfunction