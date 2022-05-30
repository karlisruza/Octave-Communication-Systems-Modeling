addpath('ModulationMethods/ask');
addpath('ModulationMethods/psk');
addpath('ModulationMethods/fsk');
addpath('ModulationMethods/qam');
addpath('Util');
addpath('NoiseChannels');


ecc = "none";;
noise = "rayleigh";
method = "16qam";

results = []


for i = 0 : 10
  i
  res = runSimulation(method,ecc,noise,num2str(i),"10");
  results = [results, res]
endfor

results

#{
   ASK = [ 0.3138   0.0186   0.0002        0        0        0        0        0        0        0        0        0        0        0        0        0        0        0        0        0 ]       0        0        0        0        0        0        0        0        0        0
   ASK_4 = [0.441636   0.415727   0.392273   0.369455   0.343364   0.310455   0.291364   0.247545   0.229364   0.211818   0.196545   0.177455   0.144727   0.115636   0.108000   0.103636   0.087364   0.075545]   0.069455   0.060182   0.045545   0.050455   0.038636   0.030182   0.029818   0.024273   0.023909   0.017818   0.016364   0.014455]    
   PSK_4 = [0.5127   0.4675   0.4008   0.3501   0.2958   0.2460   0.2073   0.1690   0.1280   0.0979   0.0751   0.0591   0.0339   0.0303   0.0167   0.0075   0.0020   0.0016   0.0001        0        0        0]     0        0        0        0        0        0        0        0
   QAM_16 = [0.1388   0.0654   0.0321   0.0181   0.0072   0.0055   0.0017   0.0007   0.0005   0.0001   0.0001   0.0001        0        0        0        0        0        0        0        0        0        0]        0        0        0        0        0        0        0        0  
#}