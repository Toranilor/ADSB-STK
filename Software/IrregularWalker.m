%Irregular Walker
clear WalkerStruct
clear Alt
clear SatRecord

%Initialisation
cd Dev;
Initialise
ScenName = input('Please input desired scenario name ','s');
scenario = root.Children.New('eScenario',ScenName);
TimeSet

%%User Input Gathering
%   This is a 'default' struct, used to initialise
WalkerStruct = struct('Name','Tom','SMA',7200000,'Inc',45,'RAAN',0,'NumPlanes',1,'NumSats',3); 

NumPlanes = input('Please input the desired number of planes ');
SeedName = input('Please input the desired constellation name ','s');
RAANseed = linspace(0,180,(NumPlanes+1));
RAANseed = RAANseed(1:end-1);
disp(['If you would like planes to be evenly spaced, enter ', num2str(RAANseed), ' as the RAAN for each plane'])

for n = 1:NumPlanes
    WalkerStruct.Name = [SeedName,num2str(n)];
    Alt = input(['For Plane ',num2str(n),' please input desired altitude in km ']);
    WalkerStruct.SMA = (Alt+6371)*1000; %convert altitude into semi-major axis length
    WalkerStruct.Inc = input(['For Plane ',num2str(n), ' please input desired inclination ']);
    WalkerStruct.RAAN = input(['For Plane ',num2str(n), ' please input desired R.A.A.N ']);
    WalkerStruct.NumSats = input(['For Plane ', num2str(n), ' please input desired number of satellites ']);
    WalkerGen
end
cd .. ;
    
%%Saving the Walker Constellation
cd Results ;
mkdir(ScenName);
cmd = ['Save / * "C:\Users\Tom\Dropbox\Matlab\TomADSB\Utility Development\Results\', ScenName, '"'];
root.ExecuteCommand(cmd);    
cd ..
cd ..