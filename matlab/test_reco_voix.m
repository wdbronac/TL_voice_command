% first extract the MFCC matrix of all the signals

fileTest = fullfile('..', 'audio_test', 'adroite.wav'); % we have to be in Matlab
filesRef = dir(fullfile('..', 'audio_test', '*.wav'));
nbRef = size(filesRef,1);
allSigRefMfcc = {};
Label = [];
for i = 1:nbRef
    [signal,fs] = audioread(filesRef(i).name);
    %add the corresponding label in the "MFCC_tot" list
    allSigRefMfcc{i} = prep_data(signal, fs);
    %add the corresponding label in the "Label" list    
end

%extract the signal we want to classify
[signal,fs] = audioread(fileTest);
mfccTest = prep_data(signal, fs);

distToRef = zeros(nbRef);
for i=1:nbRef
    distToRef(i) = dtw(mfccTest,allSigRefMfcc{i});
end
