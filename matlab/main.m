% main

%reading the wave files
[son, Fs]=audioread('sons/adroite.wav');

%resampling
% nF = Fs/4; % new frequency
% son = resample(son, nF,Fs);
% 
nF = Fs;
sizetot = length(son);

%taille de la fenêtre (en ms):
width = 32;

%choix de la fenêtre
size = (width/1000)*nF; 
fen = hamming(size);

%analyse temps fréquence

antf = []; 
notes= []; 

%taille du pas (en ms)
width_step = 16;

step =(width_step/1000)*nF ;%à justifier


% 
% for i = (1:(sizetot-size)/pas)*pas
%     
%     vect = log((abs(fft(fen.*son(i:i+size-1))).^2));
%     [maxi,note]  = max(vect);
%     antf = [antf vect];
%     notes = [notes note];
% %affichage du périodogramme total
% 
% %per = (fft(
% end


i = 3000; % nb de points du départ de la fenêtre



 vect = (abs(fft(fen.*son(i:i+size-1))));
 
 %vect = 2595*log( vect/700 +1  )/log(10);
 
 plot(vect)
 
 %filtrage mel
 
 
 F_min = 8; % en Hz
 F_max = 8000; % en Hz
 
 N_f = 20;

 W = 2*(F_max-F_min)/(N_f +1);
 
 sign = vect(1:256);
 
 for k = 1:256
     f = k / 512 * 16000;
     F = 2595*log(f/700+1)/log(10);
     i = floor((F - F_min) * 2/W);
     F_centre_i = F_min + i* W/2;
     F_min_i = F_min + (i-1)*W/2;
     F_max_i = F_min + (i-1)*W/2 + W;
     f_min = 700*(10^(F_min_i/2595)-1);
     f_max = 700*(10^(F_max_i/2595)-1);
     f_centre = 700*(10^(F_centre_i/2595)-1);
     if f < f_min
         a = (f - f_min)/(f_centre - f_min);
         sign(k) = a * sign(k);
     else
         b = (f_max - f) / (f_max - f_centre);
         sign(k) = b * sign(k);
         
     end
 end

 N = length(sign);
 N_x = N;
 x  = zeros(N_x);
 % à changer
 w  = sqrt((1:N)./N); 
 for n = 1:N_x;
    x(n) = sum(w .* sign' .* cos(pi*(2*n-1)*(0:N-1)./2*N));
 end
 
 plot(vect)
 figure
 plot(sign)
 
%  fil = 
%  
%  
%  triang = 
 
 
% imshow(antf)
