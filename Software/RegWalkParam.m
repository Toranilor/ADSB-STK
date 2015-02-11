%%Regular Walker Parametric Variation
clear WalkerStruct
clear Alt
clear SatRecord
clear ParamVar
clear Max Min Betw
clear Ending LoopVector i j 

%Initialisation
cd Dev;
SavedScenList
Initialise
ScenName = SanInput('Please input desired scenario name ',nameFolds,'n');
cd ../Results;
mkdir(ScenName)
cd ../Dev;


%%User Input Gathering

Params = input('How many parameters would you like to vary? ');
VarVec = zeros(5,1);
%There's a fair bit going on below;
for i = 1:Params;
    %Firstly, I set up the 'qualifier' that SanInput checks agsinst; the
    %variation runs a string compare for certain strings so this needs to
    %be exact.
    Qualifier = {'SMA','INCLINATION','RAAN','NUMPLANES','NUMSATS'};
    Name = upper(SanInput(['What is the name of parameter ', num2str(i), ' you would like to vary? (Please enter SMA, Inclination, RAAN, NumPlanes or NumSats) '],Qualifier));
    ParamVar.(['Name',num2str(i)]) = Name;
    
    %Here, I need to do a couple of things. Firstly, I create a vector that
    %tells me which parameter is in which order in the ParamVar struct
    %(it's ordered by user entry, not name). I also need to generate some
    %qualifiers for certain parameters to be used in the max/min input.
    
    VarQual = [0;100000000]; %At the moment, SanInput can't handle a null value for the qualifier. For variables that need no qualifier, the qualifier is set to an arbitrarily large range.
    switch Name
        case 'SMA'
            VarVec(1) = i;
        case 'INCLINATION'
            VarVec(2) = i;
            VarQual = [0;180];
        case 'RAAN'
            VarVec(3) = i;
            VarQual = [0;360];
        case 'NUMPLANES'
            VarVec(4) = i;
        case 'NUMSATS'
            VarVec(5) = i;
    end
    
    Min = SanInput('What is the minimum of this parameter? ',VarQual);
    Max = SanInput('What is the maximum of this parameter? ',VarQual);
    Betw = input('How many steps (including max/min) would you like to test ');
    ParamVar.(['Steps',num2str(i)]) = linspace(Min,Max,Betw);
end

%Defining the remaining parameters (I would like to clean this up!)
WalkerStruct.Name = input('Please input desired name of constellation ','s');
if VarVec(1) == 0;
    Alt = input('Please input desired altitude in km ');
    WalkerStruct.SMA = (Alt+6371)*1000; %convert altitude into semi-major axis length
end
if VarVec(2) == 0;
    WalkerStruct.Inc = SanInput('Please input desired inclination of constellations ',[0;180]);
end
if VarVec(3) == 0;
    WalkerStruct.RAAN = SanInput('Please input desired R.A.A.N of constellations ',[0;360]);
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

%The loop vector has the leftmost digit as the most repeating (it loops
%under the ones to it's right)
counter = 0;
while LoopVector(end) ~= Ending(end);
    
    %Creating the Scenario
    scenario = root.Children.New('eScenario',[ScenName,num2str(counter)]);
    %TimeSet;
    
    %%Generation%%
    if VarVec(1) ~= 0;
        WalkerStruct.SMA = ParamVar.(['Steps',num2str(VarVec(1))])(LoopVector(VarVec(1)));
    end
    if VarVec(2) ~= 0;
        WalkerStruct.Inc = ParamVar.(['Steps',num2str(VarVec(2))])(LoopVector(VarVec(2)));
    end
    if VarVec(3) ~= 0;
        WalkerStruct.RAAN = ParamVar.(['Steps',num2str(VarVec(3))])(LoopVector(VarVec(3)));
    end
    if VarVec(4) ~= 0;
        WalkerStruct.NumPlanes = ParamVar.(['Steps',num2str(VarVec(4))])(LoopVector(VarVec(4)));
    end   
    if VarVec(5) ~= 0;
        WalkerStruct.NumSats = ParamVar.(['Steps',num2str(VarVec(5))])(LoopVector(VarVec(5)));
    end   
    
    WalkerGen
    cd .. ;
    
    %Saving the constellation
    cd (['Results/', ScenName]) ;
    mkdir([ScenName,num2str(LoopVector')]);
    cmd = ['Save / * "C:\Users\Tom\Dropbox\Matlab\TomADSB\Utility Development\Results\', ScenName, '\',ScenName,num2str(LoopVector'),'"'];
    root.ExecuteCommand(cmd);
    cd ..;
    cd ../Dev
    
    %Removing the existing constellation
    cmd = 'Unload / *';
    root.ExecuteCommand(cmd);
    
    %Incrementing the counter
    counter = counter+1;
    LoopVector(1) = LoopVector(1) +1;
    for i = 1:(Params-1)
        if LoopVector(i) == Ending(i);
            LoopVector(i) = 1;
            LoopVector(i+1) = LoopVector(i+1) + 1;
        end
    end
end

            

    
