clear all
close all

% parametro p della distribuzione binomiale
p=0.9;

% parametro n
NN=[2, 3, 5, 10, 20];

for h=1:length(NN)

    n=NN(h);
    
    for k=0:n
        
        tmp(k+1)=nchoosek(n,k)*p^k*(1-p)^(n-k);
        
    end
    XX{h} = [0:n];
    YY{h} = tmp;
    clear tmp
end

CC={[1 0.4 0.6],'m','k','b','r'};
for h=1:length(NN)
    LL{h}=['n=' num2str(NN(h))];
    LL2{2*(h-1)+1}=LL{h};
    LL2{2*(h)}=LL{h};
end

MEAN=NN*p;
VAR=NN*p*(1-p);

han=figure;
hold on
grid on
xlabel('x = x_1 + ... + x_n              [N.B. X~B(n,p)]')
ylabel('PMF p_X(x)')
%title(['Densità binomiale con p = ' num2str(p) ' e n = ' num2str(NN) ]);
title(['Funzione massa di probabilità della somma di n = ' num2str(NN) '   v.a. di Bernoulli, con p = ' num2str(p)]);
set(gca,'Fontsize',18);
axis([0,NN(end)+5,0,1])
han.Position=[1 1 1920 965];

for h=1:size(XX,2)

    stem(XX{h},YY{h},'Color',CC{h},'Linewidth',2)  
    legend(LL{1:h})
    pause
end

han=figure;
hold on
grid on
xlabel('x = x_1 + ... + x_n              [N.B. X~B(n,p)]')
ylabel('PMF p_X(x)')
%title(['Densità binomiale con p = ' num2str(p) ' e n = ' num2str(NN) ]);
title(['Funzione massa di probabilità della somma di n = ' num2str(NN) '   v.a. di Bernoulli, con p = ' num2str(p)]);
set(gca,'Fontsize',18);
axis([0,NN(end)+5,0,1])
han.Position=[1 1 1920 965];

for h=3:size(XX,2)
    
    xtmp=XX{h};
    dx=0.05;
    XNORM=[xtmp(1)-5:dx:xtmp(end)+5];
    YNORM=normpdf(XNORM,MEAN(h),sqrt(VAR(h)));
    stem(XX{h},YY{h},'Color',CC{h},'Linewidth',2)   
    plot(XNORM,YNORM,'Color',CC{h},'Linewidth',2,'LineStyle','--')
    b = gca; legend(b,'off');
    legend(LL2{5:h*2})
    pause
end