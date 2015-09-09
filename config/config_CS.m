
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%                                                                   config_CS.m  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



runnumber=4;                % An identifier associated with each run
%run_description='25 days forward Lagrangian analysis with stationary flow field (comapere to run 0000000001 and 0000000002 which are 25 dyas foreward and backward with time dependent flow fifalse)';
run_description='25 days backward Lagrangian analysis (comapere to run 0000000001 which are 25 dyas foreward)';
DataSource='CCRA';          % MITgcm, HYCOM, CCRA

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Flags %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
flgEulerian=false;           % if true, Eulerian algorithms are run
flgLagrangian=true;         % if true, Lagrangian algorithms are run
flgDispersion=true;         % if true, Dispersion algorithms are run
flgHydrography=false;       % if true, gradient of temperature, salinity, and SSH is calculated (currently, this option is only available for MITgcm runs)
flgTrajectory=false;         % if true, the trajectory of tracers are stored
flgPlot=true;               % if true, results are plotted and stored
flgCrop=true;               % if true, the resulting maps are cropped according to crop parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Xres=0.01;  %[];            % spatial resolution. if set to [], the original resolution is used.   
Yres=0.01;  %[];            % spatial resolution. if set to [], the original resolution is used.     
forward= false;              % forward/backward (true/false) temporal integration
method= 2;                  % integration method: Euler (1), Runge-Kutta4 (2)



if strcmp(DataSource,'MITgcm')
  observation=false;         % if true the flow fields from observations are used, otherwise the flow fields of MITgcm are used 
else
  observation=true;
end

if observation
  T= 24*60*60;              % total integration time per flow field (s) 
  Tstep= T;                 % integrator time step (s)
  itnum_step= 1;            % flow field file stamp step    >>>>  setting this parameter to 0 results in stationary flow field calculation  
  itnum_end= 2015250;       % the id of the last flow field file 
else
  T= 20*60;                 % total integration time per flow field (s) 
  Tstep= T;                 % integrator time step (s)
  itnum_step= 144;          % flow field file stamp step 
  itnum_end= 487152;        % the id of the last flow field file 
end


if forward==false
  itnum_step = -abs(itnum_step);
end


crop_lon1= 150;             % if flgCrop=true: this is the initial longitude of the maps (in degrees)
crop_lon2= 165;             % if flgCrop=true: this is the final longitude of the maps (in degrees)
crop_lat1= 18;              % if flgCrop=true: this is the initial latitude of the maps (in degrees)
crop_lat2= 26;              % if flgCrop=true: this is the final latitude of the maps (in degrees)


trunk='/nobackup1/mdehghani/CS_Trunk/';           % The root address where the  MAT files and figures are stored
if exist(trunk)~=7
  mkdir(trunk);
end

trunk=strcat(trunk,sprintf('%10.10d',runnumber),'/');
Lagrangian_Path=strcat(trunk,'Lagrangian/');
MAT_Path=strcat(trunk,'Lagrangian/MAT/');
Trajectory_Path=strcat(trunk,'Lagrangian/MAT/Trajectory/');
Displacement_Path=strcat(trunk,'Lagrangian/Displacement/');
Dispersion_Path=strcat(trunk,'Lagrangian/Dispersion/');
FTLE_Path=strcat(trunk,'Lagrangian/FTLE/');
FSLE_Path=strcat(trunk,'Lagrangian/FSLE/');
Seized_Path=strcat(trunk,'Lagrangian/Seized/');

Eulerian_Path=strcat(trunk,'Eulerian/');
OW_Path=strcat(trunk,'Eulerian/OW/');
Vorticity_Path=strcat(trunk,'Eulerian/Vorticity/');

Hydrography_Path=strcat(trunk,'Hydrography/');
Temperature_Path=strcat(trunk,'Hydrography/Temperature/');
Salinity_Path=strcat(trunk,'Hydrography/Salinity/');
SSH_Path=strcat(trunk,'Hydrography/SSH/');
Temp_Grad_Path=strcat(trunk,'Hydrography/Temperature_Grad/');
Salt_Grad_Path=strcat(trunk,'Hydrography/Salinity_Grad/');
SSH_Grad_Path=strcat(trunk,'Hydrography/SSH_Grad/');

if exist(trunk)~=7
  mkdir(trunk);
  mkdir(Lagrangian_Path);
  mkdir(MAT_Path);
  mkdir(Trajectory_Path);
  mkdir(Displacement_Path);
  mkdir(Dispersion_Path);
  mkdir(FTLE_Path);
  mkdir(FSLE_Path);
  mkdir(Seized_Path);

  mkdir(Eulerian_Path);
  mkdir(OW_Path);
  mkdir(Vorticity_Path);

  mkdir(Hydrography_Path);
  mkdir(Temperature_Path);
  mkdir(Salinity_Path);
  mkdir(SSH_Path);
  mkdir(Temp_Grad_Path);
  mkdir(Salt_Grad_Path);
  mkdir(SSH_Grad_Path);
end

