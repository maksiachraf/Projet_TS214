close all ; clear ; clc 

%% Parameters
N=5000;
c=0;
a1=0.1;
a2=0.3;
a3=0.1;
a4=0.4;
A=[1 -a1 -a2 -a3 -a4];
B=1;

%% Filtre 
figure;
zplane(B,A);

b=randn(1,N);

x=filter(B,A,b);
figure
plot(x);

Dsp=abs(fftshift(fft(x))).^2;
f=-1/2:1/N:1/2-1/N;
figure;
semilogy(f,Dsp);


