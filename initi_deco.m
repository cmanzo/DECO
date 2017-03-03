function [ F,xteo ] = initi_deco(M,K,par,flag,evenonly)
if K==1 && evenonly==1
    F=[];
    xteo=[];
    errordlg('No data to show!')
    return
else
    
    %     if evenonly==1
    %         if rem(K,2)==0
    %         else
    %             K=K-1;
    %         end
    %     end
    
    F0=Inf*ones(K, M+1);
    i=0;
        
    while F0(K,end)>1E-6
        i=i+1;
        F0=Inf*ones(K, i*M+1);
        xteo=[0:1:i*M];
        if flag==1
            F0(1,:)=lognpdf(xteo,par(1),par(2))';
        elseif flag==2
            F0(1,:)=exppdf(xteo,par(1))';
        end
        
        for k=2:K
            F0(k,:) = ifft(fft( F0(1,:)).^k );
            F0(k,:) = F0(k,:) ./ sum(F0(k,:));
        end
        
        if evenonly==1
            F=F0(2:2:end,:);
        elseif evenonly==0
            F=F0;
        end
    end
end

clear F0