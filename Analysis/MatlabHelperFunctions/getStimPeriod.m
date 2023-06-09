function stimPeriod = getStimPeriod(experimentLocation)
meta = importdata(fullfile(experimentLocation, 'meta.txt'));
dataStruct = jsondecode(meta{1});
stimPeriod = dataStruct.period;
end