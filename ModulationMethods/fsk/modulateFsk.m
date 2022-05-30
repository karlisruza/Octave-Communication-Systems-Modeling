function retval = fsk (dataSignal, frequency, fs, frequencySeperation)
  # Calculate amount of samples in one period
  periodLength = 1 / frequency;
  samplesPerPeriod = (periodLength / (1 / fs)) + 1;

  # Define carrier
  t = 0 : 1 / fs : periodLength;
  carrier1 = sin(2 * pi * frequency * t);
  carrier2 = sin(2 * pi * (frequency - frequencySeperation) * t);

  # Generate the modulated Wave
  for i = 1 : length(dataSignal)
      waveSample = mod(i, samplesPerPeriod);
      if(waveSample == 0)
        waveSample = samplesPerPeriod;
      endif
    
      if dataSignal(i) == 0
          modulatedSignal(i) = carrier1(waveSample);
      else
          modulatedSignal(i) = carrier2(waveSample);
      end
  end
  
  retval = modulatedSignal;
endfunction