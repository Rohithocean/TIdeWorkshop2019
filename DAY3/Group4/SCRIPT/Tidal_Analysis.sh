Cyclone=Titli
TG=$1

cp ../DATA/$1_input.dat task_input_process
cp ../DATA/$1_tira.ctl input.ctl

# if [ $TG == "Nagapattinam" ] ; then
#     start_dy="01-Oct-2018" ; end_dy="20-Oct-2018"
#     start_hr="02:00"       ; end_hr="10:00"
# elif [ $TG == "Chennai" ] ; then    
#     start_dy="01-Oct-2018" ; end_dy="20-Oct-2018"
#     start_hr="00:00"       ; end_hr="07:00"
 if [ $TG == "Ennore" ] ; then    
     start_dy="01-Oct-2018" ; end_dy="20-Oct-2018"
     start_hr="00:00"       ; end_hr="23:00"
 elif [ $TG == "Kakinada" ] ; then    
     start_dy="01-Oct-2018" ; end_dy="20-Oct-2018"
     start_hr="00:00"       ; end_hr="23:00" 
 #elif [ $TG == "Krishnapatnam" ] ; then    
 #    start_dy="01-Oct-2018" ; end_dy="20-Oct-2018"
 #    start_hr="00:00"       ; end_hr="23:00"
 elif [ $TG == "Visakhapatnam" ] ; then    
     start_dy="01-Oct-2018" ; end_dy="15-Oct-2018"
     start_hr="00:00"       ; end_hr="06:00"
 elif [ $TG == "Paradeep" ] ; then
     start_dy="01-Oct-2018" ; end_dy="20-Oct-2018"
     start_hr="00:00"       ; end_hr="23:00"
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
