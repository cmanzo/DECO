function handles=clear_old2(handles)
handles.xteo=[];
handles.F=[];


% handles.coeff=[];
% handles.comp=[];
% handles.errors=[];
% handles.Fcoe=[];
% handles.NLogLik=[];



%set(gca,'Xlim',get(gca,'Xlim'),'Ylim',get(gca,'Ylim'));

%[filename,pathname]=uigetfile('*.txt');
%set(handles.path_file_names,'String',[pathname,filename]);
% if isempty(get(handles.path_file_names,'String'))==0
%     data=load_data(get(handles.path_file_names,'String'),handles);
% end

set(handles.NlogLik_disp,'String','');