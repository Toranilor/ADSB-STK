%%ScenNames: A script to retrieve any existing scenarios for use as a
%%qualifier in SanInput.
clear nameFolds d isub
d = dir('../Results'); %This script assumes you are within the 'DEV' folder
isub = [d(:).isdir]; % returns logical vector
nameFolds = {d(isub).name};
nameFolds(ismember(nameFolds,{'.','..'})) = []; %Gets rid of the . and ..

