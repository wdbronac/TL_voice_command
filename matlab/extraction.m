close all
clear
file = 'enavant.wav';
[signal,fs] = audioread(file);
window = zeros(size(signal));
window_size = floor(fs*32E-3);
window_begin = floor(fs*400E-3);
window(window_begin:(window_begin+window_size)) = 1;
spectrum = abs(fft(window.*signal));
figure
subplot(2,1,1);
hold on;
plot((0:size(signal)-1)/fs,signal);
plot((0:size(signal)-1)/fs,window);
title('Signal: "En avant"')
MFCC = mfcc(spectrum, fs, 20);
subplot(2,1,2)
plot(MFCC, '*');

