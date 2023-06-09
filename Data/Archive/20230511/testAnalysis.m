experimentName = 'Jeremiah-red-green-extrahighsf-wo';

%load the eye trace
fID = fopen(['gazeSpace-' experimentName '.txt'], 'r');
eyeTrace = fscanf(fID, '(%f, %f, %f)\n');

%load the eyeTimes
fID = fopen(['gazeTime-' experimentName '.txt'], 'r');
eyeTimes = fscanf(fID, '%f'); %seconds

%load the stimulus absolute timestamps
fID = fopen(['gratingAbsTime-' experimentName, '.txt'], 'r');
stimulusAbsTimestamps = fscanf(fID, '%f');

%load the stimulus oscillation
fID = fopen(['gratingSpace-' experimentName, '.txt'], 'r');
stimulusSpace = fscanf(fID, '%f');

%load the stimulus timestamps
fID = fopen(['gratingTime-' experimentName, '.txt'], 'r');
stimulusTimestamps = fscanf(fID, '%f');


xs = eyeTrace(1:3:numel(eyeTrace));
ys = eyeTrace(2:3:numel(eyeTrace));
zs = eyeTrace(3:3:numel(eyeTrace));

[azimuth, elevation, r] = unityGazeDirection(xs, ys, zs);

elevation_deg = rad2deg(elevation);

%remove outliers
eyeVelocity = diff(elevation_deg); %deg/frame
outliers = find(abs(zscore(eyeVelocity)) > 2);
windowSize = 5;
for i = 1:numel(outliers)
    if outliers(i) < windowSize - 1
        eyeVelocity(outliers(i)) = 0;
    else
        eyeVelocity(outliers(i)) = mean(eyeVelocity(outliers(i)-windowSize:outliers(i)-1));
    end
end

eyeTrace_integrated = cumtrapz(eyeVelocity);


%smoothedVert = movmean(elevation, 5);
plot(eyeTimes(2:end), eyeTrace_integrated, '-r');
hold on
plot(stimulusTimestamps, stimulusSpace, '-k');
