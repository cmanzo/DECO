function handles=display_calibfuncts(handles)
axes(handles.plotcalibfuncts);
cla;
% if isempty(handles.F)==0
%     
%     if handles.normalizefla==0
%         for i=1:size(handles.Fcoe,1)%str2num(get(handles.maxN,'String'))
%             plot(handles.xteo,handles.Fcoe(i,:),'-')
%             hold on
%         end
%         set(handles.plotcalibfuncts,'Xlim',[0 min([ size(handles.Fcoe,2)-find(fliplr(handles.Fcoe(end,:))>1E-4,1,'first') , size(handles.Fcoe,2)] )]);
%         %hold off
%         
%     elseif handles.normalizefla==1
%         for i=1:size(handles.F,1)%str2num(get(handles.maxN,'String'))
%             plot(handles.xteo,handles.F(i,:),'-')
%             hold on
%         end
%         set(handles.plotcalibfuncts,'Xlim',[0 min([ size(handles.F,2)-find(fliplr(handles.F(end,:))>1E-4,1,'first') , size(handles.F,2)] )]);
%         %hold off
%     end
%     
%     
% else
    
    [ handles.F,handles.xteo ] = initi_deco(300,handles.maxN_val,[handles.param1_val,...
        handles.param2_val],handles.funtypefla, handles.even_comp_val);
    
    if isempty(handles.F)==0
        for i=1:size(handles.F,1)%str2num(get(handles.maxN,'String'))
            plot(handles.xteo,handles.F(i,:),'-')
            hold on
        end
        
        set(handles.plotcalibfuncts,'Xlim',[0 min([ size(handles.F,2)-find(fliplr(handles.F(end,:))>1E-4,1,'first') , size(handles.F,2)] )]);
        %hold off
    end
    
%end


