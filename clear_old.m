function handles=clear_old(handles)
handles.xteo=[];
handles.F=[];
handles.Fcoe=[];


%handles.names=[];
handles.n=[];
handles.xout=[];
% handles.data=[];
% handles.data_f=[];
handles.fmix=[];

handles.coeff=[];
handles.comp=[];
handles.errors=[];
handles.NLogLik=[];

axes(handles.likeliplot);
cla;
axes(handles.coeff_plot);
cla;
axes(handles.histandfit);
cla;

%set(gca,'Xlim',get(gca,'Xlim'),'Ylim',get(gca,'Ylim'));

%[filename,pathname]=uigetfile('*.txt');
%set(handles.path_file_names,'String',[pathname,filename]);
% if isempty(get(handles.path_file_names,'String'))==0
%     data=load_data(get(handles.path_file_names,'String'),handles);
% end

set(handles.NlogLik_disp,'String','');