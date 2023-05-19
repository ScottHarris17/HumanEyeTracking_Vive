function [eyeTrace,eyeTimes, stimulusVelocity, stimulusTimes] = parseExperiment(experimentName, experimentFolderPath)
%PARSEEXPERIMENT extracts data from text files (saved from unity)

%load the eye trace
fID = fopen(fullfile(experimentFolderPath, ['gazeSpace-' experimentName '.txt']), 'r');
eyeTrace = fscanf(fID, '(%f, %f, %f)\n');

%load the eyeTimes
fID = fopen(fullfile(experimentFolderPath, ['gazeTime-' experimentName '.txt']), 'r');
eyeTimes = fscanf(fID, '%f'); %seconds

% load the stimulus absolute timestamps
% fID = fopen(['gratingAbsTime-' experimentName, '.txt'], 'r');
% stimulusAbsTimestamps = fscanf(fID, '%f');

%load the stimulus oscillation
fID = fopen(fullfile(experimentFolderPath, ['gratingSpace-' experimentName, '.txt']), 'r');
stimulusVelocity = fscanf(fID, '%f');

%load the stimulus timestamps
fID = fopen(fullfile(experimentFolderPath, ['gratingTime-' experimentName, '.txt']), 'r');
stimulusTimes = fscanf(fID, '%f');
end

