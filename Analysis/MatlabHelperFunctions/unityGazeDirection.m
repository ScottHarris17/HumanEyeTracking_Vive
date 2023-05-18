function [azimuth, elevation, r] = unityGazeDirection(x, y, z)
r = sqrt(x.^2 + y.^2 + z.^2);
azimuth = asin(x./sqrt(z.^2 + x.^2));
elevation = asin(y./r);

azimuth(isnan(azimuth)) = 0;
elevation(isnan(elevation)) = 0;
r(isnan(r)) = 0;
end
