% this file is for diverse test: just command the test you don't want

%test1: try to compute the distance between twp signals

%load signals
[adroite,fs] = audioread('../audio_ref/adroite.wav');
% [adroite2,fs] = audioread('../audio_ref/adroite2.wav');
% [agauche,fs] = audioread('../audio_ref/agauche.wav');
% [stop,fs] = audioread('../audio_ref/stop.wav');

% put a low-pass filter on the signal
% tau = 0.1; %reduced frequency of the low pass filter
% a = 1/fs;
% a = a/tau;
% xfilt = filter(a, [1 a-1], adroite);
% % plot(adroite, 'b')
% hold on 
% plot(xfilt,'r')









%compute the MFCC of the signals

%imagesc(abs(MFCCadroite))
MFCCadroite=prep_data(adroite, fs);
% MFCCadroite2=prep_data(adroite2, fs);
% MFCCagauche=prep_data(agauche, fs);
% MFCCstop=prep_data(stop, fs);
%plot the results:
% figure
% subplot(2,2,1)
% plot(MFCCadroite(1,:))
% subplot(2,2,2)
% plot(MFCCagauche(1,:))
% subplot(2,2,3)
% plot(MFCCstop(1,:))
% subplot(2,2,4)


%plot the results
% 
figure
subplot(2,2,1)
imagesc(MFCCadroite)
% subplot(2,2,2)
% imagesc(MFCCadroite2)
% subplot(2,2,3)
% imagesc(MFCCagauche)
% subplot(2,2,4)
% imagesc(MFCCstop)

% figure
% subplot(2,2,1)
% imagesc(log(abs(MFCCadroite)))
% subplot(2,2,2)
% imagesc(log(abs(MFCCadroite2)))
% subplot(2,2,3)
% imagesc(log(abs(MFCCagauche)))
% subplot(2,2,4)
% imagesc(log(abs(MFCCstop)))





%compute the distance between the different MFCC
%dist1 = dtw(MFCCadroite, MFCCadroite2);
%dist2 = dtw(MFCCadroite, MFCCagauche);

%logically, dist2 should be superior to dist1