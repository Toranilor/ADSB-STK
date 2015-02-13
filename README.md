# ADSB-STK
My attempts to work with STK

RELEASE V0.2 USE GUIDE:

Features:
-Generating a regular walker constellation according to input parameters

-Generating an irregular walker constellation according to input parameters

-Generating a series of parametrically varied regular walker constellations according to input parameters


How to use:

1) Get STK and MATLAB. You should only need the free STK licence.

2) Downlad and install the STK Matlab Connectors;

http://www.agi.com/products/stk/modules/default.aspx/id/integrating-stk-and-matlab

3) Open MATLAB, and run one of the following scripts:

  -RegularWalker for a regular walker constellation
  
  -IrregularWalker for an irregular walker constellation
  
  -RegWalkParam for a parametrically varying walker constellation
  
KNOWN ISSUES:
STK Fails to initialise; This is usually a licence issue, open STK and ensure that you can authenticate.
In RegWalkParam, you can vary the same parameter more than once; this should not happen.
The saving methodology will not work if there is not one scenario saved
