function lat=get_lat

lat=getYC;
lat=lat(:,1);
lat=lat';

%%%%%%% Degrading Resolution %%%%%
%lat=lat(1:20:end-1);
