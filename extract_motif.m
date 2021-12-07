%% settings
fs = 44100;
%%
%bird->days->
%run bo's segmentation for each day of each bird
%select template for each bird
%run the current code
% birdinfo = dir('D://birds');
% birdinfo(arrayfun(@(i) ismember(birdinfo(i).name,{'.','..','juvenile'}),1:length(birdinfo))) = [];
birdname = {'B183_400days','Or144_500days','Or163_100days','Or165_100days','P199_200days','P234_200days'};
birdpath = cellfun(@(x) ['D://birds/' x],birdname,'un',0);
nbird = length(birdpath);
%1.B183,2.Or144,3.Or163 4.Or165, 5.P199, 6.P234
bird_template_path = {'/400/Bouts/B183_43744.30029123_10_6_8_20_29_25.wav',...
    '/514/Bouts/Or144_44253.21892183_2_26_6_4_52_1.5.wav',...
    '/103/Bouts/Or163_44248.22335801_2_21_6_12_15_0.wav',...
    '/111/Bouts/Or165_44256.23957169_3_1_6_39_17_18.wav',...
    '/208/Bouts/P199_44108.27948961_10_4_7_45_48_6.wav',...
    '/207/Bouts/P234_44098.34195639_9_24_9_29_55_6.wav'};
template_onoff_set = [1.89 2.67;1.7 2.65;1.43 2.25;1.19 1.95;1.34 2.11;0.99 1.86];
%% loop for bird
for ibird = 3:nbird
    %%
    bird_templatepath = [birdpath{ibird} bird_template_path{ibird}];
    days_folderinfo = dir(birdpath{ibird});
    days_folderinfo = days_folderinfo(~arrayfun(@(i) ismember(days_folderinfo(i).name,{'.','..'}),1:length(days_folderinfo)));
    
    %% read wav files
    wavfile = audioread(bird_templatepath);
    template = wavfile(template_onoff_set(ibird,1)*fs:template_onoff_set(ibird,2)*fs);
    figure,plot(1/fs:1/fs:length(template)/fs,template);title(birdname{ibird});
    %% select a template
    %% spectrogram match with template
    [s,f,t] = spectrogram(template,fix(fs/100),fix(fs/130),1024,fs,'yaxis');
    sonogram = abs(s(f<12000&f>300,:));
    template_power = mean(sonogram,1)';
    figure,
    plot(template_power);title(birdname{ibird});
    for idays = 1:length(days_folderinfo)
        disp(['processing ' num2str(idays) ' day...']);
        %% looping other wav files to find out matches
        tmp_days_folderpath = fullfile(days_folderinfo(idays).folder,days_folderinfo(idays).name,'Bouts');
        fileinfo = dir([tmp_days_folderpath '\*.wav']);
        emptyfile = arrayfun(@(ifile) fileinfo(ifile).bytes == 0,1:length(fileinfo));
        fileinfo = fileinfo(~emptyfile);
        rho = cell(length(fileinfo),1);
        time_for_rho = cell(length(fileinfo),1);
        parfor ifile = 1:length(fileinfo)
            disp(['   file ' num2str(ifile)]);
            tmp_wavfile = audioread(fullfile(fileinfo(ifile).folder,fileinfo(ifile).name));
            if length(tmp_wavfile)<length(template)
                continue;
            end
            [s,f,t] = spectrogram(tmp_wavfile,fix(fs/100),fix(fs/130),1024,fs,'yaxis');
            tmp_sonogram = abs(s(f<12000&f>300,:));
            tmp_power = mean(tmp_sonogram,1)';
            rho{ifile} = arrayfun(@(i) corr(tmp_power(i:i+length(template_power)-1),template_power),...
                1:length(tmp_power)-length(template_power)+1);
            time_for_rho{ifile} = t(1:length(tmp_power)-length(template_power)+1);
        end
        %% only keep one if found address is too near
        simple_rho = rho;
        idx_simple_rho = cellfun(@(x) find(x>0.7),simple_rho,'un',0);
        segments = cell(length(idx_simple_rho),1);
        real_motif_start = cell(length(idx_simple_rho),1);
        for iseg = 1:length(idx_simple_rho)
            x = idx_simple_rho{iseg};
            if isempty(x)
                continue;
            end
            try 
                tmp_idx = reshape([find(diff([0 diff(x)]==1)) length(x)],2,[])';
            catch ME
                if ME.identifier=='MATLAB:getReshapeDims:notDivisible'
                    tmp_idx = reshape([find(diff([0 diff(x)]==1))],2,[])';
                end
            end
            tmp_real_motif_start = zeros(size(tmp_idx,1),1);
            for jseg = 1:size(tmp_idx,1)
                [~,I] = max(simple_rho{iseg}(x(tmp_idx(jseg,1)):x(tmp_idx(jseg,2))));
                tmp_real_motif_start(jseg) = x(tmp_idx(jseg,1))+I-1;
            end
            real_motif_start{iseg} = tmp_real_motif_start;
        end
        real_motif_start = cellfun(@(x,y) y(x),real_motif_start,time_for_rho,'un',0);
        
        disp('        saving...');
        save(fullfile(tmp_days_folderpath,'motif_detection'),'real_motif_start','fileinfo');
        %% COUNT HOW MANY MOTIFS IN ONE BOUT
        nmotif_bout = cellfun(@length,real_motif_start);
        figure,
        histogram(nmotif_bout)%,0:1:140);
        title(birdname{ibird});
    end
end
%% histogram of all days from one bird
count_bird = cell(length(nbird),1);
nempty_wav = cell(length(nbird),1);
fig_bird = figure;ax_bird = axes;hold on;
title('all birds');
for ibird = 1:nbird
    %%
    bird_templatepath = [birdpath{ibird} bird_template_path{ibird}];
    days_folderinfo = dir(birdpath{ibird});
    days_folderinfo = days_folderinfo(~arrayfun(@(i) ismember(days_folderinfo(i).name,{'.','..'}),1:length(days_folderinfo)));
    
    fig_day = figure;ax_day = axes;hold on;
    count_day = cell(length(days_folderinfo),1);
    
    tmp_nempty_wav = zeros(length(days_folderinfo),1);
    for jdays = 1:length(days_folderinfo)
        load(fullfile(days_folderinfo(jdays).folder,days_folderinfo(jdays).name,'Bouts','motif_detection'),'real_motif_start');
         tmp_count = cellfun(@length,real_motif_start);
         tmp_nempty_wav(jdays) = nnz(tmp_count==0);
         tmp_count(tmp_count==0) = [];
         count_day{jdays} = tmp_count;
         
         if ~isempty(tmp_count)
             [N,edges] = histcounts(tmp_count,0.5:1:max(tmp_count)+0.5);
             plot(ax_day,edges(1:end-1),N,'s-');
         end
    end
    title(birdname{ibird});
    count_bird{ibird} = count_day;
    nempty_wav{ibird} = tmp_nempty_wav;
    [N,edges] = histcounts(cat(1,count_day{:}),0.5:1:max(cat(1,count_day{:}))+0.5);
    plot(ax_bird,edges(1:end-1),N,'s-');
end
