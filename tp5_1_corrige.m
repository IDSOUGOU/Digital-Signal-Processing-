% TP 5. Traitement des signaux aléatoires
% Simulation de signaux aléatoires simples
% doikon@telecom.tuc.gr, modifié F. Heitz 2015

clear all;
close all;


% Sinusoid of random phase
A=1;
f0=4;
NUM_REAL=6;
SIMULATION_LENGTH=1024;
t=0:(1/SIMULATION_LENGTH):(1-1/SIMULATION_LENGTH);
realizations=zeros(NUM_REAL,SIMULATION_LENGTH);
figure(2);
clf;
for n=1:NUM_REAL
    Phi=0+(2*pi-0)*rand;
    realizations(n,:)=A*cos(2*pi*f0*t+Phi);
    subplot(NUM_REAL,1,n);
    plot(t,realizations(n,:));
    title(['Réalisation d''une sinusoïde de phase aléatoire : \Phi(\omega)=' num2str(Phi)]);
    axis([0 1 -1 1]);
end
pause

% Sinusoid of random frequency and phase
A=1;
NUM_REAL=6;
SIMULATION_LENGTH=1024;
t=0:(1/SIMULATION_LENGTH):(1-1/SIMULATION_LENGTH);
realizations=zeros(NUM_REAL,SIMULATION_LENGTH);
figure(3);
clf;
for n=1:NUM_REAL
    F0=1+(10-1)*rand(1);
    Phi=0+(2*pi-0)*rand;
    realizations(n,:)=A*cos(2*pi*F0*t + Phi);
    subplot(NUM_REAL,1,n);
    plot(t,realizations(n,:));
    title(['Réalisation d''une sinusoïde de fréquence et phase aléatoire :  F0(\omega)=' num2str(F0) ', \Phi(\omega)=' num2str(Phi)]);
    axis([0 1 -1 1]);
end
pause

% White Gaussian random process
sigma=2;
m=5;
NUM_REAL=6;
SIMULATION_LENGTH=1024;
t=0:(1/SIMULATION_LENGTH):(1-1/SIMULATION_LENGTH);
realizations=zeros(NUM_REAL,SIMULATION_LENGTH);
figure(4);
clf;
for n=1:NUM_REAL
    realizations(n,:)=sigma*randn(1,SIMULATION_LENGTH)+m;
    subplot(NUM_REAL,1,n);
    plot(t,realizations(n,:));
    axis([0 1 -1 11]);
end
subplot(NUM_REAL,1,1);
title(['Réalisations d''un bruit blanc gaussien de moyenne m=',num2str(m) ' et d''écart type\sigma =' num2str(sigma)])
pause


% Sinusoid of random phase with white Gaussian random process
sigma=0.5;
NUM_REAL=6;
SIMULATION_LENGTH=1024;
t=0:(1/SIMULATION_LENGTH):(1-1/SIMULATION_LENGTH);
realizations=zeros(NUM_REAL,SIMULATION_LENGTH);
figure(5);
clf;
for n=1:NUM_REAL
    Phi=0+(2*pi-0)*rand;
    realizations(n,:)=A*cos(2*pi*f0*t+Phi) + sigma*randn(1,SIMULATION_LENGTH);
    subplot(NUM_REAL,1,n);
    plot(t,realizations(n,:));
    axis([0 1 -2 2]);
end
subplot(NUM_REAL,1,1);
title(['Réalisations d''un sinusoïde bruitée']);





