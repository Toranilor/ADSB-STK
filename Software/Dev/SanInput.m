function [ outputs ] = SanInput(string, qualifier, varargin)
%%Function will prompt input using string, and compare to qualifier; it
%%must match a single number, be between two numbers, or match to one of a
%%series of strings, depending on what qualifier is

%If Varargin is blank, a 'match' will be sought
%If Varargin is 'n', a non-match will be sought

%Ranges are to be entered as [A;B]

errorcheck = 0;

%Definitions of cases
nonmatch = 'n';

if nargin == 2
    %We check for a match
    %Check for a numeric or string qualifier
    outputs = 999999999999999999999; %Set to an arbitrarily large number that will trip qualifying conditions
    if isnumeric(qualifier) == 1;
        %Single Qualifier
        if size(qualifier) == 1;
            while outputs ~= qualifier;
                if errorcheck == 1;
                    disp(['Input not of required value ', num2str(qualifier)]);
                end
                outputs = input(string);
                errorcheck = 1;
            end
        %Qualifying Range
        else if size(qualifier) == [2 1];
                while outputs < qualifier(1) | outputs > qualifier(2);
                    if errorcheck == 1;
                        disp(['Input not in required range ', num2str(qualifier')]);
                    end
                    outputs = input(string);
                    errorcheck = 1;
                end 
            end
        end
    else    
        %String Qualifier (tries to match outputs with a qualifier)
        qualifier = upper(qualifier);
        outputs = 'THERE IS NO WAY THIS IS THE QUALIFIER';
        while isempty(strmatch(outputs,qualifier,'exact')) == 1; 
            if errorcheck == 1;
                disp(['Input not of specified string; ',qualifier]);
            end
            outputs = upper(input(string,'s'));
            errorcheck = 1;
        end
    end
else
    switch char(varargin(1));
        case nonmatch
            %We check for a nonmatch
            %Check for a numeric or string qualifier
            if isnumeric(qualifier) == 1;
                %Single Qualifier
                if size(qualifier) == 1;
                    outputs = qualifier; %need to initialise as the 'match' case
                    while outputs == qualifier;
                        if errorcheck == 1;
                            disp(['Input is of forbidden value ', num2str(qualifier)]);
                        end
                        outputs = input(string);
                        errorcheck = 1;
                    end
                %Qualifying Range
                else if size(qualifier) == [2 1];
                        outputs = qualifier(1);%need to initialise as the 'match' case
                        while outputs > qualifier(1) | outputs < qualifier(2);
                            if errorcheck == 1;
                            disp(['Input within forbidden range ', num2str(qualifier')]);
                            end
                        outputs = input(string);
                        errorcheck = 1;
                        end 
                    end
                end
            else    
                %String Qualifier (tries to match outputs with a qualifier)
                qualifier = upper(qualifier);
                outputs = qualifier(1);
                while isempty(strmatch(outputs,qualifier,'exact')) ~= 1; %Does this work??
                    if errorcheck == 1;
                        disp('That name is in use');
                    end
                    outputs = upper(input(string,'s'));
                    errorcheck = 1;
                end
            end   
    end
end
end

