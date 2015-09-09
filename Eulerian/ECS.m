
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Okubo Weiss %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[iU]=interpolate(LON,LAT,U',X0,Y0); 
%[iV]=interpolate(LON,LAT,V',X0,Y0);
earth_radius = 6400 * 1000;
deg_to_rad = pi / 180;

XC=getXC;
YC=getYC;
deltaXC = (XC(2:end,2:end)-XC(2:end,1:end-1)) * earth_radius * deg_to_rad;
deltaYC = (YC(2:end,2:end)-YC(1:end-1,2:end)) * earth_radius * deg_to_rad;

[OW,sn,ss,vort]=Okubo_Weiss(U',V',deltaXC,deltaYC);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

OW=OW';
vort=vort';

