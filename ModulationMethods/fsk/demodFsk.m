function retval = demodFsk(receivedSignal, frequency, fs, frequencySeperation)  
  # Calculate amount of samples in one period
  periodLength = 1 / frequency;
  samplesPerPeriod = (periodLength / (1 / fs)) + 1;
  frequency2 = frequency - frequencySeperation;

  # Define carrier
  t = 0 : 1 / fs : periodLength;
  carrier1 = sin(2 * pi * frequency * t);
  carrier2 = sin(2 * pi * frequency2 * t);
  
  
  # Demodulate FSK modulated Signal
  referenceVCOS = {carrier1, carrier2};
  decodingMap = [0, 1];
  decodedData = zeros(1, length(dataSignal));

  # Here we will loop through the lenght of data
  for i = 0 : length(dataSignal) - 1
      lowest = 10000;
      lowestIndex = -1;
      
      y = 0;
      for y = 0 : length(referenceVCOS) - 1
          [referenceVCO] = referenceVCOS{1, y + 1};
          T = 2 * pi / (frequency + y * frequencySeperation) ;

          sectionStart = (i * samplesPerPeriod + 1);
          subtraction = receivedSignal(sectionStart : (sectionStart + samplesPerPeriod - 1)) - referenceVCO(sectionStart : (sectionStart + samplesPerPeriod - 1));
          
          if (sum(abs(subtraction)) < lowest)
            lowest = sum(abs(subtraction));
            lowestIndex = y + 1;
          endif
      end
      
      decodedData(i + 1) = decodingMap(lowestIndex);
  end

  decodedSignal = generateDataSignal(decodedData, pulseWidth);
  retval = decodedData;
endfunction