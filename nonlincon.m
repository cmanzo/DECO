function [c,ceq] = nonlincon(par0,d,mini,minNLlik,minEntro,K,flag,evenonly)

[ F,xteo ] = initi_deco(max(d),(1+evenonly)*K,par0(K+1:end),flag,evenonly);

par=par0(1:K);

n=histc(d,xteo)';
fmix=zeros(size(xteo'));
F=F./repmat(sum( F(:,1:end), 2),1,length(xteo));


F=F.*repmat(par',1,length(xteo));
fmix= sum(F,1);
iok=find(n>0);


NLlik=-sum(n(iok).*log(fmix(iok)));% +((max(d)-min(d))/mean(d))*sum( (par).*log(par) );%/log(length(par));  %


 
c(1) = +(NLlik - minNLlik)/minNLlik;

 
ceq = [];
