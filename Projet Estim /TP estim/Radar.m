

dt=1e-05;
fech=200e6;
c=3e08;
t=linspace(0,dt,dt*fech);
t2=linspace(0,length(y)/fech,length(y));
figure;
subplot(2,1,1);
plot(t,x)

subplot(2,1,2);
plot(t2,y)

hopt=flip(x);


w=conv(y,hopt);

t3=linspace(0,length(w)/fech,length(w));

figure;
plot(t3,w);

[a,i]=max(w);
t0=i/fech - dt;
r=c*(t0/2);

