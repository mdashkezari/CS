function plot_SSH(DataSource,itnum);
  addpath(genpath('../'));  % adding floder and subfolders to the matlab path

  if strcmp(DataSource,'AVISO')
    plotSSH_AVISO(itnum,DataSource);
  elseif strcmp(DataSource,'HYCOM')
    plotSSH_HYCOM(itnum,DataSource);
  elseif strcmp(DataSource,'CCRA')
    plotSSH_CCRA(itnum,DataSource);
  end

end





function plotSSH_HYCOM(itnum,DataSource);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HYCOM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lon=get_lon_obs(DataSource);
lat=get_lat_obs(DataSource);
SSH=getSSH_obs(DataSource,itnum);

imagesc(abs(lon-360),lat,SSH');
colorbar;
set(gca,'YDir','normal');
set(gca,'XDir','reverse');

xlabel('Longitude');
ylabel('Latitude');

ndt=datestr(now,'dd-mmm-yyyy');  %'20150626';
stamp=datenum(ndt);
ndt=datestr(now,'yyyymmdd'); 
stamp=addtodate(stamp,itnum-1,'day');
dt=datestr(stamp,'yyyymmdd');
if itnum>1
  title({'SSH, HYCOM', strcat(datestr(stamp,'dd-mmm-yyyy'),' (forecast)')})  
else
  title({'SSH, HYCOM', datestr(stamp,'dd-mm-yyyy')})
end

storage_folder=strcat('/nobackup1/mdehghani/llc_4320_hawaii/pics/stdFTLE/HYCOM/',ndt);
if exist(storage_folder)~=7
  mkdir(storage_folder);
end
print('-dpng','-r500',strcat(storage_folder,'/SSH_',dt,'.png')); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end





function plotSSH_CCRA(itnum,DataSource);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CCRA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lon=get_lon_obs(DataSource);
lat=get_lat_obs(DataSource);
SSH=getSSH_obs(DataSource,itnum);

%%%%%
lon=lon(59:125);
lat=lat(23:55);
SSH=SSH(59:125,23:55);
%%%%

imagesc(abs(lon-360),lat,SSH');
colorbar;
set(gca,'YDir','normal');
set(gca,'XDir','reverse');

xlabel('Longitude');
ylabel('Latitude');

 
ndt=datestr(now,'dd-mmm-yyyy'); 
stamp=datenum(ndt);
ndt=datestr(now,'yyyymmdd');
stamp=addtodate(stamp,itnum-1,'day');
dt=datestr(stamp,'yyyymmdd');
title({'SSH, CCAR', datestr(stamp,'dd-mm-yyyy')})

storage_folder=strcat('/nobackup1/mdehghani/llc_4320_hawaii/pics/stdFTLE/CCRA/',ndt);
if exist(storage_folder)~=7
  mkdir(storage_folder);
end
print('-dpng','-r500',strcat(storage_folder,'/SSH_',dt,'.png'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
