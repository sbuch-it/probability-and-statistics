clear all
close all

% parametro della distribuzione esponenziale
lambda=1;

% provare con 30 50 70
KK=[1, 2, 3, 10, 20];

for h=1:length(KK)

% Stima della pdf per k
k=KK(h);
N=10^6;
W=exprnd(1/lambda,k,N);
H=histogram(sum(W,1),'Normalization','pdf');
XX{h}=H.BinEdges(1:end-1)+H.BinWidth/2;
YY{h}=H.Values;
close
clear W H
end


 CC={[1 0.4 0.6],'m','k','b','r'};
for h=1:length(KK)
    LL{h}=['n=' num2str(KK(h))];
    LL2{2*(h-1)+1}=LL{h};
    LL2{2*(h)}=LL{h};
end
MEAN=1/lambda*KK;
VAR=1/lambda^2*KK;

han=figure;
hold on
grid on
xlabel('x = x_1 + ... + x_n')
ylabel('densità f_X(x)')
title(['Densità della somma di n = ' num2str(KK) '   v.a. ~ exp(' num2str(lambda) ')']);
set(gca,'Fontsize',18);
axis([0,KK(end)*3/2,0,lambda])
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
title(['Densità della somma di n = ' num2str(KK(3:end)) '   v.a. ~ exp(' num2str(lambda) ') e approssimazione normale (---)']);
set(gca,'Fontsize',18);
axis([0,3/2*KK(end),0,lambda])
han.Position=[1 1 1920 965];

for h=3:size(XX,2)
    
    YNORM=normpdf(XX{h},MEAN(h),sqrt(VAR(h)));
    plot(XX{h},YY{h},'Color',CC{h},'Linewidth',2)   
    plot(XX{h},YNORM,'Color',CC{h},'Linewidth',2,'LineStyle','--')
    legend(LL2{5:h*2})
    pause
end