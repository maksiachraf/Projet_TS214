%% Variables

R=0.95;
r=0;
theta=pi/3;
var=1;
N=500;
%fech=1e03;
p1=R*exp(1j*theta);
p2=R*exp(-1j*theta);

z1=r*exp(1j*theta);
z2=r*exp(-1j*theta);

P=[1 -(p1+p2) p1*p2];
Z=[1 -(z1+z2) z1*z2];
f=-1/2:1/N:1/2-1/N;
b=randn(1,N);
H=freqz(Z,P,2*pi*f);


%% Analyse 

X=filter(Z,P,b);
DSP=(abs(fftshift(fft(X))).^2)/N;
DSP_th=(abs(H)*var).^2;
%% Affichage

figure;
zplane(Z,P);

figure;
plot(f,abs(H));
xlim([-1,1]);

figure;
semilogy(f,DSP);
hold on;
semilogy(f,DSP_th);
hold off;

figure;
subplot(2,1,1);
plot(linspace(1,N,N),b)

subplot(2,1,2);
plot(linspace(1,N,N),X)

%Partie 3
R=0.95;
theta = [ 0 pi/3 pi/2 2*pi/3 pi ];

for i=1:length(theta)
    p1=R*exp(1j*theta(i));
    p2=R*exp(-1j*theta(i));
    
    z1=r*exp(1j*theta(i));
    z2=r*exp(-1j*theta(i));
    
    P=[1 -(p1+p2) p1*p2];
    Z=[1 -(z1+z2) z1*z2];
    subplot(length(theta),1,i);
    zplane(Z,P); 
end

%Influence de R
theta=pi/3;
R = [ 0 0.3 0.70 0.95 1.2 ];
for i=1:length(R)
    p1=R(i)*exp(1j*theta);
    p2=R(i)*exp(-1j*theta);
    
    z1=r*exp(1j*theta);
    z2=r*exp(-1j*theta);
    
    P=[1 -(p1+p2) p1*p2];
    Z=[1 -(z1+z2) z1*z2];
    H=freqz(Z,P,2*pi*f);
    subplot(length(R),1,i);
    plot(f,abs(H)); 
end

%%Filtre caractérisé par des zeros uniquement

r=0.95;
R=0;
theta=pi/3;
p1=R*exp(1j*theta);
p2=R*exp(-1j*theta);

z1=r*exp(1j*theta);
z2=r*exp(-1j*theta);

P=[1 -(p1+p2) p1*p2];
Z=[1 -(z1+z2) z1*z2];

figure;
zplane(Z,P);
title('Poles et zeros de H');

figure;
freqz(Z,P,2*pi*f);
H=freqz(Z,P,2*pi*f);
n=randn(1,N);
X=filter(Z,P,n);

figure;
subplot(2,1,1);
plot(linspace(1,N,N),n)

subplot(2,1,2);
plot(linspace(1,N,N),X)

DSP=(abs(fftshift(fft(X))).^2)/N;
DSP_th=(abs(H)*var).^2;

figure;
semilogy(f,DSP);
hold on;
semilogy(f,DSP_th);
hold off;

%% Generer une note musicale
fech=8000;
fnote=493.9;

R=0.99999999999;
r=0;
theta=2*pi*(fnote/fech);
var=1;

T=0.4;
N=T*fech;

p1=R*exp(1j*theta);
p2=R*exp(-1j*theta);

z1=r*exp(1j*theta);
z2=r*exp(-1j*theta);

P=[1 -(p1+p2) p1*p2];
Z=[1 -(z1+z2) z1*z2];

b=randn(1,N);

X=filter(Z,P,b);

%soundsc(X,fech);

Notes=[261.6 293.7 329.7 349.2 392 440 493.9];

Partition=[1 1 1 2 3 2 1 3 2 2 1 ; 1 1 1 1 2 2 1 1 1 1 1.5];
M=[];
for i=1:length(Partition)
    
  theta=2*pi*(Notes(Partition(1,i))/fech);
  N=Partition(2,i)*T*fech;
  p1=R*exp(1j*theta);
p2=R*exp(-1j*theta);

z1=r*exp(1j*theta);
z2=r*exp(-1j*theta);

P=[1 -(p1+p2) p1*p2];
Z=[1 -(z1+z2) z1*z2];

b=randn(1,round(N));
X=filter(Z,P,b);
M = [M X];

end

soundsc(M,fech);






