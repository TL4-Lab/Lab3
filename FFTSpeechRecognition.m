clear;
close all;
clc;

[yes,yes_Fs] = audioread('yes.wav');
[no,no_Fs] = audioread('no.wav');

figure();
hold on;
plot(abs(fft(yes)));
plot(abs(fft(no)));
ylabel("|FFT(x)|");
xlabel("Frequency(HZ)");
title(["FFT"]);
legend("FFT of yes", "FFT of no");

hold off;

recording = false; % true or false

if recording == true % record audio data from a microphone fs = 16000;
    nBits = 16;
    nChannels = 1;
    ID = -1; % default audio input device
    recObj = audiorecorder(fs,nBits,nChannels,ID); 
    disp('Start speaking. Recording ends in 3 seconds.') 
    recordblocking(recObj,3);
    disp('End of Recording.');
    play(recObj);
    y = getaudiodata(recObj);
else
    filename = 'no.wav'; % change filename to test provided ’yes’ and ’no’ 
    [y, fs] = audioread(filename);
    soundsc(y, fs);
end

N = length(y);
k1 = round(N/4); % FFT component corresponding to fs/4 Hz 
k2 = round(N/2); % FFT component corresponding to fs/2 Hz
      
X = abs(fft(y));
f = sum(X(1:k1))/sum(X(k1+1:k2));

threshold = 12; % Set a value to distinguish words 1yes2 and ’no’ 
if f < threshold
    disp('yes');
else
    disp('no');
end