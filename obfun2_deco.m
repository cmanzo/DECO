function [NLlik]=obfun2_deco(par0,d,K,mini,minNLlik2,flag,evenonly,hwai,hh)

if hh~=0
waitbar(rem(toc(hh)/30,30)-floor(toc(hh)/30),hwai);
end


[ F,xteo ] = initi_deco(max(d),(1+evenonly)*K,par0(K+1:end),flag,evenonly);

par=par0(1:K);

n=histc(d,xteo)';
fmix=zeros(size(xteo'));

F=F./repmat(sum( F(:,1:end), 2),1,length(xteo));

F=F.*repmat(par',1,length(xteo));
fmix= sum(F,1);
iok=find(n>0);

NLlik=((max(d)-min(d))/mean(d))*sum( (par).*log(par) ) - sum(n(iok).*log(fmix(iok)))/minNLlik2 ;  %
