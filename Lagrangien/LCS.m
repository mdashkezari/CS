

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%                                                                        LCS.m  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


seized=zeros(nx,ny);    % An indicator showing if a tracer has left the domain or not. If so, it is seized at its latest location before leaving the domain.      
ftle=inf*ones(nx,ny);
seized=zeros(nx,ny);

field=1;
proceed=true;
itnum=itnum_start;

stop_time=stop_time_day*24*3600;     % in seconds (day to second conversion)

disp(' ')
disp('Advection begins ...')
disp(' ')

while (itnum<=itnum_end) & (proceed)
    disp(' ')
    disp(sprintf('%d: Iteration Number: %10.10d',field, itnum))

    if observation
      V=getV_obs(DataSource,itnum);
      U=getU_obs(DataSource,itnum);
    else
      V=-1.*getU(itnum)';
      U=getV(itnum)';
    end

    [X2,Y2,seized]=Propagator(max_lon,min_lon,max_lat,min_lat,LON,LAT,U,V,T,Tstep,X1,Y1,seized,nx,ny,forward,method);

    elapsed_min= floor(field*T/60);
    elapsed_hour= floor(elapsed_min/60);
    elapsed_day= floor(elapsed_min/(60*24));
    elapsed=sprintf( 'Elapsed time (day:hour:min) %s:%s:%s',  sprintf('%2.2d',elapsed_day), sprintf('%2.2d',elapsed_hour-elapsed_day*24), sprintf('%2.2d',elapsed_min-elapsed_hour*60) );
    disp(['      ', elapsed])


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Dispersion and FSLE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if flgDispersion
      [delta_right, delta_left, delta_up, delta_down] = Dispersion(X2, Y2);
      dispersion = (delta_right+delta_left+delta_up+delta_down)/4;
      %%%%  Finding the max value of separation for each tracer (as opposed to getting averaged value, the line above!)
%      temp=cat(3,delta_right,delta_left,delta_up,delta_down);
%      dispersion=max(temp,[],3);
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   FTLE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    %ftle_mask = seized==1 & ftle==inf;

    for ix=1:nx
        for iy=1:ny
          if seized(ix,iy)==1
            if ftle(ix,iy)==inf
              ftle(ix,iy)=eval_FTLE(ix,iy,X1,Y1,X0,Y0,field*T);
            end
            if ix>1 & ftle(ix-1,iy)==inf
              ftle(ix-1,iy)=eval_FTLE(ix-1,iy,X1,Y1,X0,Y0,field*T);
            end
            if ix<nx & ftle(ix+1,iy)==inf
              ftle(ix+1,iy)=eval_FTLE(ix+1,iy,X1,Y1,X0,Y0,field*T);
            end
            if iy>1 & ftle(ix,iy-1)==inf
              ftle(ix,iy+1)=eval_FTLE(ix,iy-1,X1,Y1,X0,Y0,field*T);
            end
            if iy<ny & ftle(ix,iy+1)==inf
              ftle(ix,iy+1)=eval_FTLE(ix,iy+1,X1,Y1,X0,Y0,field*T);
            end
          end
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



    %%%%%%%%% Total self-separation (displacement of tracers compared to their own initial location) %%%%%%%%%%
    diffX= X2-X0;
    diffY= Y2-Y0;

    %diffX=111180*cos(Y2*pi/180).*diffX;    % convert to meters
    %diffY=111180*diffY;                    % convert to meters 

    displacement = (diffX.^2 + diffY.^2).^ 0.5;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if flgTrajectory
      save(strcat(Trajectory_Path, sprintf('%10.10d_%10.10d.mat',itnum_start,field)));       % save trajectories
    end

    proceed= T*field< stop_time;
    X1=X2;
    Y1=Y2;
    field= field+1;
    itnum= itnum+itnum_step;
end

field= field-1;
itnum= itnum-itnum_step;


%%%%%%%%% Total self-separation (displacement of tracers compared to their own initial location) %%%%%%%%%%
diffX= X2-X0;
diffY= Y2-Y0;

%diffX=111180*cos(Y2*pi/180).*diffX;    % convert to meters
%diffY=111180*diffY;                    % convert to meters 

displacement = (diffX.^2 + diffY.^2).^ 0.5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


disp(' ')
disp(['Tracer(s) advected through ' int2str(field) ' flow fields.'])
disp(elapsed)
disp(' ')
disp(' ')

disp('Calculating the FTLE Matrix ...')
for ix=1:nx
    for iy=1:ny
        if ftle(ix,iy)==inf
           ftle(ix,iy)=eval_FTLE(ix,iy,X2,Y2,X0,Y0,T*field);
        end
    end
end

ftle=ftle*24*60*60;      % per day conversion

disp('FTLE successfully finished!')

