## Copyright (C) 2022 ruzak
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} convertDataToSignal (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: ruzak <ruzak@DESKTOP-C2MQ079>
## Created: 2022-05-04



function retval = modulateAsk(data, frequency, fs)
  # Calculate amount of samples in one period
  periodLength = 1 / frequency;
  samplesPerPeriod = periodLength / (1 / fs);
  
  # Define carrier
  t = 0 : 1 / fs : periodLength;
  carrier = sin(2 * pi * frequency * t);
  
  for i = 0 : length(data) - 1
    if (data(i + 1) == 0)
      modulatedSignal(i + 1) = 0;
    else
      modulatedSignal(i + 1) = carrier(mod(i, samplesPerPeriod) + 1);
    endif
  endfor  
  
  retval = modulatedSignal;
endfunction
