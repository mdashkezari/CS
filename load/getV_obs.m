%%%%%%%%%%% Absolute Geostrophic Velocity netCDF Format  %%%%%%%%%%%
%  Channel         Variable Name
%  0               crs
%  1               v
%  2               u
%  3               lon
%  4               time
%  5               lat 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%% Geostrophic Velocity Anomally netCDF Format  %%%%%%%%%%%
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


%%%%%%%%%%%%%%%%%%% NETCDF DataFormat of CCRA %%%%%%%%%%%%%%%%%%%%%
%  0               lon
%  1               lat
%  2               ssh
%  3               u_vel
%  4               v_vel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% NETCDF DataFormat of CCRA %%%%%%%%%%%%%%%%%%%%%
%  0               lon
%  1               lat
%  2               ssh
%  3               u_vel
%  4               v_vel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [V] = getV_obs(DataSource,itnum)

if strcmp(DataSource,'AVISO')
    [lon lat V]=getV_AVISO(DataSource,itnum);
  elseif strcmp(DataSource,'HYCOM')
    [lon lat V]=getV_HYCOM(DataSource,itnum);
  elseif strcmp(DataSource,'CCRA')
    [lon lat V]=getV_CCRA(DataSource,itnum);
  end

end



function [lon lat V]=getV_AVISO(DataSource,itnum)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  AVISO  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%[lon lat V]=get_obs(DataSource,1,itnum);    % absolute
[lon lat V]=get_obs(DataSource,0,itnum);    % anomally

V=V/10000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end



function [lon lat V]=getV_HYCOM(DataSource,itnum)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  HYCOM  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[lon lat V]=get_obs(DataSource,10,itnum);
V(find(abs(V)>100))=NaN;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end




function [lon lat V]=getV_CCRA(DataSource,itnum)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  CCRA  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[lon lat V]=get_obs(DataSource,4,itnum);
%V(find(abs(V)>100))=NaN;
V(find(abs(V)>100))=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
