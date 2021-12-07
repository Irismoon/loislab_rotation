function timeLapse = align_video_stim(video_start_time,stim_time)
%function timeLapse = align_video_stim(video_start_time,stim_time)
video_start_time = datetime(video_start_time,'InputFormat','yyyy-MM-dd HH:mm:ss');
stim_time = stim_time(~cellfun(@isempty,stim_time));
[h,m,s] = cellfun(@(x) hms(x-video_start_time),stim_time);
timeLapse = [h,m,s];
end