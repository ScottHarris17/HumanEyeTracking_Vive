function cleanedTrace = rmoutliersEyeTrace(trace)
% Removes outliers from the eye trace (including most saccades)
% trace - eye trace (column vector time series)
% cutoff - speed (deg/frame) or z score (see code block below) above which is removed from the eye trace

eyeVelocity = diff(trace); %deg/frame
%outliers = find(abs(zscore(eyeVelocity)) > 2); %z score approach
iqrVelocity = iqr(eyeVelocity);
cutoff = 2*iqrVelocity + median(eyeVelocity);
outliers = find(abs(median(eyeVelocity) - eyeVelocity) > cutoff);
eyeVelocity(outliers) = 0;

%windowSize = 100;
% for i = 1:numel(outliers)
%     if outliers(i) < windowSize - 1
%         eyeVelocity(outliers(i)) = 0;
%     else
%         eyeVelocity(outliers(i)) = mean(eyeVelocity(outliers(i)-windowSize:outliers(i)-1));
%     end
% end

% reintegrate the eye trace
cleanedTrace = cumtrapz(eyeVelocity);
cleanedTrace = [cleanedTrace(1); cleanedTrace]; %add one value to make the reintegrated trace the correct length

end



