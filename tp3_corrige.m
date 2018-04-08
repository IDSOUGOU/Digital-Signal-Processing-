% TP 3 
% juin 2015, YT
% % % 

% I. preambule 
n=4; q=1/2^(n-1); 

t=0:0.0001:1; 
x=sin(2*pi*t)+q*rand(size(t)); 
k=round(x/q); 
xq=k*q; 
figure(1); 
plot(x,xq,'.',[-1 1],[0 0],'r',[0 0],[-1 1],'r',[-1 1],[-1 1],'r'); 
xlabel('x'); ylabel('xq'); grid on; 
axis([-1 1 -1 1]); 
set(gca,'FontSize',18,'fontWeight','bold'); 
set(findall(gcf,'type','text'),'FontSize',18,'fontWeight','bold'); 

eq=x-xq; 
figure(2); 
[N, ab]=hist(eq,15); 
bar(ab,N,'grouped'); 
xlabel('eq'); ylabel('N'); grid on; 
set(gca,'FontSize',18,'fontWeight','bold'); 
set(findall(gcf,'type','text'),'FontSize',18,'fontWeight','bold'); 

% % % 
% tp31.m 
k=0:4095; Te=1e-3; 
tk=k*Te; 
xk=sin(2*pi*tk); 

u=[]; v=[]; 
for n=[2 4 8 16], 
    q=1/2^(n-1); 
    xq=q*round(xk/q); 
    eq=xk-xq; 
    
    u=[u n]; 
    v=[v var(eq)]; 
    
    figure(3); 
    subplot(2,1,1), plot(k,xk,'r-',k,xq,'g-'); 
    ylabel('x, xq'); 
    axis([0 5000 -2 2]); 
    title(['Quantification sur ' num2str(n) ' bits']);     
    subplot(2,1,2), plot(k,eq); 
    xlabel('k'); 
    ylabel('eq'); 
    pause(0.5); 
end 

Rq=10*log10((1/2)./v); 
y=6*u+2; 
figure(5); 
plot(u,Rq,'o',u,y); 
xlabel('n'); ylabel('Rq'); 
grid on; 

% II. preambule 
A=87.6; 
x=0:0.01:1; 
y=zeros(size(x)); 
y=(1+log(A*x))/(1+log(A)); 
indm=find(x < 1/A); 
y(indm)=A/(1+log(A))*x(indm); 

figure(6); 
plot(x,y,'.-'); 
xlabel('x'); 
ylabel('y'); 
grid on; 
set(gca,'FontSize',18,'fontWeight','bold'); 
set(findall(gcf,'type','text'),'FontSize',18,'fontWeight','bold'); 

% % % 
% tp32.m
[Y, Fs, Nbits]=wavread('einstein.wav'); 

k=30101:30256; 
x=Y(k); 
figure(7); 
plot(k,x); 
xlabel('k'); 
ylabel('x'); 

u=x/20; 
n=8; 
q=1/2^(n-1); 
xq=round(u/q)*q; 

figure(8); 
plot(k,u,k,xq); 
ylim([-0.015 0.015]); 
xlabel('k'); 
ylabel('x, xq'); 

% loi A 
indi=find(abs(u) < 1/A); 
y=sign(u).*(1+log(A*abs(u)))/(1+log(A)); 
ui=u(indi); 
y(indi)=ui*A/(1+log(A)); 

yq=round(y/q)*q; 

indj=find(abs(yq) < 1/(1+log(A))); 
xc=1/A*sign(yq).*exp((1+log(A))*abs(yq)-1); 
yqj=yq(indj); 
xc(indj)=(1+log(A))/A*yqj; 

figure(9); 
subplot(3,1,1), plot(k,u); 
subplot(3,1,2), plot(k,xq); 
subplot(3,1,3), plot(k,xc); 

