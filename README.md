# Octave-Communication-Systems-Modeling // Bsc CompSci Thesis Source Code

### Initial setup
In order to run the simulation, GNU Octave ClI needs to be installed, and the appropriate paths containing
all the functions defined in the codebase must be added. Additionaly, using octave cli, the following octave
packages need to be loaded running the command 'pkg load <package>' in order to succesfully run all the functions
that make up this communications system model:
- signal
- statistics
- communcations

### Running the simulations  
When the initial setup has been complete, it is now possible to fully execute the master runSimulation command.

The runSimulation method takes the following arguments:
- modulationMethod  - the modulation method used in the simulation
- ecc               - Error correction code to be used for encoding and decoding
- noiseModel        - The noise model applied to the modulated signal
- snr               - Signal to noise ratio, determines the amount of noise added to the modulated signal
- iterations        - The number of times to run the simulation
   

7 different modulation and demodulation methods are implemented, located in the ModulationMethods folder
- ASK   - Amplitude shift keying
- 4ASK  - Amplitude shift keying for modulating 2 bits of data at a time
- BPSK  - Binary phase shift keying
- 4PSK  - Quadrature phase shift keying
- 8QAM  - Quadrature amplitude modulation, using 4 phases and 2 amplitude levels
- 16QAM - Quadrature amplitude modulation, using 4 phases and 4 amplitude levels
- FSK   - Frequency shift keying

To invoke the simulation using a particular method, provide one of the following string values as the modulationMethod value: [ask, 4ask, bpsk, 4psk, 8wam, 16qam]. Unfortunately, the master simulation method is not capable of invoking an fsk simulation.
  
The second argument defines the error correction code to be used, the accepted values are [3s, hamming]. If it's anything else, then no correction code will be used.
  
The third argument is the noise model, currently there are two options - [awgn, rayleigh]

The remaining args are self-explanatory.
