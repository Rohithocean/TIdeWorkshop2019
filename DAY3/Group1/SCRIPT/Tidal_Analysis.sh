Cyclone=Thane
TG=$1

cp ../DATA/$1_input.dat task_input_process
cp ../DATA/$1_tira.ctl input.ctl

 if [ $TG == "Nagapattinam" ] ; then
     start_dy="16-Dec-2011" ; end_dy="10-Jan-2012"
     start_hr="00:00"       ; end_hr="23:00"
 elif [ $TG == "Chennai" ] ; then    
     start_dy="16-Dec-2011" ; end_dy="04-Jan-2012"
     start_hr="00:00"       ; end_hr="07:00"
 elif [ $TG == "Ennore" ] ; then    
     start_dy="15-Dec-2011" ; end_dy="09-Jan-2012"
     start_hr="00:00"       ; end_hr="23:00"
 elif [ $TG == "Kakinada" ] ; then    
     start_dy="15-Dec-2011" ; end_dy="09-Jan-2012"
     start_hr="00:00"       ; end_hr="23:00" 
 elif [ $TG == "Krishnapatnam" ] ; then    
     start_dy="15-Dec-2011" ; end_dy="09-Jan-2012"
     start_hr="00:00"       ; end_hr="23:00"
 elif [ $TG == "Visakhapatnam" ] ; then    
     start_dy="15-Dec-2011" ; end_dy="09-Jan-2012"
     start_hr="00:00"       ; end_hr="23:00"
 elif [ $TG == "Paradeep" ] ; then
     start_dy="15-Dec-2011" ; end_dy="09-Jan-2012"
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

 mv task_output $1_Thane.dat
 mv output.pri  $1_Thane.pri

 mv $1_Thane.dat $1_Thane.pri ../OUT
