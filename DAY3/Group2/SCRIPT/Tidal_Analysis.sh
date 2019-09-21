Cyclone=Phailin
TG=$1

cp ../DATA/$1_input.dat task_input_process
cp ../DATA/$1_tira.ctl input.ctl

 if [ $TG == "Nagapattinam" ] ; then
     start_dy="27-Sep-2013" ; end_dy="23-Oct-2013"
     start_hr="00:00"       ; end_hr="23:00"
 elif [ $TG == "Chennai" ] ; then    
     start_dy="27-Sep-2013" ; end_dy="23-Oct-2013"
     start_hr="01:00"       ; end_hr="23:00"
 elif [ $TG == "Ennore" ] ; then    
     start_dy="27-Sep-2013" ; end_dy="23-Oct-2013"
     start_hr="00:00"       ; end_hr="23:00"
 elif [ $TG == "Kakinada" ] ; then    
     start_dy="27-Sep-2013" ; end_dy="23-Oct-2013"
     start_hr="00:00"       ; end_hr="23:00" 
 elif [ $TG == "Krishnapatnam" ] ; then    
     start_dy="27-Sep-2013" ; end_dy="23-Oct-2013"
     start_hr="00:00"       ; end_hr="23:00"
 elif [ $TG == "Visakhapatnam" ] ; then    
     start_dy="27-Sep-2013" ; end_dy="23-Oct-2013"
     start_hr="00:00"       ; end_hr="23:00"
 elif [ $TG == "Paradeep" ] ; then
     start_dy="27-Sep-2013" ; end_dy="23-Oct-2013"
     start_hr="01:00"       ; end_hr="16:00"
 fi
 
 conda activate gfortran
 export DYLD_FALLBACK_LIBRARY_PATH=/anaconda2/envs/gfortran/lib:$DYLD_FALLBACK_LIBRARY_PATH

    gfortran tira.f
     ./a.out
#
    gfortran Hourly2Daily.f
     ./a.out
#      
 conda deactivate

 pyferret -script TXT2NC.jnl $TG $start_dy $start_hr $end_dy $end_hr $Cyclone

 mv task_output $1_$Cyclone.dat
 mv output.pri  $1_$Cyclone.pri

 mv $1_$Cyclone.dat $1_$Cyclone.pri ../OUT
