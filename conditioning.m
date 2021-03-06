%% setup
%webcamera
%arduino
Uno=arduino('COM3','UNO');
deviceReader = audioDeviceReader('SamplesPerFrame',4410,'Device','Microphone (HD Pro Webcam C920)','NumChannels',2);
start(vid);pause(0.2);
writeDigitalPin(Uno,'D13',0);
cache = deviceReader();
signal = [signal; cache(:,1)];
mark(N) = bandpower(cache,44100,[1000 7000])/bandpower(cache,44100,[0 1000]);
if N>=10 && length(find(mark(N-9:N)>3))>5
    ifSong(N)=1;
else
    ifSong(N)=0;
end
writeDigitalPin(Uno,'D13',1);

audiowrite('NS_'+audioFile,signal,44100);
vid = videoinput('winvideo',1,'MJPG_640x360');
vid.FramesPerTrigger=800;
vid.LoggingMode='memory';
videodata=getdata(vid);
v=VideoWriter('NS_'+videoFile);
open(v);writeVideo(v,videodata);close(v);
release(deviceReader);
    


%% loop
%random number
%illuminate LED
%80% / 20% transparent board


