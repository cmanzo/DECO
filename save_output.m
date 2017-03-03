function handles=save_output(handles)

if isempty(handles.coeff)==0
    [filenameS,pathnameS] = uiputfile('*.txt','Save output data as...');
    fID=fopen([pathnameS, filenameS],'w');
    
    
    fprintf(fID,'DE-CO %20s \r\n  \r\n',date);
 
    fprintf(fID,'Results of the analysis of the file: \r\n %50s \r\n',[handles.names]);
    switch handles.funtypefla
        case 1 %'LogNormal'
            fprintf(fID,'Function type: %12s\r\n','LogNormal');
            fprintf(fID,'with parameters %2.6f and %2.6f\r\n',[handles.param1_val handles.param2_val]);
        case 2 %'Exponential'
            fprintf(fID,'Function type %12s\r\n','Exponential');
            fprintf(fID,'with parameters %2.6f\r\n',[handles.param1_val ]);
    end
    
    fprintf(fID,'over a maximum of N_{max} = %2.0f components, with tolerance = %2.4f and cutoff = %2.0f  \r\n  \r\n ',[handles.Nmax_val handles.tole_val handles.mini]);
   
    fprintf(fID,'Fit results: \r\n');    
    fprintf(fID,'%15s %12s %12s\r\n','# of components','alphas','errors');
    fprintf(fID,'%15.0f %2.10f %2.10f\r\n',[handles.comp; handles.coeff; handles.errors]);
    
    fclose(fID);
    
else
    errordlg('No data to save!')
end
