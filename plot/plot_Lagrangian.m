
%figure;
map_title=sprintf('Displacement \n %10.10d',itnum_start);
color_range=[0 6];
map_path=strcat(Displacement_Path,sprintf('%10.10d.png',itnum_start));
plot_map(displacement,lon,lat,Xres,Yres,map_title,color_range,map_path,false,DataSource);

if flgDispersion
%  figure;
  map_title=sprintf('Dispersion \n %10.10d',itnum_start);
  color_range=[0 0.5];
  map_path=strcat(Dispersion_Path,sprintf('%10.10d.png',itnum_start));
  plot_map(dispersion,lon,lat,Xres,Yres,map_title,color_range,map_path,false,DataSource);
end

%figure;
map_title=sprintf('FTLE \n %10.10d',itnum_start);
color_range=[0 0.25];
map_path=strcat(FTLE_Path,sprintf('%10.10d.png',itnum_start));
plot_map(ftle,lon,lat,Xres,Yres,map_title,color_range,map_path,false,DataSource);

%figure;
map_title=sprintf('Tracers Left out the Domain \n %10.10d',itnum_start);
color_range=[];
map_path=strcat(Seized_Path,sprintf('%10.10d.png',itnum_start));
plot_map(seized,lon,lat,Xres,Yres,map_title,color_range,map_path,false,DataSource);
