function shiftedTrace = shiftEyeTrace(phaseShift_deg, eyeTrace)
%shift a circular eye trace by a certain number of degrees. This is meant
%for sinusoidal eye traces where, for example, you want to turn a sine eye
%trace into a cosine eye trace. This is meant for SINGLE oscillations (not
%multiple oscillations back to back).
% Inputs:
% - phaseShift_deg: number of degrees that you would like to shift the eye trace by (best practice is to keep this between -180 and 180, but it's not necessary)
% - eyeTrace: row vector containing the eye position across time for a SINGLE oscillation

stimulusDegreesTarget = mod(linspace(phaseShift_deg, phaseShift_deg + 360 , numel(eyeTrace)), 360);
stimulusDegreesOriginal = linspace(0, 360, numel(eyeTrace));

shiftIndices = zeros(numel(eyeTrace), 1);
for i = 1:numel(shiftIndices)
    [~, shiftIndices(i)] = min(abs(stimulusDegreesOriginal - stimulusDegreesTarget(i)));
end

%turn into velocities, reorganize, then reintegrate
velocitiesOriginal = diff(eyeTrace);
velocitiesNew = zeros(size(velocitiesOriginal));
for i = 1:numel(velocitiesNew)
    velocitiesNew(i) = velocitiesOriginal(shiftIndices(i));
end
shiftedTrace = [0, cumtrapz(velocitiesNew)];

end