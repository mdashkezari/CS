function CS(itnum_starts, stop_time_day);


%*****************************    Inputs   ****************************** 
%
%  itnum_starts:    The iteration number of the first flow field file.
%
%  stop_time_day:      The period over which the advection occurs (day)
%
%************************************************************************   

addpath(genpath('./'));  % adding current floder and all subfolders to the matlab path
config_CS;

for flowloop=itnum_starts
  itnum_start=flowloop;
  %******************** Compute Coherent Structures ************************* 
  Compute_CS;
  %************************************************************************** 
  %****************************** Plotting ********************************** 
  if flgPlot
    if flgCrop
      crop;
    end 
    if flgEulerian
      plot_Eulerian;
    end
    if flgLagrangian 
      plot_Lagrangian;
    end 
  end
  %************************************************************************** 
  %******************************** Store ***********************************
  save(strcat(MAT_Path, sprintf('%10.10d.mat',itnum_start)));
  %************************************************************************** 
end
