function plot_tracers(range)

llo=get_lon_obs('CCRA');
lla=get_lat_obs('CCRA');

for field=range

  start_date='07-26-2015';
%  start_date='07-23-2015';
  stamp=datenum(start_date);
  stamp=addtodate(stamp,field-1,'day');
  matdate=datestr(stamp,'yyyymmdd') 
  
  load(sprintf('/nobackup1/mdehghani/llc_4320_hawaii/pics/stdFTLE/CCRA/mats/%s/%10.10d.mat',matdate,1));
  load(sprintf('/nobackup1/mdehghani/llc_4320_hawaii/pics/FTLE/observation/CCRA/mat/%10.10d.mat',field));

[llo lla X1]=Cut_CCRA_Results(get_lon_obs('CCRA'),get_lat_obs('CCRA'),Xres,Yres,150,165,18,26,X1);
[llo lla Y1]=Cut_CCRA_Results(get_lon_obs('CCRA'),get_lat_obs('CCRA'),Xres,Yres,150,165,18,26,Y1);

  %%%%% Cut HOT Area  %%%%%%%%

  lon_off=20;
  lat_off=10;

  X2=X1(1610+lon_off:1650+lon_off,1189+lat_off:1229+lat_off);    %magneta
  Y2=Y1(1610+lon_off:1650+lon_off,1189+lat_off:1229+lat_off);

  X_HOT=X1(1569+lon_off:1609+lon_off,1230+lat_off:1270+lat_off);   %yellow
  Y_HOT=Y1(1569+lon_off:1609+lon_off,1230+lat_off:1270+lat_off);

  X3=X1(1610+lon_off:1650+lon_off,1311+lat_off:1351+lat_off);   %black
  Y3=Y1(1610+lon_off:1650+lon_off,1311+lat_off:1351+lat_off);

  X4=X1(1610+lon_off:1650+lon_off,1230+lat_off:1270+lat_off);   %green
  Y4=Y1(1610+lon_off:1650+lon_off,1230+lat_off:1270+lat_off);

  X5=X1(1651+lon_off:1691+lon_off,1230+lat_off:1270+lat_off);   %red
  Y5=Y1(1651+lon_off:1691+lon_off,1230+lat_off:1270+lat_off);

  X6=X1(1610+lon_off:1650+lon_off,1271+lat_off:1311+lat_off);   %white
  Y6=Y1(1610+lon_off:1650+lon_off,1271+lat_off:1311+lat_off);

%  X7=X1(1380:1420,935:975);   %orang --- Station of ALOHA
%  Y7=Y1(1380:1420,935:975);

  X7=X1(1295:1335,845:885);   %orang
  Y7=Y1(1295:1335,845:885);

%  X7=X1(1260:1300,790:830);   %orang
%  Y7=Y1(1260:1300,790:830);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%

  x=X2(:);
  y=Y2(:);

  x_HOT=X_HOT(:);
  y_HOT=Y_HOT(:);

  x3=X3(:);
  y3=Y3(:);

  x4=X4(:);
  y4=Y4(:);

  x5=X5(:);
  y5=Y5(:);

  x6=X6(:);
  y6=Y6(:);

  x7=X7(:);
  y7=Y7(:);


  %%%%%%%%%%%%% load drifter locations %%%%%%%%%%%%  
  [d1_lon,d1_lat,d2_lon,d2_lat,d3_lon,d3_lat]=load_drifters;
  
  lon_offset=0;
  lat_offset=0;

  d1_lon=d1_lon+lon_offset;
  d1_lat=d1_lat+lat_offset; 
  d2_lon=d2_lon+lon_offset;
  d2_lat=d2_lat+lat_offset;
  d3_lon=d3_lon+lon_offset;
  d3_lat=d3_lat+lat_offset;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  min_lon =  min(llo);
  max_lon =  max(llo);
  min_lat =  min(lla);
  max_lat =  max(lla);
  index_min_lat = 1;
  index_max_lat = size(X1,2);
  index_min_lon = 1;
  index_max_lon = size(X1,1);
%{
  %%%%%%  Transform fromm degree to index %%%%
  a=(index_max_lon-index_min_lon)/(max_lon-min_lon);
  b=index_max_lon-a*max_lon;
  x=a*x+b;
  x_HOT=a*x_HOT+b;
  x3=a*x3+b;
  x4=a*x4+b;
  x5=a*x5+b;
  x6=a*x6+b;

  a=(index_max_lat-index_min_lat)/(max_lat-min_lat);
  b=index_max_lat-a*max_lat;
  y=a*y+b;
  y_HOT=a*y_HOT+b;
  y3=a*y3+b;
  y4=a*y4+b;
  y5=a*y5+b;
  y6=a*y6+b;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%}


  imagesc(llo,lla,ftle');
%imagesc(ftle');
  colorbar;
  %caxis([-0.05 0.3]); 
  caxis([0.01 0.1]);
  %caxis([-0.01 0.3]);
  title({'Tracer Trajectory, Drifter Trajectory, FTLE', matdate});

  hold on

  plot(x,y,'.','Color','m','markers',1);
  plot(x_HOT,y_HOT,'.','Color','y','markers',1);
%  plot(x3,y3,'.','Color','k','markers',1);
  plot(x4,y4,'.','Color','g','markers',1);
  plot(x5,y5,'.','Color','r','markers',1);
  plot(x6,y6,'.','Color','w','markers',1);
  plot(x7,y7,'.','Color',[1 0.5 0.25],'markers',1);

%if field==max(range)
  plot(abs(d1_lon+360),d1_lat,'.','Color','y','markers',5);
  plot(abs(d2_lon+360),d2_lat,'.','Color',[1 0 1],'markers',5);
  plot(abs(d3_lon+360),d3_lat,'.','Color',[1 0 1],'markers',5);      % ALOHA drifter
%end
  axis xy;

  yt=get(gca,'ytick');
  for k=1:numel(yt);
    yt1{k}=sprintf('%d°N',yt(k));
  end
  set(gca,'yticklabel',yt1);

  NumTicks = 16;
  L = get(gca,'XLim');
  set(gca,'XTick',linspace(L(1),L(2),NumTicks))
  set(gca,'FontSize',8);

  xt=get(gca,'xtick');
  for k=1:numel(xt);
    xt1{k}=sprintf('%3.3d°W',round(abs(xt(k)-360)));
  end
  set(gca,'xticklabel',xt1);

  daspect([1,1,1])
  grid on
  set(gca,'Xcolor','k','Ycolor','k','GridLineStyle','-.','LineWidth',1);
  print('-dpng', '-r500', sprintf('/nobackup1/mdehghani/llc_4320_hawaii/pics/FTLE/observation/CCRA/tracer/%10.10d.png',field));

  hold off
  grid off

end














%{


  X2=X1(1610:1650,1189:1229);    %magneta
  Y2=Y1(1610:1650,1189:1229);

  X_HOT=X1(1569:1609,1230:1270);   %yellow
  Y_HOT=Y1(1569:1609,1230:1270);

  X3=X1(1569:1609,1271:1311);   %black
  Y3=Y1(1569:1609,1271:1311);

  X4=X1(1610:1650,1230:1270);   %green
  Y4=Y1(1610:1650,1230:1270);

  X5=X1(1651:1691,1230:1270);   %red
  Y5=Y1(1651:1691,1230:1270);

  X6=X1(1610:1650,1271:1311);   %white
  Y6=Y1(1610:1650,1271:1311);

  X7=X1(1380:1420,935:975);   %orang --- Station of ALOHA
  Y7=Y1(1380:1420,935:975);



%%% before putting most of the tracesrs near the drifters
  X2=X1(1670:1710,750:790);    %magneta
  Y2=Y1(1670:1710,750:790);
  
  X_HOT=X1(1040:1080,895:935);   %yellow
  Y_HOT=Y1(1040:1080,895:935);
  
  X3=X1(1290:1330,920:960);   %black
  Y3=Y1(1290:1330,920:960);
  
  X4=X1(1610:1650,1230:1270);   %green
  Y4=Y1(1610:1650,1230:1270);
  
  X5=X1(1960:2000,1450:1490);   %red
  Y5=Y1(1960:2000,1450:1490);

  X6=X1(1080:1120,1220:1260);   %white
  Y6=Y1(1080:1120,1220:1260);

  X7=X1(1380:1420,935:975);   %orang --- Station of ALOHA
  Y7=Y1(1380:1420,935:975);



%%%%%%%%%   10 days

  X2=X1(1655:1695,760:800);    %magneta
  Y2=Y1(1655:1695,760:800);

%  X_HOT=X1(1020:1060,810:850);   %yellow
%  Y_HOT=Y1(1020:1060,810:850);
  X_HOT=X1(1040:1080,895:935);   %yellow
  Y_HOT=Y1(1040:1080,895:935);

  X3=X1(1110:1150,1250:1290);   %black
  Y3=Y1(1110:1150,1250:1290);

  X4=X1(1610:1650,1230:1270);   %green
  Y4=Y1(1610:1650,1230:1270);

  X5=X1(1910:1950,1310:1350);   %red
  Y5=Y1(1910:1950,1310:1350);

  X6=X1(1260:1300,1290:1330);   %white
  Y6=Y1(1260:1300,1290:1330);

  X7=X1(1380:1420,935:975);   %orang --- Station of ALOHA
  Y7=Y1(1380:1420,935:975);

%}

