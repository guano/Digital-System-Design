[y,Fs] = audioread('Septette.wav');
y1 = y(:,1) + y(:,2);
ysize = size(y);
t = 1:ysize(1,1);
audiowrite('Septette2.wav',y(:,1),Fs,'BitsPerSample',8,...
'Comment','Right Channel Mono');
audiowrite('Septette3.wav',y(:,2),Fs,'BitsPerSample',8,...
'Comment','Left Channel Mono');
audiowrite('Septette4.wav',y1,Fs,'BitsPerSample',8,...
'Comment','Merged Mono');
y2 = audioread('Septette4.wav');
y3 = audioread('Septette3.wav');
plot(t,y3,t,y2);
%plot(2);
%plot(t,y2);