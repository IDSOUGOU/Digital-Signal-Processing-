% TP 5. Traitement des signaux aléatoires
% Caractéristiques statistiques de signaux aléatoires simples
% doikon@telecom.tuc.gr, modifié F. Heitz 2015

clear all;
close all;



% Sinusoide à phase aléatoire
A=1;
f0=4;
NUM_REAL=6;
SIMULATION_LENGTH=1000;
t=0:(1/SIMULATION_LENGTH):(1-1/SIMULATION_LENGTH);
realizations=zeros(NUM_REAL,SIMULATION_LENGTH);
figure;
clf;
for n=1:NUM_REAL
    Phi=0+(2*pi-0)*rand;
    realizations(n,:)=A*cos(2*pi*f0*t+Phi);
    subplot(NUM_REAL,1,n);
    plot(t,realizations(n,:));
    title(['Réalisation d''une sinusoïde de phase aléatoire : \Phi(\omega)=' num2str(Phi)]);
    axis([0 1 -1 1]);
end
pause;


% Distribution d'ordre 1 : valeurs du signal à un instant t0
t0=5;
A=1;
f0=4;
NUM_REAL=10000;
SIMULATION_LENGTH=1000;
t=0:(1/SIMULATION_LENGTH):(1-1/SIMULATION_LENGTH);
realizations=zeros(NUM_REAL,SIMULATION_LENGTH);
figure;
clf;
for n=1:NUM_REAL
    Phi=0+(2*pi-0)*rand;
    realizations(n,:)=A*cos(2*pi*f0*t+Phi);
end
x=realizations(:,5); % Vecteur des valeurs du signal à l'instant t0=5
histogram(x,50);
pause;

% Moyenne statistique à l'instant donné t0=5
moy_stat=sum(x)/NUM_REAL;
%moy_stat=mean(x);
disp(['Moyenne statistique estimée sur ' num2str(NUM_REAL) ' réalisations : ' num2str(moy_stat)]);

% Moyenne temporelle pour une réalisation
xx=realizations(999,:); % 999 ème réalisation du signal 
moy_temp=sum(xx)/SIMULATION_LENGTH;
%moy_temp=mean(xx);
disp(['Moyenne temporelle estimée sur '  num2str(SIMULATION_LENGTH) ' échantillons : ' num2str(moy_temp)]);


% Fonction d'autocorrélation temporelle (version non biaisée)
figure;
xx=realizations(999,:);
[c,lags] = xcorr(xx,'unbiased');
plot(lags,c);
title(['Fonction d''autocorrélation temporelle de la sinusoïde']);
axis([lags(1) lags(end) -0.7 0.7]);
xlabel('\tau');
ylabel(['Rx']);



