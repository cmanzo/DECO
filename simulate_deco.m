function handles=simulate_deco(handles)

handles.data_f=[];
handles.data=[];

if handles.maxN_val<=1 && handles.even_comp_val==1
    errordlg('Not enough inputs!')
return
else
    
    
if handles.even_comp_val==1
    K=floor(handles.maxN_val/2);
    step=2;
elseif handles.even_comp_val==0
    K=handles.maxN_val;
    step=1;
end


prompt = {'Number of samples',['Insert ', num2str(K), ' w_n :']};

fla=get(handles.popupmenu1,'Value');

dlg_title = 'Input';
num_lines = [1 20*(K)];
defaultans = {'5000',num2str(  round(100*ones(1,K)/K )/100) };
options.Resize='on';
answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);

val1=str2double(answer{1});
val2=str2num(answer{2});


Ntrials=val1;
alphas=val2;
alphas=alphas(1:K);

alphas=alphas/sum(alphas);

Ntrial_a=ceil(alphas.*Ntrials);
x=[];
for i=1:K
    switch fla
        case 1 %'LogNormal'
            x=[x; sum(ceil(random('lognormal',handles.param1_val,handles.param2_val,Ntrial_a(i),step*i)) ,2) ];
        case 2 %'Exponential'
            x=[x; sum(ceil(random('exponential',handles.param1_val,Ntrial_a(i),step*i)) ,2) ];
    end
end

[filename,pathname] = uiputfile('*.txt','Save file as...');
handles.names=[pathname,filename];
dlmwrite(handles.names,x,'delimiter','\t')
handles.names=[pathname,filename];
set(handles.path_file_names,'String',handles.names);

handles.data=x;

handles.mini=min(handles.data);
set(handles.cutoff,'String',num2str(handles.mini));


handles=plot_data(handles);
end
