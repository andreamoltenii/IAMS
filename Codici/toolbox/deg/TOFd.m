function [ dt ] = TOFd( orbit , thi , thf , mu ) 
% TOF.m - Flight time to move between two positions on the same
% orbit
%
% PROTOTYPE:
% [ dt ] = TOF ( a , e , thi , thf )
%
% DESCRIPTION:
% Calculates flight time to move between two positions on the same orbit
% give the angles thi and thf in degrees. Only first 2 inputs needed to get revolution
% period.
% 
%
% INPUT:
% a [1x1] Semi-major axis [km]
% e [1x1] Eccentricity [-]
% thi [1x1] Initial true anomaly [deg]
% thf [1x1] Final true anomaly [deg]
%
% OUTPUT:
%
% dt [1x1] Flight time [s]
%
%
if nargin <= 3
    mu = 398600.433 ;
end 

a = orbit.a;
e = orbit.e;


n = sqrt ( mu / a ^ 3 ) ;

% Calculate period when given only a and e 
if nargin == 1 
    dt = 2 * pi / n ;
end

% Eccentric anomaly sine
sinEi = ( sqrt( 1 - e ^ 2 ) *  sind ( thi ) ) / ( 1 + e * cosd ( thi ) ) ;
sinEf = ( sqrt( 1 - e ^ 2 ) *  sind ( thf ) ) / ( 1 + e * cosd ( thf ) ) ;
half_tanEi = sqrt ( ( 1 - e ) / ( 1 + e ) ) * tand ( thi / 2 ) ;
half_tanEf = sqrt ( ( 1 - e ) / ( 1 + e ) ) * tand ( thf / 2 ) ;

% Eccentric anomaly
Ei = 2 * atan ( half_tanEi ) ;
Ef = 2 * atan ( half_tanEf ) ;


% Kepler equation
dM = Ef - Ei - e * ( sinEf - sinEi ) ;

if thf >= thi
    dt = dM / n ; 

    % condition to compensate for atan range -90 90

    if thf > 180 && thf < 360
        dt = dt + floor ( ( ( thf - 180 ) / 360 ) + 1 ) * 2 * pi / n ;
    end
else 
    dt = - dM / n   + 2 * pi / n ;

    % condition to compensate for atan range -90 90

    if thf > 180 
        dt = dt  + floor ( ( ( thi - 180 ) / 360 ) + 1 ) * 2 * pi / n ;
    end
end

end
