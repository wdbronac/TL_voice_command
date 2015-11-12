% test avec tous les fichiers son
matrix_distance = zeros(12,12);

% first extract the MFCC matrix of all the signals
filesRef = dir('../audio_ref/*.wav');

%initialize with the first MFCC
[signal,fs] = audioread(filesRef(1).name);
matriceMfcc = prep_data(signal, fs);
MFCC_tot = {};
MFCC_tot{1} = matriceMfcc ;
%Label = [];
for i = 2:size(filesRef,1)
    [signal,fs] = audioread(filesRef(i).name);
    %add the corresponding label in the "MFCC_tot" list
    matriceMfcc = prep_data(signal, fs);
    MFCC_tot{i} = matriceMfcc;
    %add the corresponding label in the "Label" list    
end


distToRef = zeros(size(filesRef));
for i=1:size(filesRef)
    for j = i:size(filesRef)
    distToRef(i,j) = dtw(MFCC_tot{i},MFCC_tot{j});
    end
end

cmax = [15,35];
imagesc(log(distToRef)./log(10))