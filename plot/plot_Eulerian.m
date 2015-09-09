

figure;
map_title=sprintf('Okubo Weiss Parameter \n %10.10d',itnum_start);
color_range=[];
map_path=strcat(OW_Path,sprintf('%10.10d.png',itnum_start));
plot_map(OW,lon,lat,Xres,Yres,map_title,color_range,map_path,false,DataSource);



figure;
map_title=sprintf('Relative Vorticity \n %10.10d',itnum_start);
color_range=[-4e-5 4e-5];
map_path=strcat(Vorticity_Path,sprintf('%10.10d.png',itnum_start));
plot_map(vort,lon,lat,Xres,Yres,map_title,color_range,map_path,true,DataSource);
