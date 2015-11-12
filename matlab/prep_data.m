function [y]=prep_data(signal, fs)
%signal, fs : the result of audioread and a sampling frequency (can be the result
%of audioread or a manually made one
% y: list : every element is a matrix (around 20: the number of points in
% the mel output)*(the time vector) (or the other side: to be discussed)
    %resampling
    % nF = fs/4; % new frequency
    % son = resample(son, nF,fs);
    %
%     nF = fs;
%     sizetot = length(son);
%     
%     %taille de la fenêtre (en ms):
%     width = 32;
%     
%     %choix de la fenêtre
%     size = (width/1000)*nF;
%     fen = hamming(size);
    
over = 0.0; %coefficient of overlapping of the windows: 1: total overlap (impossible because it will not change the window, 0, adjascent windows

% for every position of the window
window_size = floor(fs*32E-3);
window_begin = 1;
MFCC_tot = [];

%TODO: à optimiser
window = zeros(size(signal));
while window_begin+window_size < size(window,1),
    window = zeros(size(signal));
    %window(int32(window_begin):int32((window_begin+window_size))) = 1;
    window(int32(window_begin):int32((window_begin+window_size))) = hamming(window_size+1);    %parwilliam: je rajoute une fenêtre de blackmann

    window_begin = window_begin + (1-over)*window_size;
    
    
    
    spectrum = abs(fft(window.*signal));    
    MFCC = mfcc(spectrum, fs, 20);
    MFCC_tot = [MFCC_tot, MFCC'];
end
y = MFCC_tot; 
