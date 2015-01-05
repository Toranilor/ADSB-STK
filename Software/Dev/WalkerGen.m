%WalkerGen Generates a single walker constellation using a 'walker vector'
%   Expected WalkerStruct structure:
%   [Name SemiMajorAxis Inclination RAAN NumPlanes NumSats]

%%Creating the nucleus of the satellite
tempsat = scenario.Children.New('eSatellite',WalkerStruct.Name);
cmd = ['SetState */Satellite/' WalkerStruct.Name ' Classical TwoBody "',scenario.StartTime, '" "', scenario.StopTime,'" 60 ICRF "', scenario.StartTime,'" ' int2str(WalkerStruct.SMA) ' 0 ' int2str(WalkerStruct.Inc) ' 0 ' int2str(WalkerStruct.RAAN)  ' 0'];
root.ExecuteCommand(cmd)

%%Creating a walker constellation from this nucleus
cmd = ['Walker */Satellite/' WalkerStruct.Name ' ' num2str(WalkerStruct.NumPlanes) ' ' num2str(WalkerStruct.NumSats) ' {' num2str(WalkerStruct.NumPlanes -1) '} 360.0 Yes'];
root.ExecuteCommand(cmd)