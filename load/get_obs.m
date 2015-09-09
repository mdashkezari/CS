%%%%%%%%%%% Absolute Geostrophic Velocity netCDF Format  %%%%%%%%%%%
%  Channel         Variable Name
%  0               crs
%  1               v
%  2               u
%  3               lon
%  4               time
%  5               lat 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%% Geostrophic Velocity Anomally netCDF Format  %%%%%%%%%%%geoVel_global_wrt_mean_
%  Channel         Variable Name
%  0               v
%  1               u
%  2               lon
%  3               time
%  4               lat 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%  NETCDF DataFormat of HYCOM %%%%%%%%%%%%%%%%%%%%
%  Channel          Variable Name
%  0                MT 
%  1                Date 
%  2                Y
%  3                X
%  4                lat
%  5                lon
%  6                ice_coverage
%  7                ice_thickness
%  8                ssh
%  9                u_barotropic_velocity 
%  10               v_barotropic_velocity
%  11               surface_boundary_layer
%  12               mixed_layer_thickness
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [lon lat data]=get_obs(DataSource,channel,iteration)
  
  if strcmp(DataSource,'AVISO')
    [lon lat data]=get_AVISO(channel,iteration);
  elseif strcmp(DataSource,'HYCOM')
    [lon lat data]=get_HYCOM(channel,iteration);
  elseif strcmp(DataSource,'CCRA')
    [lon lat data]=get_CCRA(channel,iteration);
  end  

end






function [lon lat data]=get_AVISO(channel,iteration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  AVISO  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%path='/nobackup1/mdehghani/obs/AVISO/uv_abs/uv_abs_1993_01_01_2014_10_24.nc';                 % absolute
path='/nobackup1/mdehghani/obs/AVISO/uv_anomally/uv_anomally_2014_04_10_2015_05_04.nc';      % anomally
ncid=netcdf.open(path);
%{
%%%%%%%%%%%% absolute %%%%%%%%%%%%
lon=double(netcdf.getVar(ncid,3));
lat=double(netcdf.getVar(ncid,5));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%}

%%%%%%%%%%%% anomally %%%%%%%%%%%%
lon=double(netcdf.getVar(ncid,2));
lat=double(netcdf.getVar(ncid,4));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data=double(netcdf.getVar(ncid,channel));

%lon=lon(750:840);
%lat=lat(425:480);
%data=data(750:840,425:480,iteration);geoVel_global_wrt_mean_

data=data(:,:,iteration);
data(find(abs(data)>2147483646))=NaN;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end




function [lon lat data]=get_HYCOM(channel,iteration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  HYCOM  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
today_folder=datestr(now,'YYYYmmdd');
%today_folder='20150625';

if iteration==1
  path=strcat('/nobackup1/mdehghani/obs/HYCOM/',today_folder,'/rtofs_glo_2ds_n024_3hrly_diag.nc'); 
else
  path=strcat('/nobackup1/mdehghani/obs/HYCOM/',today_folder,'/rtofs_glo_2ds_f',sprintf('%0.3d',iteration*24),'_3hrly_diag.nc');     
end


ncid=netcdf.open(path);

lon=double(netcdf.getVar(ncid,5));
lat=double(netcdf.getVar(ncid,4));

data=double(netcdf.getVar(ncid,channel));

lon=lon(1400:1700,1720:1900);
lat=lat(1400:1700,1720:1900);
data=data(1400:1700,1720:1900);

%[numdims,numvars,numglobalatts,unlimdimid] = netcdf.inq(ncid)
%[name,xtype,dimids,natts] = netcdf.inqVar(ncid,channel)

%data(find(abs(data)>100))=NaN;
lon=lon(:,1);
lat=lat(1,:);
lat=lat';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end




function [lon lat data]=get_CCRA(channel,iteration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  CCRA  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%offset=doy(now)-1;   
%path=strcat('/nobackup1/mdehghani/obs/CCAR/GeoVel/geoVel_global_wrt_mean_',datestr(now,'yyyy'),sprintf('%3.3d',offset+iteration-1),'.nc')
path=strcat('/nobackup1/mdehghani/obs/CCAR/GeoVel/geoVel_global_wrt_mean_',sprintf('%7.7d',iteration),'.nc');

ncid=netcdf.open(path);

lon=double(netcdf.getVar(ncid,0));
lat=double(netcdf.getVar(ncid,1));
data=double(netcdf.getVar(ncid,channel));

%{
lon=lon(745:845);
lat=lat(335:385);
data=data(745:845,335:385);
%}

%{
lon=lon(780:840);
lat=lat(337:369);
data=data(780:840,337:369);
%}

lon=lon(720:870);
lat=lat(315:405);
data=data(720:870,315:405);

%[numdims,numvars,numglobalatts,unlimdimid] = netcdf.inq(ncid)
%[name,xtype,dimids,natts] = netcdf.inqVar(ncid,channel)

%data(find(abs(data)>100))=NaN;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
