function retval = rayleighFading (signal, snr)
  rayleighNoise = raylrnd(1, 1, length(signal));
  offset = (max(rayleighNoise) - min(rayleighNoise)) / 2;
  rayleighNoise = rayleighNoise - offset;
  
  # SNR = signalPower / noisePower => noisePower = signalPower / SNR 
  signalPower = rms(signal)^2;
  noisePower = signalPower / snr;
  randomPower = rms(rayleighNoise)^2;
  
  neededRms = sqrt(noisePower);
  rayleighNoise = rayleighNoise * (neededRms / rms(rayleighNoise));
  
  #{
  "RMS"
  rms(rayleighNoise)
  plot(rayleighNoise)
  "AAAA"
  needed = noisePower
  actual = rms(rayleighNoise)^2
  signalPower
  
  snr = signalPower/actual
  #}
  
  retval = signal + rayleighNoise;
endfunction

