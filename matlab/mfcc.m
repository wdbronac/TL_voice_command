function [MFCC] = mfcc(spectrum, fs, Nf)

% %-----------------------LE CODE ORIGINAL DU ZEIN----------------------
% 
% % Computes the MFCC of a spectrum, with respect to the sampling frequency
% % Spectrum is already split in the middle
% 
%     freqs = (1:length(spectrum))*fs/length(spectrum);
% %     energy_ratio = 1;
% %     if energy_ratio > 0.8 && energy_ratio < 1
% %         energy = cumsum(spectrum.^2);
% %         argfmax = find(energy < energy_ratio*energy(end),1,'last');
% %     elseif energy_ratio <= 0.8
% %         energy = cumsum(spectrum.^2);
% %         argfmax = find(energy > energy_ratio*energy(end),1);
% %     else 
% %         argfmax = length(freqs);
% %     end
%     Freqs = 2595*log10(1+freqs/700);
%     F_min = Freqs(1);
%     F_max = Freqs(end);
%     W = 2*(F_max - F_min)/(Nf + 1);
%     mel_filter_Freqs = [F_min + 0.5*W*(0:Nf-1); 
%                         F_min + 0.5*W*(1:Nf); 
%                         F_min + 0.5*W*(2:(Nf+1))];
%     mel_filter_freqs = 700*(10.^(mel_filter_Freqs/2595)-1);
%     mel_filters = zeros(length(spectrum),Nf);
% 
%     for n = 1:length(spectrum)
%         f = freqs(n);
%         argmin = find(mel_filter_freqs(1,:) <= f);
%         argmin_center = find(mel_filter_freqs(2,argmin) >= f);
%         if size(argmin_center)
%             fmin = mel_filter_freqs(1,argmin_center);
%             fcenter = mel_filter_freqs(2,argmin_center);
%             mel_filters(n,argmin_center) = (f - fmin)/(fcenter - fmin);
%         end
%         argcenter = find(mel_filter_freqs(2,:) <= f);
%         argcenter_max = find(mel_filter_freqs(3,argcenter) >= f);
%         fcenter = mel_filter_freqs(2,argcenter_max);
%         fmax = mel_filter_freqs(3,argcenter_max);
%         mel_filters(n:argcenter_max) = (fmax - f)/(fmax - fcenter);
%     end
% 
%     mel_output = spectrum'*mel_filters;
%     log_spectrum = log(mel_output);
%     MFCC = idct(log_spectrum);
% 
%----------------------FIN DU CODE ORIGINAL DU ZEIN--------------------


% Computes the MFCC of a spectrum, with respect to the sampling frequency
% Spectrum is already split in the middle
    % proportion du spectre que l'on garde
    freq_debut = 20; %mettre minimum
    freq_fin = 8000;% maximum: 8000
    spectrum = spectrum(floor(freq_debut/fs*length(spectrum)):floor(freq_fin/fs*length(spectrum)));
    freqs = linspace(freq_debut, freq_fin, length(spectrum));
    Freqs = 2595*log10(1+freqs/700);
    F_min = Freqs(1);
    F_max = Freqs(end);
    W = 2*(F_max - F_min)/(Nf + 1);
    mel_filter_Freqs = [F_min + 0.5*W*(0:Nf-1); 
                        F_min + 0.5*W*(1:Nf); 
                        F_min + 0.5*W*(2:(Nf+1))];
    mel_filter_freqs = 700*(10.^(mel_filter_Freqs/2595)-1);
    mel_filters = zeros(length(spectrum),Nf);

    for n = 1:length(spectrum)
        f = freqs(n);
        argmin = find(mel_filter_freqs(1,:) <= f);
        argmin_center = find(mel_filter_freqs(2,argmin) >= f);
        if size(argmin_center)
            fmin = mel_filter_freqs(1,argmin_center);
            fcenter = mel_filter_freqs(2,argmin_center);
            mel_filters(n,argmin_center) = (f - fmin)/(fcenter - fmin);
        end
        argcenter = find(mel_filter_freqs(2,:) <= f);
        argcenter_max = find(mel_filter_freqs(3,argcenter) >= f);
        fcenter = mel_filter_freqs(2,argcenter_max);
        fmax = mel_filter_freqs(3,argcenter_max);
        mel_filters(n:argcenter_max) = (fmax - f)/(fmax - fcenter);
    end

    mel_output = spectrum'*mel_filters;
    %mel_output = spectrum';
    %log_spectrum = spectrum';
    
    log_spectrum = log10(abs(mel_output));
    %MFCC = mel_output;
    MFCC = log_spectrum;
    %MFCC = idct(log_spectrum,10000);
    %MFCC = MFCC(1,:);% en fait je crois qu'il ne faut récupérer que le dernier truc
end
