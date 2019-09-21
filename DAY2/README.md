#               DAY 2 (24-Sep-2019)
# Tidal Analysis using Tide Gauge observations
---  
## Here we will be using tide guage data for the given location, to extract the Tidal constituents and residual and to plot figures

## Analysis should be done seperately for the given years

### Steps : 

 1. Go to the SCRIPT folder via terminal    # Script Folder

 2. type 
   ```fortran 
      gfortran tira.f                           # To Compile tira.f (TASK-2000)
                                             #    After successful compilation 'a.out' will be generated as an executable, in the same folder
     ..* type ./a.out                      # To Run the created executable corresponding to tira.f 
                                             #     The program asks to input the name of the .ctl file that has been 
                                             #     provided to the group (located inside the DATA folder)
					                         #     Also, specify a name for output file .pri (ouput will be generated in the OUT folder)
 (3) type gfortran Hourly2Daily.f            # Convert hourly to daily for plotting; specify the year of the input data given - Compiles first
     (3.1) type ./a.out 		             # To Run the complied program
					                         # The program asks to input the name of the .dat file that has been created in step 2 and 
                                             #   located inside the OUT folder
 (4) type ferret -script TXT2NC.jnl Year     # Convert outputs to netcdf ; specify the year the input data given


---------  PLOTTING  --------- 

 (5) Go to PLOT folder                       # Plotting Scripts 
 (6) Open Pyferret/ferret and type the following commands step by step, please quite Pyferret/ferret every time when you run individual scripts           
     (6.1) go 1_Location_map.jnl             # Plot the location map using ETOPO1 
     (6.2) go 2_Time_series_tide.jnl Year    # Plot the time series comparison 
     (6.3) go 3_Bar_plot.jnl Year            # Plot the tidal constituents
     (6.4) etc
 
