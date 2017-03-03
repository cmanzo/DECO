function varargout = deco(varargin)
% DECO MATLAB code for deco.fig
%      DECO, by itself, creates a new DECO or raises the existing
%      singleton*.
%
%      H = DECO returns the handle to a new DECO or the handle to
%      the existing singleton*.
%
%      DECO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DECO.M with the given input arguments.
%
%      DECO('Property','Value',...) creates a new DECO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before deco_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to deco_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%

% Edit the above text to modify the response to help deco

% Last Modified by Carlo Manzo on 02-Feb-2017 21:21:18
% carlo.manzo@uvic.cat


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @deco_OpeningFcn, ...
    'gui_OutputFcn',  @deco_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before deco is made visible.
function deco_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to deco (see VARARGIN)

% initialize additional input variables
%
% variables for simulations only
handles.maxN_val=3;
%
% variables for simulations and fit
handles.funtypefla=1; %1=lognormal, 2=exponential
handles.param1_val=3.3491;
handles.param2_val=0.8462;
handles.normalizefla=1; % fixed in the current version
handles.even_comp_val=0; %0=all, 1=only even;
%
% variables for fit only
handles.tole_val=0;
handles.Nmax_val=10;
%
% variables for fit and display
handles.mini=1;
%
% variables for display only
handles.numofbins_val=100;
handles.names='';
%
%
% initialize ouput variables
% simulations and load output
handles.data_f=[];
handles.data=[];



handles.n=[];
handles.xout=[];
handles.xout2=[];

handles.coeff=[];


handles.errors=[];
handles.xteo=[];
handles.F=[];
handles.Fcoe=[];

handles.fmix=[];

handles.NLogLik=[];

% initialize GUI components
%BOX pdf
set(handles.popupmenu1, 'Value',handles.funtypefla);
set(handles.param1, 'string',num2str(handles.param1_val));
set(handles.param2, 'string',num2str(handles.param2_val));
set(handles.maxN, 'string',num2str(handles.maxN_val));
%set(handles.normalize, 'Value',handles.normalizefla);
set(handles.even_comp, 'Value',handles.even_comp_val);

%BOX Functions
set(handles.Nmax, 'string',num2str(handles.Nmax_val));
set(handles.tole, 'string',num2str(handles.tole_val));

%BOX load
set(handles.numofbins, 'string',num2str(handles.numofbins_val));
set(handles.path_file_names,'String','');
set(handles.cutoff, 'string','1');

% extra
set(handles.NlogLik_disp, 'string','');

% plots
axes(handles.plotcalibfuncts);
cla;

xlabel('# of localizations','HandleVisibility','off')
ylabel('probability density','HandleVisibility','off')
set(gca,'nextplot','replacechildren')


% Choose default command line output for deco
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

handles=display_calibfuncts(handles);

axes(handles.likeliplot);
cla;
xlabel('N_{max}','HandleVisibility','off')
ylabel('Objective Function','HandleVisibility','off')
set(gca,'nextplot','replacechildren')

axes(handles.histandfit);
cla;
xlabel('# of localizations','HandleVisibility','off')
ylabel('probability density','HandleVisibility','off')
set(gca,'nextplot','replacechildren')

axes(handles.coeff_plot);
cla;
xlabel('# of components','HandleVisibility','off')
ylabel('w_n','HandleVisibility','off')
set(gca,'nextplot','replacechildren')


% UIWAIT makes deco wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = deco_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
%%%%%%%%%


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
handles.funtypefla=get(hObject,'Value');
switch handles.funtypefla
    case 1 %'LogNormal'
        handles.param1_val=3.3491;
        handles.param2_val=0.8462;
        set(handles.param1, 'string',num2str(handles.param1_val));
        set(handles.param2, 'string',num2str(handles.param2_val));
        
    case 2 %'Exponential'
        handles.param1_val=25;
        handles.param2_val=NaN;
        set(handles.param1, 'string',num2str(handles.param1_val));
        set(handles.param2, 'string',num2str(handles.param2_val));
                
end
handles=clear_old2(handles);
handles=display_calibfuncts(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'String', {'LogNormal', 'Exponential'});

function param1_Callback(hObject, eventdata, handles)
handles.param1_val=str2num(get(hObject,'String'));
handles=clear_old2(handles);
handles=display_calibfuncts(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function param1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function param2_Callback(hObject, eventdata, handles)
handles.param2_val=str2num(get(hObject,'String'));
if handles.funtypefla==2
    handles.param2_val=NaN;
    set(hObject,'string',num2str(handles.param2_val))
end    
handles=clear_old2(handles);
handles=display_calibfuncts(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function param2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% % --- Executes on button press in normalize.
% function normalize_Callback(hObject, eventdata, handles)
% handles=display_calibfuncts(handles);
% guidata(hObject, handles);

function maxN_Callback(hObject, eventdata, handles)
handles.maxN_val=str2num(get(hObject,'String'));
handles=clear_old2(handles);
handles=display_calibfuncts(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function maxN_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in even_comp.
function even_comp_Callback(hObject, eventdata, handles)
handles.even_comp_val=get(hObject,'Value');
handles=clear_old2(handles);
handles=display_calibfuncts(handles);
guidata(hObject, handles);

% --- Executes on button press in simulate_deco.
function simulate_deco_Callback(hObject, eventdata, handles)
handles=clear_old(handles);
handles=simulate_deco(handles);
guidata(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in loaddata.
function loaddata_Callback(hObject, eventdata, handles)
handles=clear_old(handles);

[filename,pathname]=uigetfile('*.txt');
handles.names=[pathname,filename];
set(handles.path_file_names,'String',handles.names);
handles=load_data(handles);
handles=plot_data(handles);
guidata(hObject, handles);

function numofbins_Callback(hObject, eventdata, handles)
handles.numofbins_val=str2num(get(hObject,'String'));
if isempty(handles.data)==0 && isempty(handles.n)==0
    if handles.numofbins_val<=max(handles.data)-handles.mini
    else
        handles.numofbins_val=max(handles.data)-handles.mini;
        set(hObject,'String',num2str(handles.numofbins_val));
    end
    handles=plot_data(handles);
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function numofbins_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cutoff_Callback(hObject, eventdata, handles)
handles.mini=max([min(handles.data) str2num(get(hObject,'String'))]);
set(hObject,'String',num2str(handles.mini));
if isempty(handles.data)==0 && isempty(handles.n)==0
handles.fmix=[];
handles=plot_data(handles);
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function cutoff_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in fit_button.
function fit_button_Callback(hObject, eventdata, handles)
handles=clear_old(handles);
handles=fit_deco(handles);
handles=plot_data(handles);
guidata(hObject, handles);


function Nmax_Callback(hObject, eventdata, handles)
handles.Nmax_val=str2double(get(hObject,'String'));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Nmax_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function tole_Callback(hObject, eventdata, handles)
handles.tole_val=str2double(get(hObject,'String')); 
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function tole_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function path_file_names_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function path_file_names_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in save_out.
function save_out_Callback(hObject, eventdata, handles)
handles=save_output(handles);


function NlogLik_disp_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function NlogLik_disp_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




