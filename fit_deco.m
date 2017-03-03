function handles=fit_deco(handles)


    hh=tic;
    hwai=waitbar(0,'Please wait...');

evenonly=handles.even_comp_val;
Kmax=handles.Nmax_val;

par=[handles.param1_val handles.param2_val];
par=par(isnan(par)==0);

flag=handles.funtypefla;

mini=handles.mini;
Nbins=handles.numofbins_val;

tole=handles.tole_val;

mini=handles.mini;
d=handles.data_f;


%%

[ FF,xteo ] = initi_deco(max(d),Kmax,par,flag,evenonly);

K=Kmax/(1+evenonly);

PARMH=Inf*ones(K,K);

LL=ones(1,K)*Inf;



for k=1:K
    
    
   waitbar(k/K,hwai, ['Fitting with Nmax = ',num2str(k*(1+evenonly)), ' components'] );

    
    F=FF(1:k,:);
    
    par2=ones(1,k)/k;
    
    
    options = optimoptions(@fmincon,'Algorithm','interior-point','Display','off',...
        'MaxFunEvals',1E12,'TolCon',1E-6,'TolX',1E-5,'TolFun',1E-6);
    

    
    parmhatn=fmincon(@(par) obfun1_deco(par,d,k,mini,F,xteo,[],0),par2, [],[], ones(1,k) ,1,...
        1E-12*ones(1,k) , (1-1E-12*ones(1,k)), ...
        [], options);
    
     
    
    PARMH(k,1:k)=parmhatn;
    LL(k)=obfun1_deco(parmhatn,d,k,mini,F,xteo,[],0);
    
    
    clear F parmhatn
end
waitbar(1,hwai, 'Done' );

imin=find(LL==min(LL),1,'first');
F=FF(1:imin,:);


fmix=zeros(size(xteo'));
F=F./repmat(sum( F(:,1:end),2 ),1,length(xteo));
Fcoe=F.*repmat(PARMH(imin,1:imin)',1,length(xteo));
fmix= sum(Fcoe,1);
minNLlik=fmix;

fmix=fmix/sum(fmix(mini:end));


%%
k=imin;
minNLlik2=loglike_deco(PARMH(k,1:k),d,k,mini,FF(1:k,:),xteo,[],0);

waitbar(0,hwai, 'optimization...' );
hh=tic;

par2=[ones(1,k)/k par];

options = optimoptions(@fmincon,'Algorithm','interior-point','Display','off',...
    'MaxFunEvals',1E12,'TolCon',1E-3,'TolX',1E-6,'TolFun',1E-6);


[parmhatn,fval,exitflag,output] =fmincon(@(par) obfun2_deco(par,d,k,mini,minNLlik2,flag,evenonly,hwai,hh),par2, [], [], [ones(1,k) zeros(size(par))] ,1,...
    [1E-12*ones(1,k) par*(1-tole) ], [(1-1E-12*ones(1,k)) par*(1+tole)], ...
    @(par) nonlincon(par,d,mini,minNLlik2,sum((PARMH(imin,1:imin)).*log(PARMH(imin,1:imin))),k,flag,evenonly), options);


parr=parmhatn(k+1:end);

[ F,xteo ] = initi_deco(max(d),(1+evenonly)*k,parr,flag,evenonly);


fmix=zeros(size(xteo'));
F=F./repmat(sum( F(:,1:end),2 ),1,length(xteo));
Fcoe=F.*repmat(parmhatn(1:k)',1,length(xteo));
fmix= sum(Fcoe,1);

n=histc(d,xteo)';

fmix0=fmix/sum(fmix(1:end));
fmix=fmix/sum(fmix(mini:end));

for i=1:size(F,1)
    for j=1:size(F,1)
        J(i,j)=sum(n.*F(i,:).*F(j,:)./(fmix0.^2) )/sum(n);
    end
end


%   CRLB=(sqrt(diag(inv(J))))/sqrt(length(d))
CRLB=(sqrt(1./diag(J)))/sqrt(length(d));


waitbar(1,hwai, 'DONE!' );

close(hwai)

axes(handles.likeliplot);
cla;
semilogy([1:length(LL)]*(1+evenonly),LL,'o')
hold on
imin=find(LL==min(LL),1,'first');
semilogy(imin*(1+evenonly),LL(imin),'sr')
set(handles.likeliplot,'xlim',[(evenonly)+0.5 K*(1+evenonly)+0.5]);


% axes(handles.histandfit);
% hold on
% ax=get(gca,'xlim');
% plot(xteo,fmix,'r','linewidth',2)
% xlim([ax(1) ax(2)/2])

axes(handles.coeff_plot);
cla;
bar([1:k]*(1+evenonly),parmhatn(1:k),0.5/(1+evenonly))
hold on
errorbar([1:k]*(1+evenonly),parmhatn(1:k),CRLB,'.')
set(handles.coeff_plot,'xlim',[(evenonly)+0.5 k*(1+evenonly)+0.5])

%minNLlikFINAL=loglikeONLYmix_deco(parmhatn(1:k),d,k,mini,F,xteo,[],0);

set(handles.NlogLik_disp,'String',num2str(imin*(1+evenonly)));


handles.comp=[1:k]*(1+evenonly);
handles.coeff=parmhatn(1:k);
handles.errors=CRLB';
handles.xteo=xteo;
handles.fmix=fmix;