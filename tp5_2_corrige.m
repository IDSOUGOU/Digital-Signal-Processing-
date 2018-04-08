% TP 5. Traitement des signaux al�atoires
% Caract�ristiques statistiques de signaux al�atoires simples
% doikon@telecom.tuc.gr, modifi� F. Heitz 2015

clear all;
close all;



% Sinusoide � phase al�atoire
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
    title(['R�alisation d''une sinuso�de de phase al�atoire : \Phi(\omega)=' num2str(Phi)]);
    axis([0 1 -1 1]);
end
pause;


% Distribution d'ordre 1 : valeurs du signal � un instant t0
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
x=realizations(:,5); % Vecteur des valeurs du signal � l'instant t0=5
histogram(x,50);
pause;

% Moyenne statistique � l'instant donn� t0=5
moy_stat=sum(x)/NUM_REAL;
%moy_stat=mean(x);
disp(['Moyenne statistique estim�e sur ' num2str(NUM_REAL) ' r�alisations : ' num2str(moy_stat)]);

% Moyenne temporelle pour une r�alisation
xx=realizations(999,:); % 999 �me r�alisation du signal 
moy_temp=sum(xx)/SIMULATION_LENGTH;
%moy_temp=mean(xx);
disp(['Moyenne temporelle estim�e sur '  num2str(SIMULATION_LENGTH) ' �chantillons : ' num2str(moy_temp)]);


% Fonction d'autocorr�lation temporelle (version non biais�e)
figure;
xx=realizations(999,:);
[c,lags] = xcorr(xx,'unbiased');
plot(lags,c);
title(['Fonction d''autocorr�lation temporelle de la sinuso�de']);
axis([lags(1) lags(end) -0.7 0.7]);
xlabel('\tau');
ylabel(['Rx']);



