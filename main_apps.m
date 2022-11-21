clear all;

%  2011 dataset
% load('allapps.mat');
% Benign =  Bengin2011;
% Benign_label = Bengin2011_label;
% Malwares = Fullmalware;
% MalLabeles = mal_label;

% Drebin Dataset
% load('mydrebin.mat');
% Benign =  mydrebin(mydrebin_label==0,:);
% Benign_label = mydrebin_label(mydrebin_label==0);
% Malwares = mydrebin(mydrebin_label==1,:);
% MalLabeles = mydrebin_label(mydrebin_label==1);

%   deypir2018 dataset
load('deypir_dataset.mat');
Benign =  Bazarplus;
Benign_label = Bazarplus_label;
Malwares = MilaMal;
MalLabeles = MilaMal_label;

rib = randperm(size(Benign,1));
rim = randperm(size(Malwares,1));
foldsizeB = round(size(Benign,1) * 0.1);
foldsizeM = round(size(Malwares,1) * 0.1);
for i =1:10
    tIndexB = rib(1:foldsizeB);
    tIndexM = rim(1:foldsizeM);
    TIndexB = rib(foldsizeB+1:end);
    TIndexM = rim(foldsizeM+1:end);
    xt = [Benign(tIndexB,:);Malwares(tIndexM,:)];
    yt = [Benign_label(tIndexB); MalLabeles(tIndexM)];
    xti = randperm(size(xt,1));
    xt = xt(xti,:);
    yt = yt(xti);
    xT = [Benign(TIndexB,:);Malwares(TIndexM,:)];
    yT = [Benign_label(TIndexB); MalLabeles(TIndexM)];
    xTi = randperm(size(xT,1));
    xT = xT(xTi,:);
    yT = yT(xTi);
    Res1(i,:) = RSS(xT,yT,xt,yt); %RSS
    Res2(i,:) = IR(xT,yT,xt,yt); %IRS nearest center
    Res3(i,:) = ERisk(xT,yT,xt,yt); % ERS
    Res4(i,:) = NRS(xT,yT,xt,yt); % NRS nearest neighebur with hamming distance
    rib = circshift(rib,[0,foldsizeB]);
end
mRes1 = mean(Res1,1); 
mRes2 = mean(Res2,1);
mRes3 = mean(Res3,1);
mRes4 = mean(Res4,1);
x=0:0.01:1;
hold all;
p= plot(x,mRes1(1,:));
set(p,'Color','red','LineWidth',1.4,'Marker','+','MarkerSize',4);
xlabel('Warning rate','FontSize',12,'FontName','Times','FontWeight','Normal');
ylabel('Detection Rate','FontSize',12,'FontName','Times','FontWeight','Normal');
p = plot(x,mRes2(1,:));
set(p,'Color','blue','LineWidth',1.4,'Marker','.','MarkerSize',4);
p = plot(x,mRes3(1,:));
set(p,'Color','green','LineWidth',1.4,'Marker','*','MarkerSize',4);
p = plot(x,mRes4(1,:));
set(p,'Color','black','LineWidth',1.4,'Marker','^','MarkerSize',4);
hleg= legend('RSS','IRS','ERS','NRS');
set(hleg,'Location','East');
box on; 
figure;

 AUC_RSS1p = trapz(x(1:2),mRes1(1:2));
 AUC_IRS1p = trapz(x(1:2),mRes2(1:2));
 AUC_ERS1p = trapz(x(1:2),mRes3(1:2));
 AUC_NRS1p = trapz(x(1:2),mRes4(1:2));

 AUC_RSS2p = trapz(x(1:3),mRes1(1:3));
 AUC_IRS2p = trapz(x(1:3),mRes2(1:3));
 AUC_ERS2p = trapz(x(1:3),mRes3(1:3));
 AUC_NRS2p = trapz(x(1:3),mRes4(1:3));
 
 AUC_RSS4p = trapz(x(1:5),mRes1(1:5));
 AUC_IRS4p = trapz(x(1:5),mRes2(1:5));
 AUC_ERS4p = trapz(x(1:5),mRes3(1:5));
 AUC_NRS4p = trapz(x(1:5),mRes4(1:5));
% 
 AUC_RSS8p = trapz(x(1:9),mRes1(1:9));
 AUC_IRS8p = trapz(x(1:9),mRes2(1:9));
 AUC_ERS8p = trapz(x(1:9),mRes3(1:9));
 AUC_NRS8p = trapz(x(1:9),mRes4(1:9));
 
% 
 AUC_RSS16p = trapz(x(1:17),mRes1(1:17));
 AUC_IRS16p = trapz(x(1:17),mRes2(1:17));
 AUC_ERS16p = trapz(x(1:17),mRes3(1:17));
 AUC_NRS16p = trapz(x(1:17),mRes4(1:17));
% 
 AUC_RSS32p = trapz(x(1:33),mRes1(1:33));
 AUC_IRS32p = trapz(x(1:33),mRes2(1:33));
 AUC_ERS32p = trapz(x(1:33),mRes3(1:33));
 AUC_NRS32p = trapz(x(1:33),mRes4(1:33));
% 
 AUC_RSS64p = trapz(x(1:65),mRes1(1:65));
 AUC_IRS64p = trapz(x(1:65),mRes2(1:65));
 AUC_ERS64p = trapz(x(1:65),mRes3(1:65));
 AUC_NRS64p = trapz(x(1:65),mRes4(1:65));

 AUC_RSS = trapz(x,mRes1);  %100p
 AUC_IRS = trapz(x,mRes2);  %100p  
 AUC_ERS = trapz(x,mRes3);  %100p  
 AUC_NRS = trapz(x,mRes4);  %100p  

ylabel('Detection Rate','FontSize',12,'FontName','Times','FontWeight','Normal');

str = {'1','2','4','8','16','32','64','100'};
yAUC_RSS=[AUC_RSS1p,AUC_RSS2p,AUC_RSS4p,AUC_RSS8p,AUC_RSS16p,AUC_RSS32p,AUC_RSS64p,AUC_RSS];
yAUC_IRS=[AUC_IRS1p,AUC_IRS2p,AUC_IRS4p,AUC_IRS8p,AUC_IRS16p,AUC_IRS32p,AUC_IRS64p,AUC_IRS];
yAUC_ERS=[AUC_ERS1p,AUC_ERS2p,AUC_ERS4p,AUC_ERS8p,AUC_ERS16p,AUC_ERS32p,AUC_ERS64p,AUC_ERS];
yAUC_NRS=[AUC_NRS1p,AUC_NRS2p,AUC_NRS4p,AUC_NRS8p,AUC_NRS16p,AUC_NRS32p,AUC_NRS64p,AUC_NRS];
YAUC(1,:) =yAUC_RSS;
YAUC(2,:)= yAUC_IRS;
YAUC(3,:)= yAUC_ERS;
YAUC(4,:)= yAUC_NRS;

b=bar(YAUC','Grouped'); %title('AUC');
xticklabels(str);
b(1).FaceColor = 'red';
b(2).FaceColor = 'blue';
b(3).FaceColor = 'green';
b(4).FaceColor = 'black';
% %set(b.Y,'YScale','log');
title('AUC X%','FontName','Times','FontWeight','bold');
xlabel('Warning rates up to X%','FontSize',12,'FontName','Times','FontWeight','Normal');
ylabel('Detection Rate','FontSize',12,'FontName','Times','FontWeight','Normal');
hleg= legend('RSS','IRS','ERS','NRS');
set(hleg,'Location','NorthWest');




