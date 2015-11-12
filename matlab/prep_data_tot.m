function Y = prep_data_tot(folder)
%folder:  folder containing the training data
% y: list : every element is a matrix (around 20: the number of points in
% the mel output)*(the time vector) (or the other side: to be discussed)
files = dir(strcat('../', folder,'/*.wav'));

for file = files'
    [signal,fs] = audioread(file.name);