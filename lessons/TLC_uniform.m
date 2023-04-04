clear all
close all

dx=0.01;
xpad=[-1:dx:0];
ypad=zeros(size(xpad));
xfin=[3:dx:20];
yfin=zeros(size(xfin));

x1=[0:dx:1];
x2=[1:dx:2];
x3=[2:dx:3];
X=[xpad, x1, x2, x3, xfin];

% pdf of x1 ~ U[0,1]
y11=ones(size(x1));
Y1=[ypad, y11, zeros(size(x2)), zeros(size(x3)), yfin];

% pdf of x1 + x2 ~ U[0,1]
y12=x1;
y22=2-x2;
Y2=[ypad, y12, y22, zeros(size(x3)), yfin];

% pdf of x1 + x2 +x3 ~ U[0,1]
y13=x1.^2/2;
y23=-x2.^2+3*x2-3/2;
y33=(3-x3).^2/2;
Y3=[ypad, y13, y23, y33, yfin];

% Stima della pdf per k=10
k=10;
N=10^6;
W=rand(k,N);
H=histogram(sum(W),'Normalization','pdf');
X4=H.BinEdges(1:end-1)+H.BinWidth/2;
Y4=H.Values;
close 

% Stima della pdf per k=20
k=20;
N=10^6;
W=rand(k,N);
H=histogram(sum(W),'Normalization','pdf');
X5=H.BinEdges(1:end-1)+H.BinWidth/2;
Y5=H.Values;
close 

% For plot
XX={X,X,X,X4,X5};
YY={Y1,Y2,Y3,Y4,Y5};
CC={[1 0.4 0.6],'m','k','b','r'};
LL={'n=1','n=2','n=3','n=10','n=20'};
LL2={'n=1','n=1','n=2','n=2','n=3','n=3','n=10','n=10','n=20','n=20'};
MEAN={1*0.5, 2*0.5, 3*0.5,10*0.5,20*0.5};
VAR={1*1/12, 2*1/12, 3*1/12, 10*1/12, 20*1/12};

han=figure;
hold on
grid on
xlabel('x = x_1 + ... + x_n')
ylabel('densità f_X(x)')
title('Densità della somma di n = 1 2 3 10 20   v.a. ~ U[0,1]')
set(gca,'Fontsize',18);
axis([-1,20,-.5,1.5])
han.Position=[1 1 1920 965];

for h=1:size(XX,2)

    plot(XX{h},YY{h},'Color',CC{h},'Linewidth',2)  
    legend(LL{1:h})
    pause
end

han=figure;
hold on
grid on
xlabel('x = x_1 + ... + x_n')
ylabel('densità f_X(x)')
title('Densità della somma di n = 3 10 20   v.a. ~ U[0,1] e approssimazione normale (---)')
set(gca,'Fontsize',18);
axis([-1,20,-.5,1.5])
han.Position=[1 1 1920 965];

for h=3:size(XX,2)
    
    YNORM=normpdf(XX{h},MEAN{h},sqrt(VAR{h}));
    plot(XX{h},YY{h},'Color',CC{h},'Linewidth',2)   
    plot(XX{h},YNORM,'Color',CC{h},'Linewidth',2,'LineStyle','--')
    b = gca; legend(b,'off');
    legend(LL2{5:h*2})
    pause
end