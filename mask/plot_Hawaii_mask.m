function plot_Hawaii_mask()

mask_lon_min=150;
mask_lon_max=165;
mask_lat_min=18;
mask_lat_max=26;

load('Hawaii.mat');
[rows cols]=find(mask_Hawaii);
mlon=mask_lon(cols);
mlat=mask_lat(rows);
hold on
plot(mlon,mlat,'.','MarkerSize',3,'Color','m')
xlim([360-mask_lon_max,360-mask_lon_min])
ylim([mask_lat_min,mask_lat_max])
daspect([1 1 1]);
%axis off;
hold off;
