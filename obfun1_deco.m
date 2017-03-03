%%%%%%%%%%%%%%%
function [NLlik]=obfun1_deco(par,d,K,mini,F,xteo,bo,hh)

if hh~=0
waitbar(rem(toc(hh)/30,30));
end

n=histc(d,xteo)';
fmix=zeros(size(xteo'));
%F(:,1:mini-1)=0;
F=F./repmat(sum( F(:,1:end), 2),1,length(xteo));
F=F.*repmat(par',1,length(xteo));
fmix= sum(F,1);
iok=find(n>0);

NLlik=-sum(n(iok).*log(fmix(iok))) +((max(d)-min(d))/mean(d))*sum( (par).*log(par) );%/log(length(par));  %
