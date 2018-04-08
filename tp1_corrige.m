% TP 1 
% juin 2015, YT
% % % 

% I. preambule 
[Y, Fs, Nbits]=wavread('sakura.wav'); 
n=52000:67583; 
xn=Y(n); 

figure(1); 
plot(n,xn); 
xlabel('n'); ylabel('xn'); grid on; 
axis([5.2e4 6.2e4 -0.15 0.15]); 
set(gca,'FontSize',18,'fontWeight','bold'); 
set(findall(gcf,'type','text'),'FontSize',18,'fontWeight','bold'); 

k=n-n(1); 
Xk=fft(xn); 

figure(2); 
plot(k,abs(Xk)); 
xlabel('k'); ylabel('Xk'); grid on; 
xlim([0 k(end)]); 
set(gca,'FontSize',18,'fontWeight','bold'); 
set(findall(gcf,'type','text'),'FontSize',18,'fontWeight','bold'); 

% % % 
% tp11.m 
n=52001:52100; 
yn=Y(n)'; 
figure(3); 
plot(n,yn,'.-'); 
xlabel('n'); ylabel('yn'); 

k=n-n(1); % pour commence a k=0 
Yk=fft(yn); 
figure(4); 
plot(k,abs(Yk),'.-'); 
xlabel('k'); ylabel('|Yk|'); 

zn=[yn zeros(1,8092)]; % zero padding 
k=0:length(zn)-1; 
Zk=fft(zn); 
figure(5); 
plot(k,abs(Zk),'-'); 
xlabel('k'); ylabel('|Zk|'); 

nw=500; % interpolation par TFD 
n=0:nw-1; 
vn=zeros(1,nw); 
vn(1:5:nw)=yn; 
Vk=fft(vn); 
Vk(50:462)=0; 
wn=500/100*real(ifft(Vk)); 

figure(6); 
plot(n,wn,'r'); hold on; 
stem(n,vn); hold off; 
xlabel('n'); ylabel('vn, wn'); 

% II. 

% % % 
% tp12.m 
n=52001:92000; 
un=Y(n)'; 
sound(un,44100); 
pause(0.5); 

Uk=abs(fft(un)); 
k=n-n(1); 
Fe=44.1; 
Nk=length(k); 
figure(7); 
plot(k*Fe/Nk,Uk); 

tn=[un, zeros(1,2^18)]; 
Tk=abs(fft(tn)); 
nk=length(Tk); 
k=0:nk-1; 
fk=k/nk*Fe; 

indx=find(fk < 2); 
xk=fk(indx); yk=Tk(indx); 
figure(8); plot(xk,yk); 

[pks, locs]=findpeaks(yk,'minpeakheight',39, ... 
    'minpeakdistance',1000); 
fmax=xk(locs); 
fmax=fmax/fmax(1); 
nk=1:5; 

figure(9); 
plot(nk,fmax,'.-'); 
xlabel('entier'); ylabel('fmax/f0'); 

f0=xk(locs(1)); 

A=0.5; 
No=round(Fe/f0); 
an=[1 zeros(1,No-1) -A -A]; 
kn=[randn(1,No) zeros(1,65536)]; 
sn=filter(1,an,kn); 

sound(sn,44100); 
pause(0.5); 
