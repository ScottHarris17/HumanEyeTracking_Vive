%% Load the experiment with glasses first
experimentName = 'Jeremiah-binary-with';
experimentLocation = 'C:\Users\mrsco\Box\Dunn Lab\Users\Rigs\Human Behavior\HumanEyeTracking_Vive\Data';
stimulusPeriod = 20; %seconds
[eyeTrace_glasses, eyeTimes_glasses, stimulusVelocity_glasses, stimulusTimes_glasses] = parseExperiment(experimentName, experimentLocation);

xs_glasses = eyeTrace_glasses(1:3:numel(eyeTrace_glasses));
ys_glasses = eyeTrace_glasses(2:3:numel(eyeTrace_glasses));
zs_glasses = eyeTrace_glasses(3:3:numel(eyeTrace_glasses));

[azimuth_glasses, elevation_glasses, r] = unityGazeDirection(xs_glasses, ys_glasses, zs_glasses);

elevation_deg_glasses = rad2deg(elevation_glasses);

%smooth the trace (important for getting rid of adjacent frames with the
%exact same value)
eyeTrace_smoothed_glasses = movmean(elevation_deg_glasses, 30);

eyeTrace_glasses_cleaned = rmoutliersEyeTrace(eyeTrace_smoothed_glasses);
allOscillations_glasses = oscillationAlignmentVive(stimulusPeriod, 0, stimulusTimes_glasses, eyeTimes_glasses, eyeTrace_glasses_cleaned);



%% Redo everything for the experiment without glasses
experimentName = 'Jeremiah-binary-without';
experimentLocation = 'C:\Users\mrsco\Box\Dunn Lab\Users\Rigs\Human Behavior\HumanEyeTracking_Vive\Data';
stimulusPeriod = 20; %seconds
[eyeTrace_uncorrected, eyeTimes_uncorrected, stimulusVelocity_uncorrected, stimulusTimes_uncorrected] = parseExperiment(experimentName, experimentLocation);

xs_uncorrected = eyeTrace_uncorrected(1:3:numel(eyeTrace_uncorrected));
ys_uncorrected = eyeTrace_uncorrected(2:3:numel(eyeTrace_uncorrected));
zs_uncorrected = eyeTrace_uncorrected(3:3:numel(eyeTrace_uncorrected));

[azimuth_uncorrected, elevation_uncorrected, r] = unityGazeDirection(xs_uncorrected, ys_uncorrected, zs_uncorrected);

elevation_deg_uncorrected = rad2deg(elevation_uncorrected);

%smooth the trace (important for getting rid of adjacent frames with the
%exact same value)
eyeTrace_smoothed_uncorrected = movmean(elevation_deg_uncorrected, 30);

eyeTrace_uncorrected_cleaned = rmoutliersEyeTrace(eyeTrace_smoothed_uncorrected);
allOscillations_uncorrected = oscillationAlignmentVive(stimulusPeriod, 0, stimulusTimes_uncorrected, eyeTimes_uncorrected, eyeTrace_uncorrected_cleaned);


%% Plot the average oscillations
% recreate a single stimulus oscillation
xvals = linspace(0, stimulusPeriod, 3000);
stimulusTrace = 10*sin(xvals.*2.*pi./stimulusPeriod);

% plot the average eye trace against the stimulus oscillation
SEM_F = @(x) std(x)./sqrt(size(x, 1));
figure
title('Jeremiah 20230518 - Average Oscillations')
hold on
shadedErrorBar(xvals, mean(allOscillations_glasses), SEM_F(allOscillations_glasses), 'lineProps', {'Color', "#77AC30",'LineWidth',3})
shadedErrorBar(xvals, mean(allOscillations_uncorrected), SEM_F(allOscillations_uncorrected), 'lineProps', {'Color', "#D95319",'LineWidth',3})
plot(xvals, stimulusTrace, '-k')
xlabel('Seconds')
ylabel('Degrees')
