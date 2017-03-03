function handles=plot_data(handles)
handles.n=[];
handles.fmixint=[];
handles.xout=[];
handles.xout2=[];

handles.data_f=handles.data(find(handles.data>=handles.mini));


handles.xout=[handles.mini:ceil(max(handles.data_f)*1.1)/handles.numofbins_val :ceil(max(handles.data_f)*1.1)];
n=histc(handles.data_f,handles.xout);
handles.n=n/sum(n)/(ceil(max(handles.data_f)*1.1)/handles.numofbins_val);

handles.xout2=handles.xout+mean(diff(handles.xout))/2;

axes(handles.histandfit);
cla;
bar(handles.xout2,handles.n,1)
hold on
if isempty(handles.fmix)==0
    
    
    plot(handles.xteo,handles.fmix,'r','linewidth',2)
    
    
    for i=1:size(handles.xout,2)-1
        
        io=find(handles.xteo>=handles.xout(i) & handles.xteo<handles.xout(i+1) );
        handles.fmixint(i)=sum(handles.fmix(io).*handles.xteo(io))/sum(handles.xteo(io));
        
    end
    plot(handles.xout2(1:end-1),handles.fmixint,'g','linewidth',2)
    
    legend('histogram','pdf','binned pdf')
    
end

set(handles.histandfit,'Xlim',[0 max(handles.data_f)*1.1 ]);




