function [lon, lat, U, V]=load_data;

%%%%%%%%%%%%% Load Flow Fields   %%%%%%%%%%%%%%%  

t=10368:144:487152;
for i=1:5%size(t,2)       
        U(:,:,i)=getU(t(i));
        V(:,:,i)=getV(t(i));
end
U(find(U==0))=NaN;
V(find(V==0))=NaN;

%%%%%%%%%%%%% Load longitude   %%%%%%%%%%%%%%% 
lon=getXC;
lon=lon(1,:);
lon(find(lon<0))=lon(find(lon<0))+360;

%%%%%%%%%%%%% Load latitude   %%%%%%%%%%%%%%% 
lat=getYC;
lat=lat(:,1);
lat=lat';