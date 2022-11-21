%xT Train data
%yT Train label
%xt Test data
%yt Test label
    %KNN based risk score computation for urls
function Res = NRS(xT, yT, xt, yt)
    MxT = xT(yT == 1,:);
    BxT = xT(yT == 0,:);
    [IdMxT,MD] = knnsearch(MxT,xt,'K',10,'distance','hamming');% default k =1 
    [IdBxT,BD] = knnsearch(BxT,xt,'K',10,'distance','hamming');
    MD = mean(MD,2);
    BD = mean(BD,2);
    %IdMxT = knnsearch(MxT,xt);% default k =1 
    %IdBxT = knnsearch(BxT,xt);
    %MD = sqrt(sum(( xt - xT(IdMxT,:)).^2,2));
    %MD = sum(xt ~= xT(IdMxT,:),2); % hamming distance
    %BD = sqrt(sum(( xt - xT(IdBxT,:)).^2,2));
    %BD = sum(xt ~= xT(IdBxT,:),2);
    risks = BD ./ MD;
    %risks = BD;
    [V,IX] = sort(risks,'descend'); %sorting all risk score in descending order to find top score apps
    lab =yt(IX);       % finding label of sorted apps
    N = size(xt,1);    % N is the number of all tested apps
    j =0;
    for i=0.01:0.01:1
        topip =  round(N*i);   % finding the number of top i prescent apps
      %  sum(lab(1:topip));        % finding the label of top 5 prescent apps and then counting the number of malware within top 5(by summation of label 1)  
        j = j+1;
        DetMals(j) = sum(lab(1:topip)); 
        AUC(j) = sum(lab(1:topip))/ topip; % finding area under curve for topi
    end
    Res= [0,DetMals/size(xt(yt == 1,:),1)];
    