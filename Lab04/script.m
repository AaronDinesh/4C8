%% a simple single level block matcher
clear
close all
clear

%%%%%%%%%%%%%%% parameters etc %%%%%%%%%%%%%%%%%%%%%%%%

filename    = './qonly.360x288.y';
hres        = 360;  % horizontal size
vres        = 288;  % versical size
B           = 16;   % block size
w           = 4;    % window search range is +/-w 
mae_t       = 2;    % motion threshold MAE per block
start_frame = 1;    
nframes     = 30;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%open the file for reading
fin = fopen(filename,'rb');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% x,y coordimates of the block centres
x = (B/2):B:hres-(B/2); 
y = (B/2):B:vres-(B/2); 

fprintf('processing the sequence\n')
for frame = start_frame:start_frame+nframes-1 
    fprintf(sprintf('frame %03d/%03d\n', frame, nframes))

    fseek(fin,hres*vres*(frame-1),'bof');
    past_frame = double(fread(fin,[hres vres],'uint8')');
    
    fseek(fin,hres*vres*frame,'bof');
    curr_frame = double(fread(fin,[hres vres],'uint8')');
    
    non_mc_dfd(frame) = mae(abs(curr_frame-past_frame)); 
    [bdx, bdy, dfd] = blockmatching(curr_frame, past_frame, B, w, mae_t);
    mc_dfd(frame) = mae(dfd);
end

for frame = start_frame+nframes:50
     fprintf(sprintf('frame %03d/%03d\n', frame, nframes))

    fseek(fin,hres*vres*(frame-1),'bof');
    past_frame = double(fread(fin,[hres vres],'uint8')');
    
    fseek(fin,hres*vres*frame,'bof');
    curr_frame = double(fread(fin,[hres vres],'uint8')');
    
    non_mc_dfd(frame) = mae(abs(curr_frame-past_frame)); 
end

h = tiledlayout(1,1, 'TileSpacing','Compact','Padding','Compact');
nexttile
hold on
plot(non_mc_dfd, 'b-o')
plot(start_frame:start_frame:start_frame+nframes-1, mc_dfd, 'r-*')
xticks(start_frame:1:length(non_mc_dfd))
legend(["Non-MC", "MC"])
title("MAE of the DFD")
xlabel("Frame Number")
ylabel("Mean Absolute Error")
hold off

exportgraphics(h, 'report/Images/MCERR.png', 'BackgroundColor','none')
%% Question 3.2
clear
close all
clear

%%%%%%%%%%%%%%% parameters etc %%%%%%%%%%%%%%%%%%%%%%%%

filename    = './qonly.360x288.y';
hres        = 360;  % horizontal size
vres        = 288;  % versical size
Bmin        = 1;
Bmax        = 6;
w_min       = 1;
w_max       = 8;
w_step      = 1;
mae_t_min   = 1;
mae_t_max   = 4;
mae_t_step  = 0.25;
start_frame = 1;    
nframes     = 10;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%open the file for reading
fin = fopen(filename,'rb');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%set B to be x-axis
%set mae_t to be y-axis
%set w to be z-axis
%set err to be color
mc_mae = zeros(numel(mae_t_min:mae_t_step:mae_t_max), numel(Bmin:1:Bmax), numel(w_min:w_step:w_max));
non_mc_mae = zeros(numel(mae_t_min:mae_t_step:mae_t_max), numel(Bmin:1:Bmax), numel(w_min:w_step:w_max));
non_mc_dfd = zeros(1, nframes);
mc_dfd = zeros(1, nframes);

for mae_t=[3]
    for B=[16]
        for w=[8]
            tstart = tic;
            for frame = start_frame:start_frame+nframes-1 
                fprintf(sprintf('frame %03d/%03d\n', frame, nframes))
            
                fseek(fin,hres*vres*(frame-1),'bof');
                past_frame = double(fread(fin,[hres vres],'uint8')');
                
                fseek(fin,hres*vres*frame,'bof');
                curr_frame = double(fread(fin,[hres vres],'uint8')');
                
                non_mc_dfd(frame) = mae(abs(curr_frame-past_frame)); 
                [~, ~, dfd] = blockmatching(curr_frame, past_frame, B, w, mae_t);
                mc_dfd(frame) = mae(dfd);
            end
            fprintf(sprintf('Motion Threshold: %d, Block Size: %d, Window Search Range: %d, MC-MAE: %f, NMC-MAE: %f, Time Taken: %f', mae_t, B, w, mae(mc_dfd), mae(non_mc_dfd), toc(tstart)))
        end
    end
end



