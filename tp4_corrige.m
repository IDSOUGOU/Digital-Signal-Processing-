% Correction TP 4 :
% Y. Takakura, octobre 2010. 
% Maj octobre 2012.
% septembre 2015. 
%%%%%%%%%%%%%%%%%%

clear all; clc;

% Section 1.3.

% Question 1 :
% le gabarit passe-bas a ete
% trouve en TD (voir page 3).
fp=0.159;
fs=0.849;
Rp=1;
Rs=10;
% limites du gabarit
bc_f=[0 fp fp];
bc_a=[-Rp -Rp -40]; % en dB
ba_f=[fs fs 2];
ba_a=[0 -Rp -Rp]; % en dB

% valeurs trouvees en TD :
% a) cas 1 : n=1, fc=0,283 % n pas assez eleve
% b) cas 2 : n=2, fc=0,490 % OK

n=1/2*log((10^(Rp/10)-1)/(10^(Rs/10)-1))/log(fp/fs);
n=ceil(n); % entier immediatement superieur
fcp=fp*(10^(Rp/10)-1)^(-1/(2*n));
fcs=fs*(10^(Rs/10)-1)^(-1/(2*n));
% remarque : en toute rigueur, il suffit
% de choisir une seule equation pour
% calculer fc. En pratique, le fait
% d'imposer n entier fait que les equations
% ne sont pas equivalentes. Il est
% d'usage de prendre la valeur
% moyenne tout en sachant qu'elle peut
% ne pas convenir. Il faudra alors
% modifier fc jusqu'a ce que la reponse
% frequentielle soit satisfaisante.
fco=(1/2)*(fcp+fcs);

Wn=2*pi*fco; % matlab travaille avec des pulsations
[b, a]=butter(n,Wn,'s'); % 's' car on a un filtre analogique
Wa=2*pi*[0:0.01:1.8];
% intervalle pour affichage
[h, w]=freqs(b,a,Wa); % w est une pulsation
figure(1);
plot(bc_f,bc_a,'b',ba_f,ba_a,'b', ...
    w/(2*pi),20*log10(abs(h)),'r', ...
    2*pi*[0 1.80],[-3 -3],'g');
% w/(2*pi) permet de se ramener en frequence
grid on;
axis([0 1.8 -40 0]);
xlabel('f (normalisee)');
ylabel('|H(f)|_{dB}');
title('Filtre passe-bas analogique');
% en vert : ligne a -3 dB
%%%%%%%%%%%%%%%%%%%%%%%%%


pause;


% Question 2 :
% le gabarit est celui de la page 1,
% a condition d'utiliser les frequences fa.

% Limites du gabarit :
ba1_f=[0 0.251 0.251];
ba1_a=[-10 -10 0]; % en dB
bcp_f=[0.911 0.911 1.204 1.204];
bcp_a=[-40 -1 -1 -40]; % en dB
ba2_f=[2.090 2.090 4];
ba2_a=[0 -10 -10]; % en dB

% il s'agit du passage :
% passe-bas analogique -> passe-bande analogique.

% Donnees obtenues en TD (page 1)
f1=0.911;
f2=1.204;
f0=sqrt(f1*f2);
B=(f2-f1)/f0;

% matlab travaille avec des pulsations
% et utilise une bande non-normalisee ;
% il faut convertir.
Wo=2*pi*f0;
Bw=2*pi*(B*f0);

[numt, dent]=lp2bp(b,a,Wo,Bw);
Nt=1024;
% nombre de points pour affichage
[hb, wb]=freqs(numt,dent,Nt);

figure(2);
plot(ba1_f,ba1_a,'b',bcp_f,bcp_a,'b',ba2_f,ba2_a,'b', ...
    wb/(2*pi),20*log10(abs(hb)),'r', ...
    [0 4],[-3 -3],'g');
% meme remarque que precedemment : w/(2*pi) permet
% de se ramener aux frequences
grid on;
axis([0 4 -40 0]);
xlabel('f (kHz)');
ylabel('|H(f)|_{dB}');
title('Filtre passe-bande analogique');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pause;

% Question 3 :
Fe=8; % frequence d'echantillonnage
% pour normaliser les frequences

% Limites du gabarit numerique:
ban1_f=[0 0.250 0.250]/Fe;
ban1_a=[-10 -10 0]; % en dB
bcn_f=[0.875 0.875 1.125 1.125]/Fe;
bcn_a=[-40 -1 -1 -40]; % en dB
ban2_f=[1.750 1.750 4]/Fe;
ban2_a=[0 -10 -10]; % en dB

% il s'agit du passage :
% passe-bande analogique -> passe-bande numerique
% qui se fait avec la transformation bilineaire
Nd=1024; % nombre de points pour affichage
[numd, dend]=bilinear(numt,dent,Fe);
[hd, wd]=freqz(numd,dend,Nd);

figure(3);
plot(ban1_f,ban1_a,'b',bcn_f,bcn_a,'b',ban2_f,ban2_a,'b', ...,
    wd/(2*pi),20*log10(abs(hd)),'r', ...
    [0 0.5],[-3 -3],'g');
% meme remarque que precedemment : w/(2*pi) permet
% de se ramener aux frequences
grid on;
axis([0 0.5 -40 0]);
xlabel('f (normalisee)');
ylabel('|H(f)|_{dB}');
title('Filtre passe-bande numerique');

% Pour les frequences de coupure,
% on trouve graphiquement (trait vert) :
% fc1'=0.084 Fe, fc2'=0.178 Fe

% THEORIE :
% on a : n=2, fc=0,350 (valeur moyenne)
% frequence de coupure du passe-bande analogique :
K=pi*B*fco;
fc1=abs(f0*(K-sqrt(K^2+1)));
fc2=f0*(K+sqrt(K^2+1));
% pour trouver les frequences de coupure,
% il faut calculer les images de fc et de -fc,
% ce qui donne deux paires de valeurs, une positive,
% une negative. La valeur absolue ci-dessus permet
% de selectionner les valeurs positives.

fN1=(1/pi)*atan(pi*fc1/Fe);
fN2=(1/pi)*atan(pi*fc2/Fe);

fprintf('frequences de coupure theoriques : %5.3f %5.3f\n', ...
    fN1,fN2);
% graphiquement, on trouve :
% fN1 = 0,093, fN2 = 0,162
%%%%%%%%%%%%%%%%%%%%%%%%%%

pause;

% Question 4 :
Fs=Fe/2;
Wp=[0.875 1.125]/Fs;
Ws=[0.250 1.750]/Fs;
% remarque : matlab normalise par rapport
% a Fe/2
Rp=1;
Rs=10;
[n0, W0]=buttord(Wp,Ws,Rp,Rs);
% meme remarque : W0 est normalise
% par rapport 2. Pour avoir les frequences
% normalisees, il faut divider par 2.
fprintf('frequences de coupure par synthese directe : %5.3f %5.3f\n', ...
    W0/2);
% on observe un ecart non negligeable
% des frequences de coupure en comparaison
% avec la synthese directe. Cependant,
% le filtre convient aussi. Si on avait
% pris la frequence de coupure fc=0,490,
% on aurait obtenu le meme resultat.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pause;

% Question 5 :
A=10;
% cette valeur permet de rendre les frequences
% plus visibles dans le periodogramme
f1=0.500; % bande de transition gauche
f2=1.000; % bande centrale
f3=2.000; % bande attenuee droite
w0_1=2*pi*f1;
w0_2=2*pi*f2;
w0_3=2*pi*f3;
phi1=2*pi*rand(1,1);
phi2=2*pi*rand(1,1);
phi3=2*pi*rand(1,1);
% phases aleatoires
Np=1024;
Te=1/Fe;
tn=[0:Np-1]*Te;
x1=A*cos(w0_1*tn+phi1)+randn(size(tn));
x2=A*cos(w0_2*tn+phi2)+randn(size(tn));
x3=A*cos(w0_3*tn+phi3)+randn(size(tn));

y1=filter(numd,dend,x1);
y2=filter(numd,dend,x2);
y3=filter(numd,dend,x3);
% attention : il faut prendre
% les coefficients du filtre
% numerique.

[Py1, wy1]=periodogram(y1,[],1024);
[Py2, wy2]=periodogram(y2,[],1024);
[Py3, wy3]=periodogram(y3,[],1024);

ban_f=[ban1_f ban2_f];
ban_a=[ban1_a ban2_a];
figure(4);
plot(ban_f,ban_a,'b',bcn_f,bcn_a,'b', ...
    wy1/(2*pi),10*log10(Py1),'r', ...
    wy2/(2*pi),10*log10(Py2),'r', ...
    wy3/(2*pi),10*log10(Py3),'r');
grid on;
xlabel('f (normalisee)');
ylabel('|H(f)|_{dB}, S_y (dB)');
title('d.s.p. de signaux filtres');
% effet du filtre : l'amplitude
% de l'impulsion dans la bande de transition
% (resp. attenuee) est d'environ 11 (resp. 15) dB
% plus faible que l'impulsion dans la bande centrale.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pause

% Section 2.1.
clear all; clc;

% Question 1 :

% On remarque que la plus grande
% periode contenue dans le signal
% est de l'ordre de 2 secondes.
% Pour le cahier des charges du filtre
% passe-haut, on choisit :
% taux d'ondulation 1 dB
% attenuation 10 dB
% bande haute a partir de 0,50 Hz
% bande de transition 0,25 Hz.

% Lorsqu'on etablit un gabarit,
% il faudra veiller a ce que l'ordre
% du filtre obtenu ne soit pas trop grand,
% ce qui peut conduire a des instabilites.

Fe=1000;

Rp=1;
Rs=10;
Ra=40;
fd=0.25;
fu=0.50;

bu_f=[0 fd fd 1];
bu_a=[-Rs -Rs 0 0];
bd_f=[fu fu 1];
bd_a=[-Ra -Rp -Rp];

figure(5);
plot(bu_f,bu_a,'b',bd_f,bd_a,'b');
grid on;
xlabel('f (Hz)');
ylabel('|H(f)|_{dB}');
title('gabarit passe-haut numerique');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pause;

% Question 2 :

fd_n=fd/Fe;
fu_n=fu/Fe;

fa_d=Fe/pi*tan(pi*fd_n);
fa_u=Fe/pi*tan(pi*fu_n);
% les frequences etant proches de zero,
% on n'observe quasiment pas
% de distorsion de frequences
% avec la transformation bilineaire.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pause;

% Question 3 :

% La transformation f'=1/f
% permet de passer du filtre passe-haut analogique
% a un filtre passe-bas analogique. Si fc est
% la frequence de coupure du filtre
% passe-haut alors 1/fc est la frequence
% de coupure du filtre passe-bas.
fp_d=1/fa_d;
fp_u=1/fa_u;

Fpu_f=[0 fp_u fp_u];
Fpu_a=[-Rp -Rp -Ra];
Fpd_f=[fp_d fp_d 8];
Fpd_a=[0 -Rs -Rs];
figure(6);

plot(Fpu_f,Fpu_a,'b',Fpd_f,Fpd_a,'b');
grid on;
xlabel('f (Hz)');
ylabel('|H(f)|_{dB}');
title('gabarit passe-bas analogique');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pause;

% Question 4 :

% Le filtre-limite doit passer
% par les points (2, -1 dB)
% et (4, -10 dB).

n=1/2*log((10^(Rp/10)-1)/(10^(Rs/10)-1))/log(fp_u/fp_d);
n=ceil(n); % entier immediatement superieur
fcp=fp_u*(10^(Rp/10)-1)^(-1/(2*n));
fcs=fp_d*(10^(Rs/10)-1)^(-1/(2*n));
fc=1/2*(fcp+fcs);
% remarque : la contrainte n entier
% fait que le calcul de fc a l'aide
% du point (2, -1 dB) ne donne pas
% le meme resultat qu'avec le point
% (4, -10 dB). On choisit ici une valeur
% moyenne tout en sachant qu'elle peut
% ne pas convenir. Il faudra alors
% modifier fc jusqu'a ce que la reponse
% frequentielle soit satisfaisante.

% on trouve :
% n=3, fcp=2,505, fcs=2,773
% soit fc=2,639
% pour le filtre pass-bas analogique.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pause

% Question 5 :

% frequence de coupure du filtre passe-haut
% analogique :
fcp=1/fc;
% frequence de coupure du filtre passe-haut
% numerique :
fNp=(1/pi)*atan(pi*fcp/Fe);
fprintf('frequence de coupure theorique du filtre numerique : %5.3e\n', ...
    fNp);
%%%%%%%%%

% Section 2.2.

% Question 1 :

Wn=2*pi*fc;
[b, a]=butter(n,Wn,'s'); % 's' car on a un filtre analogique
[h, w]=freqs(b,a); % w est une pulsation
% meme code que la question 1
% de la section 1.3.
figure(7);
plot(Fpu_f,Fpu_a,'b',[0 Fpd_f],[0 Fpd_a],'b', ...
    w/(2*pi),20*log10(abs(h)),'r', ...
    [0 8],[-3 -3],'g');
% w/(2*pi) permet de se ramener en frequence
grid on;
axis([0 8 -Ra 0]);
xlabel('f (normalisee)');
ylabel('|H(f)|_{dB}');
title('Filtre passe-bas analogique');
% On trouve graphiquement :
% fc_graph = 2,637 alors que la valeur theorique
% est fc_theo = 2,639.
%%%%%%%%%%%%%%%%%%%%%%

pause;

% Question 2 :

% remarque : suivant l'aide de matlab,
% la commande lp2hp fait la transformation
% wh=wo/wb si wb (resp. wh) correspond aux pulsations
% du filtre passe-bas (resp. passe-haut) analogique.
% L'egalite est aussi vraie pour les pulsations
% de coupure qui sont 2*pi*fc pour le filtre
% passe-bas, 2*pi/fc pour le filtre passe-haut.
% On a donc 2*pi/fc=wo/(2*pi*fc),
% ce qui donne wo=(2*pi)^2.
Wo=(2*pi)^2;
% matlab utilise des pulsations de coupure.
[numt, dent]=lp2hp(b,a,Wo);
Wt=2*pi*[0:0.01:1];
% Points pour affichage.
[ht, wt]=freqs(numt,dent,Wt);
bu_f=[0 fa_d fa_d 1];
bu_a=[-Rs -Rs 0 0];
bd_f=[fa_u fa_u 1];
bd_a=[-Ra -Rp -Rp];
figure(8);
plot(bu_f,bu_a,'b',bd_f,bd_a,'b', ...
    wt/(2*pi),20*log10(abs(ht)),'r', ...
    [0 1],[-3 -3],'g');
grid on;
axis([0 1 -Ra 0]);
xlabel('f (Hz)');
ylabel('|H(f)|_{dB}');
title('Filtre passe-haut analogique');
% On trouve graphiquement fcp_grap = 0,379 Hz ;
% la valeur theorique est fcp_theo = 0,379 Hz.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pause

% Question 3 :
[numd, dend]=bilinear(numt,dent,Fe);
% meme code que la question 3
% de la section 1.3.
Wd=2*pi*[0:0.01:1]/Fe;
% intervalle pour affichage
[hd, wd]=freqz(numd,dend,Wd);
figure(9);
plot(bu_f/Fe,bu_a,'b',bd_f/Fe,bd_a,'b', ...,
    wd/(2*pi),20*log10(abs(hd)),'r', ...
    [0 1]/Fe,[-3 -3],'g');
grid on;
axis([0 1/Fe -Ra 0]);
xlabel('f (normalisee)');
ylabel('|H(f)|_{dB}');
title('Filtre passe-haut numerique');
% On trouve graphiquement fNp_grap = 3,792e-04
% la valeur theorique est fNp_theo = 3,789e-04
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pause

% Qestion 4 :
Fs=Fe/2;
Wph=fu/Fs;
Wsh=fd/Fs;
% matlab normalise par rapport
% a la demi-frequence d'echantillonnage.
[Nh, Wnh]=buttord(Wph,Wsh,Rp,Rs);
[bh, ah]=butter(Nh,Wnh,'high');
F=[0:0.01:1]; % intervalle pour affichage
[hh, wh]=freqz(bh,ah,F,Fe);
figure(10);
plot(bu_f,bu_a,'b',bd_f,bd_a,'b', ...,
    wh,20*log10(abs(hh)),'r', ...
    [0 1],[-3 -3],'g');
grid on;
axis([0 1 -Ra 0]);
xlabel('f (Hz)');
ylabel('|H(f)|_{dB}');
title('Filtre passe-haut numerique (synthese directe)');
% On trouve graphiquement fNp_grap = 3,609e-04
% avec la synthese directe.
%%%%%%%%%%%%%%%%%%%%%%%%%%%

pause;

% Question 5 :

%lecture;
% remarque : je n'utilise pas
% le programme lecture.m
ecg = load('ecg_lfn.dat');
xn=ecg;
yn=filter(bh,ah,xn);
Ns=length(xn);
n=0:Ns-1;
tn=n/Fe;
figure(11);
subplot(2,1,1), plot(tn,xn);
axis([0 10 -4 4]);
ylabel('signal brut');
grid on;
title('filtrage passe-haut ECG');
subplot(2,1,2), plot(tn,yn);
axis([0 10 -4 4]);
xlabel('t (s)');
ylabel('signal filtre');
grid on;
% remarque : on a un filtre RII,
% ce qui ce traduit par un regime
% transitoire jusqu'a 0,5 seconde.
% Puis, la derive est eliminee.