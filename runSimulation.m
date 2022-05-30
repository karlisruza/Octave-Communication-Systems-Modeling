function retval = runSimulation(modulationMethod, ecc, noiseModel, snr, iterations)  
  # import pathsep
  addpath('ModulationMethods/ask');
  addpath('ModulationMethods/psk');
  addpath('ModulationMethods/fsk');
  addpath('ModulationMethods/qam');
  
  # Check args
  if (
    !exist("modulationMethod", "var")
    || !exist("ecc", "var")
    || !exist("noiseModel", "var")
    || !exist("snr", "var")
    || !exist("iterations", "var")
  )
    disp("Invalid arguments provided, please provide the modulationMethod, error correction code, noise model, snr and iteration count!");
    return;
  endif

  # Define basic properties
  frequency = 400;
  fs = frequency * 20;
  periodLength = 1 / frequency;
  samplesPerPeriod = periodLength / (1 / fs);

  # Load input data from file
  if (length(modulationMethod) == 4 && modulationMethod == "8qam")
    fd = fopen('TestData/input3.txt');
  else
    fd = fopen('TestData/input.txt');
  endif
  data = rot90(fread(fd) - 48);
  
  # Error correction code encoding
  switch (ecc)
    case "3s"
      encodedData = encode3s(data);  
    case "hamming"
      encodedData = encodeHamming47(data);  
    otherwise
      encodedData = data;  
  endswitch
    
  # Convert data to sigal form
  dataSignal = dataToSignal(encodedData, samplesPerPeriod);
  
  # Encode with modlation method
  switch (modulationMethod)
    case "ask"
      modulatedSignal = modulateAsk(dataSignal, frequency, fs); 
    case "4ask"
      modulatedSignal = modulate4Ask(dataSignal, frequency, fs); 
    case "bpsk"
      modulatedSignal = modulateBpsk(dataSignal, frequency, fs);  
    case "4psk"
      modulatedSignal = modulate4psk(dataSignal, frequency, fs);
    case "8qam"
      modulatedSignal = modulate8qam(dataSignal, frequency, fs);
    case "16qam"
      modulatedSignal = modulate16qam(dataSignal, frequency, fs);
    otherwise
      disp("Invalid modulation method provided, provide one of the following as an argument:");
      disp("ask");
      disp("4ask");
      disp("bpsk");
      disp("4psk");
      disp("8qam");
      disp("16qam");
      return;
  endswitch
    
  errors = [];
  for i = 0 : str2num(iterations)
    # Simulate transmission
    switch (noiseModel)
      case "awgn"
        receivedSignal = awgn(modulatedSignal, str2num(snr), 'measured');
      case "rayleigh"
        receivedSignal = rayleighFading(modulatedSignal, str2num(snr));
      otherwise
        disp("Invalid ecc argument provided, applying awgn");
        receivedSignal = awgn(modulatedSignal, str2num(snr));
    endswitch 
    
    #plot(receivedSignal);
        
    # Demodulate Signal
    switch (modulationMethod)
      case "ask"
        demodulatedSignal = demodAsk(receivedSignal, frequency, fs); 
      case "4ask"
        demodulatedSignal = demod4Ask(receivedSignal, frequency, fs);
      case "bpsk"
        demodulatedSignal = demodBpsk(receivedSignal, frequency, fs);  
      case "4psk"
        demodulatedSignal = demod4psk(receivedSignal, frequency, fs);
      case "8qam"
        demodulatedSignal = demod8qam(receivedSignal, frequency, fs);
      case "16qam"
        demodulatedSignal = demod16qam(receivedSignal, frequency, fs);
      otherwise
        demodulatedSignal = [];
    endswitch
    
    # Convert signal to data
    decodedData = signalToData(demodulatedSignal, samplesPerPeriod);
    
    # Error correction code decoding
    switch (ecc)
      case "3s"
        decodedData = decode3s(decodedData);  
      case "hamming"
        decodedData = decodeHamming47(decodedData);  
      otherwise
        decodedData;  
    endswitch
    
    # Calculate BER
    [ber, percent] = biterr(data, decodedData)
    errors = [errors, percent];
  endfor
  
  retval = sum(errors) / length(errors)
endfunction
