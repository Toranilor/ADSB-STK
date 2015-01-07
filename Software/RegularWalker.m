%%Walker Generator Utility
clear WalkerStruct
clear Alt
clear SatRecord

%Initialising Everything
cd Dev;
Initialise
ScenName = input('Please input desired scenario name ','s');
scenario = root.Children.New('eScenario',ScenName);
TimeSet

%%User Input Gathering
%   This is a 'default' struct, used to initialise
WalkerStruct = struct('Name','Tom','SMA',7200000,'Inc',45,'RAAN',0,'NumPlanes',2,'NumSats',3); 

WalkerStruct.Name = input('Please input desired name of constellation ','s');
Alt = input('Please input desired altitude in km ');
WalkerStruct.SMA = (Alt+6371)*1000; %convert altitude into semi-major axis length
WalkerStruct.Inc = input('Please input desired inclination of constellation ');
WalkerStruct.RAAN = input('Please input desired R.A.A.N of constellation ');
WalkerStruct.NumPlanes = input('Please input desired number of planes of constellation ');
WalkerStruct.NumSats = input('Please input desired number of satellites per plane of constellation ');

%%Generating the Walker Constellation
WalkerGen
cd .. ;

%%Saving the Walker Constellation
cd Results ;
mkdir(ScenName);
cmd = ['Save / * "C:\Users\Tom\Dropbox\Matlab\TomADSB\Utility Development\Results\', ScenName, '"'];
root.ExecuteCommand(cmd);