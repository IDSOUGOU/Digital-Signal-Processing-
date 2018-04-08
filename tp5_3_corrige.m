% TP 5. Traitement des signaux aléatoires
% Caractéristiques statistiques de signaux aléatoires simples
% doikon@telecom.tuc.gr, modifié F. Heitz 2015

clear all;
close all;







% Bruit blanc gaussien centré
sigma=2;
m=0;
NUM_REAL=6;
SIMULATION_LENGTH=1000;
t=0:(1/SIMULATION_LENGTH):(1-1/SIMULATION_LENGTH);
realizations=zeros(NUM_REAL,SIMULATION_LENGTH);
figure(1);
clf;
for n=1:NUM_REAL
    realizations(n,:)=sigma*randn(1,SIMULATION_LENGTH)+m;
    subplot(NUM_REAL,1,n);
    plot(t,realizations(n,:));
    axis([0 1 -7 7]);
end
subplot(NUM_REAL,1,1);
title(['Réalisations d''un bruit blanc gaussien de moyenne m=',num2str(m) ' et d''écart type \sigma =' num2str(sigma)])
pause


% Distribution d'ordre 1 d'un bruit blanc gaussien
sigma=2;
m=0;
t0=3;
NUM_REAL=10000;
SIMULATION_LENGTH=1000;
t=0:(1/SIMULATION_LENGTH):(1-1/SIMULATION_LENGTH);
realizations=zeros(NUM_REAL,SIMULATION_LENGTH);
figure;
clf;
for n=1:NUM_REAL
    realizations(n,:)=sigma*randn(1,SIMULATION_LENGTH)+m;
end
x=realizations(:,t0);
histogram(x,50);
pause;
% Moyenne statistique à un instant donné t0
moy_stat=sum(x)/NUM_REAL;
% moy_stat=mean(x);
disp(['Moyenne statistique estimée sur ' num2str(NUM_REAL) ' réalisations : ' num2str(moy_stat)]);
% Moyenne temporelle
xx=realizations(7,:); % 7ème réalisation du bruit
% figure;
% histogram(xx,50);
moy_temp=sum(xx)/SIMULATION_LENGTH;
% moy_temp=mean(xx);
disp(['Moyenne temporelle estimée sur '  num2str(SIMULATION_LENGTH) ' échantillons : ' num2str(moy_temp)]);


% Fonction d'autocorrélation temporelle (version non biaisée)
%  Compléter la ligne ci-dessous
[c,lags]=xcorr(xx,'unbiased');
figure;
subplot(2,1,1);
plot(lags,c);
title(['Fonction d''autocorrélation temporelle du bruit blanc (estimation non biaisée)']);
axis([lags(1) lags(end) -inf inf]);
xlabel('\tau');
ylabel(['Rx']);
% Fonction d'autocorrélation temporelle (version biaisée)
%  Compléter la ligne ci-dessous
[c,lags] = xcorr(xx,'biased');
subplot(2,1,2);
plot(lags,c);
title(['Fonction d''autocorrélation temporelle du bruit blanc (estimation biaisée)']);
axis([lags(1) lags(end) -inf inf]);
xlabel('\tau');
ylabel(['Rx']);
