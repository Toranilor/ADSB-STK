%%Regular Walker Parametric Variation
clear WalkerStruct
clear Alt
clear SatRecord
clear ParamVar
clear Max Min Betw

%Initialisation
%cd Dev;
%Initialise
%ScenName = input('Please input desired scenario name convention ','s');

%%User Input Gathering
%   This is a 'default' struct, used to initialise
WalkerStruct = struct('Name','Tom','SMA',7200000,'Inc',45,'RAAN',0,'NumPlanes',2,'NumSats',3); 
Params = input('How many parameters would you like to vary? ');
for i = 1:Params;
    Name = upper(input(['What is the name of parameter ', num2str(i), ' you would like to vary? '],'s'));
    ParamVar.(['Name',num2str(i)]) = Name;
    Min = input('What is the minimum of this parameter? ');
    Max = input('What is the maximum of this parameter? ');
    Betw = input('How many steps (including max/min) would you like to test ');
    ParamVar.(['Steps',num2str(i)]) = linspace(Min,Max,Betw);
end

%Create a matrix showing which parameters are to be varied; VarVec will
%show which 'number' each parameter is in ParamVar
%Key:
%1 = SMA
%2 = Inclination
%3 = RAAN
%4 = NumPlanes
%5 = NumSats
VarVec = zeros(5,1);
for i = 1:Params;
    switch ParamVar.(['Name',num2str(i)]);
        case 'SMA'
            VarVec(1) = i;
        case 'INCLINATION'
            VarVec(2) = i;
        case 'RAAN'
            VarVec(3) = i;
        case 'NUMPLANES'
            VarVec(4) = i;
        case 'NUMSATS'
            VarVec(5) = i;
    end
end

%Defining the remaining parameters (I would like to clean this up!)
WalkerStruct.Name = input('Please input desired name of constellation ','s');
if VarVec(1) == 0;
    Alt = input('Please input desired altitude in km ');
    WalkerStruct.SMA = (Alt+6371)*1000; %convert altitude into semi-major axis length
end
if VarVec(2) == 0;
    WalkerStruct.Inc = input('Please input desired inclination of constellations ');
end
if VarVec(3) == 0;
    WalkerStruct.RAAN = input('Please input desired R.A.A.N of constellations ');
end
if VarVec(4) == 0;
    WalkerStruct.NumPlanes = input('Please input desired number of planes of constellations ');
end
if VarVec(5) == 0;
    WalkerStruct.NumSats = input('Please input desired number of satellites per plane of constellations ');
end

%%%%Creating the scenarios%%%%
LoopVector = ones(Params,1);

%Generating the incecies ending vector
for i = 1:Params
    Ending(i) = length(ParamVar.(['Steps',num2str(i)]))+1;
end
%This while loop something something
%The loop vector has the leftmost digit as the most repeating (it loops
%under the ones to it's right)
while LoopVector(end) ~= Ending(end);
    
    %%GENERATION GOES HERE%%
    
    %Incrementing the counter
    LoopVector(1) = LoopVector(1) +1;
    for i = 1:(Params-1);
        if LoopVector(i) == Ending(i);
            LoopVector(i) = 1;
            LoopVector(i+1) = LoopVector(i+1) + 1;
        end
    end
end

            

    
