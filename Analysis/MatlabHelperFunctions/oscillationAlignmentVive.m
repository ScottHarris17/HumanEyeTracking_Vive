function allOscillations = oscillationAlignmentVive(stimulusPeriod, firstOscillationStartTime, stimulusTimes, eyeTimes, eyeTrace)
%oscillationAlignmentVive
%Given information about the stimulus and eye trace, this code will break
%up the eye trace into an nxm matrix, where n = the number of oscillations
%and n is the eye trace for that oscillation. Interpolation is performed to
%make all oscillations the same width (i.e. len(m) is the same)
%
%Inputs:
    % - stimulusPeriod: oscillation period in seconds
    % - firstOscillationStartTime: start time in seconds of the first oscillation
    % - stimulusTimes: timestamps for each stimulus frame
    % - eyeTimes: timestamps for each eye tracking frame
    % - eyeTrace: position of the eye across time (eyeTrace and eyeTimes should have the same number of frames)

numCompleteOscillations = floor(eyeTimes(end)/stimulusPeriod);
oscillationStartTime = firstOscillationStartTime; 
oscillationEndTime = oscillationStartTime + stimulusPeriod;
numInterpPoints = 3000;
allOscillations = zeros(numCompleteOscillations, numInterpPoints);
for i = 1:numCompleteOscillations
    [~, oscillationStartFrameStim] = min(abs(stimulusTimes - oscillationStartTime));
    [~, oscillationEndFrameStim] = min(abs(stimulusTimes - oscillationEndTime));
    
    oscillationStartTimeStim = stimulusTimes(oscillationStartFrameStim);
    [~, oscillationStartFrameEye] = min(abs(eyeTimes - oscillationStartTimeStim));
    
    oscillationEndTimeStim = stimulusTimes(oscillationEndFrameStim);
    [~, oscillationEndFrameEye] = min(abs(eyeTimes - oscillationEndTimeStim));

    oscillation_i = eyeTrace(oscillationStartFrameEye:oscillationEndFrameEye);
    oscillation_i = oscillation_i - oscillation_i(1); %normalize
    
    timestamps_i = eyeTimes(oscillationStartFrameEye:oscillationEndFrameEye);
    x_queries = linspace(timestamps_i(1), timestamps_i(end), numInterpPoints);
    interpedOscillation_i = interp1(timestamps_i,oscillation_i,  x_queries);
    allOscillations(i, :) = interpedOscillation_i;
   
    oscillationStartTime = oscillationEndTime;
    oscillationEndTime = oscillationStartTime + stimulusPeriod;
end

end