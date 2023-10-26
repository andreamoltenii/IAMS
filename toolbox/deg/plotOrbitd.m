function [X Y Z] = plotOrbitd(orbit, thi, deltaTh, stepTh, mu)
% plotOrbit.m - Plot the arc length deltaTh of the orbit described by
% kepEl.
%
% PROTOTYPE:
% plotOrbit(orbit, thi, deltaTh, stepTh, mu)
%
% DESCRIPTION:
% Plot the arc length of the orbit described by a set of orbital
% elements for a specific arc length.
%
% INPUT:
% kepEl [1x6] orbital elements [km,rad]
% mu [1x1] gravitational parameter [km^3/s^2]
% deltaTh [1x1] arc length [deg]
% stepTh [1x1] arc length step [deg]
%
% OUTPUT:
% X [1xn] X position [km]
% Y [1xn] Y position [km]
% Z [1xn] Z position [km]

if nargin == 4
    mu = 398600.433;
end

Th=thi:stepTh:thi+deltaTh;
for i=1:length(Th)
    r=kep2cartd(orbit ,Th(i) ,mu);
    X(i)=r(1);
    Y(i)=r(2);
    Z(i)=r(3);
end
plot3(X,Y,Z)
end
    





