%%Walker Generator Utility
clear WalkerStruct
clear Alt
clear SatRecord

%Initialising STK and creating a scenario
cd Dev;
SavedScenList
Initialise
ScenName = SanInput('Please input desired scenario name ',nameFolds,'n');
scenario = root.Children.New('eScenario',ScenName);
TimeSet

%%User Input Gathering
%   This is a 'default' struct, used to initialise
WalkerStruct = struct('Name','Tom','SMA',7200000,'Inc',45,'RAAN',0,'NumPlanes',2,'NumSats',3); 

WalkerStruct.Name = input('Please input desired name of constellation ','s');
Alt = input('Please input desired altitude in km ');
WalkerStruct.SMA = (Alt+6371)*1000; %convert altitude into semi-major axis length
WalkerStruct.Inc = SanInput('Please input desired inclination of constellation ',[0;180]);
WalkerStruct.RAAN = SanInput('Please input desired R.A.A.N of constellation ',[0;360]);
WalkerStruct.NumPlanes = input('Please input desired number of planes of constellation ');
WalkerStruct.NumSats = input(' Please input desired number of satellites ' );


%%Generating the Walker Constellation
WalkerGen
cd .. ;

%%Saving the Walker Constellation
cd Results ;
mkdir(ScenName);
cmd = ['Save / * "C:\Users\Tom\Dropbox\Matlab\TomADSB\Utility Development\Results\', ScenName, '"'];
root.ExecuteCommand(cmd);
cd ..;