#               DAY 2 - Practical (24-Sep-2019)
## Tidal Analysis using Tide Gauge observations
--- 
### Here we will be using tide guage data for the given location, to extract the Tidal constituents and residual and to plot figures

Groups	| Members | Day 2 - TG Location | Day 3/4 - Tropical Cyclone
--------|---------|---------------------|---------------------------


 Analysis should be done seperately for the given years

### Steps : 

 1. **cd DAY2/Group2-7/SCRIPT**
 
*Go to the SCRIPT folder via terminal*
    
 2. **gfortran tira.f**                 
     this is to Compile TASK-2000 (tira.f)
* After successful compilation **a.out** will be generated as an executable, in the same folder
* Run the created executable corresponding to tira.f 
**./a.out**
     The program asks to input the name of the .ctl file that has been 
                                             #     provided to the group (located inside the DATA folder)
					                         #     Also, specify a name for output file .pri (ouput will be generated in the OUT folder)
 3. **gfortran Hourly2Daily.f**              # Convert hourly to daily for plotting; specify the year of the input data given - Compiles first
      type *./a.out* 	    	             # To Run the complied program
					                         # The program asks to input the name of the .dat file that has been created in step 2 and 
                                             #   located inside the OUT folder
 4. **ferret -script TXT2NC.jnl Year**       # Convert outputs to netcdf ; specify the year the input data given

## ---------  PLOTTING  --------- 

 5.  **cd DAY2/Group2-7/PLOT**         
 
*Go to the PLOT folder via terminal*

 6.  **Pyferret/ferret**   
*and type the following commands step by step, please quite Pyferret/ferret every time when you run individual scripts* 
     
**go 1_Location_map.jnl**         
*Plot the location map using ETOPO1*
     
**go 2_Time_series_tide.jnl Year**    
*Plot the time series comparison *
     
**go 3_Bar_plot.jnl Year**           
*Plot the tidal constituents*
