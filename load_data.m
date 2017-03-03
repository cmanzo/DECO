function handles=load_data(handles)
handles.data=dlmread(handles.names);
handles.mini=min(handles.data);
set(handles.cutoff,'String',num2str(handles.mini));
