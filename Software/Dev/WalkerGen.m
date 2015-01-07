%WalkerGen Generates a single walker constellation using a 'walker vector'
%   Expected WalkerStruct structure:
%   [Name SemiMajorAxis Inclination RAAN NumPlanes NumSats]

%%Creating the nucleus of the satellite
tempsat = scenario.Children.New('eSatellite',WalkerStruct.Name);
cmd = ['SetState */Satellite/' WalkerStruct.Name ' Classical TwoBody "',scenario.StartTime, '" "', scenario.StopTime,'" 60 ICRF "', scenario.StartTime,'" ' int2str(WalkerStruct.SMA) ' 0 ' int2str(WalkerStruct.Inc) ' 0 ' int2str(WalkerStruct.RAAN)  ' 0'];
root.ExecuteCommand(cmd);

%%Creating a walker constellation from this nucleus
cmd = ['Walker */Satellite/' WalkerStruct.Name ' ' num2str(WalkerStruct.NumPlanes) ' ' num2str(WalkerStruct.NumSats) ' {' num2str(WalkerStruct.NumPlanes -1) '} 360.0 No'];
root.ExecuteCommand(cmd);

%Removing the nucleus
cmd = ['Unload / */Satellite/',WalkerStruct.Name];
root.ExecuteCommand(cmd);

%%Indexing the satellites by name
for n = 1:WalkerStruct.NumPlanes
    for j = 1:WalkerStruct.NumSats
        ZeroPlaneFront = floor(log10(WalkerStruct.NumPlanes)) + 1; %This (with code below) adds the 0 infront of single digit numbers, if the total is more than 10; eg 1,2,3..n becomes 01,02,03 if n>= 10
        ZeroSatFront = floor(log10(WalkerStruct.NumSats)) + 1; 
        A = exist('SatRecord', 'var'); 
        if A == 0
            SatRecord = [WalkerStruct.Name, sprintf(['%0',num2str(ZeroPlaneFront),'d'],n), sprintf(['%0',num2str(ZeroSatFront),'d'],j)];
        else
            SatRecord = strvcat(SatRecord,[WalkerStruct.Name, sprintf(['%0',num2str(ZeroPlaneFront),'d'],n), sprintf(['%0',num2str(ZeroSatFront),'d'],j)]);
        end
    end
end

