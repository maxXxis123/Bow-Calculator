function varargout = Bow_calc(varargin)
% BOW_CALC MATLAB code for Bow_calc.fig
%      BOW_CALC, by itself, creates a new BOW_CALC or raises the existing
%      singleton*.
%
%      H = BOW_CALC returns the handle to a new BOW_CALC or the handle to
%      the existing singleton*.
%
%      BOW_CALC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BOW_CALC.M with the given input arguments.
%
%      BOW_CALC('Property','Value',...) creates a new BOW_CALC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Bow_calc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Bow_calc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Bow_calc

% Last Modified by GUIDE v2.5 29-Sep-2021 11:27:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Bow_calc_OpeningFcn, ...
                   'gui_OutputFcn',  @Bow_calc_OutputFcn, ...
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


% --- Executes just before Bow_calc is made visible.
function Bow_calc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Bow_calc (see VARARGIN)

% Choose default command line output for Bow_calc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Bow_calc wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Bow_calc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile('C:\*.csv','Multiselect', 'on');
len1=size(file);
    file1=file;
    file=file.';
    for m=1:len1(2)
        temp=strsplit(file{m,1},'-');
        file{m,2}=temp{1};
        temp=strsplit(temp{end},'.');
        file{m,3}=str2num(temp{1})
    end
    try
    handles.file_list=sortrows(file,[3,2]);
    catch
      handles.file_list=sortrows(file,[2,1]);  
    end
temp=strsplit(handles.file_list{1,2},'.');
t_str=str2num(temp{1});
indx=[];
for j=2:len1(2)
    temp=strsplit(handles.file_list{j,2},'.');
    if ~(t_str==str2num(temp{1}))
        indx(end+1)=j;
        t_str=str2num(temp{1});
    end
end
len2=size(indx)
if len2(1)>0
    for m=1:(len2(1)+1)
        if m<len2(1)+1
            handles.files_list{1}=handles.file_list(1:indx(m)-1).';
        else
            handles.files_list{end+1}=handles.file_list(indx(end):end,1);
        end
    end
else
    handles.files_list=handles.file_list(:,1);
end
handles.path=path;
set(handles.listbox1,'String',handles.file_list(:,1));
guidata(hObject, handles);
% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uiputfile('.csv')
tmp_str= strsplit(file,'.')
len_big_l=size(handles.files_list)

   
len_list=size(handles.file_list)
Final_list={};
for i=1:len_list(1)
    x=fast_csv([handles.path handles.file_list{i}])
    temp{1,1}=handles.file_list{i};
    temp{2,1}=x{14,2}
    tmp=vertcat(temp,x{18:33,3})
%     Final_list{end+1,1}=handles.file_list{i};
%     Final_list{end,2}=x{14,2}
%     Final_list{end,3:end}=x{18:33,3}
Final_list(:,end+1)=tmp
end
Final_list{1,end+1}='stdev.s';  
Final_list{2,end}=std(str2double(Final_list(2,1:end-1)));
Final_list{1,end+1}='P\T ratio';    
Final_list{2,end}=100*Final_list{2,end-1}/12; 
  
xlswrite([path tmp_str{1} '.xlsx'],Final_list) 
