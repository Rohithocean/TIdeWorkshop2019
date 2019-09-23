!----------------------------------------------------------
!--------------  ADCIRC Post processing  ------------------
!----------------------------------------------------------
!----------------- Program to Convert --------------------- 
!----------Finite element grid to regular grid-------------
!----------------------------------------------------------
!
! Created on 20190920 by  B.Rohith
!---------------------------------------------------------

        real ssh(300000),LAT(300000),LON(300000),ssh_summ
        real LAT_SUB,LON_SUB,ssh_avg,sla,i,j,res,band
        real LON_TG(7),LAT_TG(7),acuracy,l_lat,h_lat,h_lon,l_lon
        integer ID(300000),m,n,subset(300000,1030),cont(300000),k,l
        integer node,time,cnt,val(7),kk
        character*100 input,output,nodes
        character*100::NAM_TG(7)=(/"Nag","Che","Enn","Kri","Kak",
     &    "Vis","Par"/)
        CHARACTER(*), PARAMETER :: inputplace = "../DATA/"
        CHARACTER(*), PARAMETER :: outputplace = "../OUT/"
!------- Resolution of the regular grid (degees)  ------------------
        
        node    = 116822   ! Total nummer of node points in the model
        time    = 1        ! Total time step
        band    = 0.001
        LON_TG  =(/79.850,80.300,80.333,80.133,82.250,83.283,86.700/)
        LAT_TG  =(/10.767,13.100,13.250,14.250,16.933,17.683,20.267 /)
!------  Input  data --------------------------------------
        PRINT '('' INPUT FILE NAME  '')'
        read(*,*)input                       ! ADCIRC Input File
        nodes  = "../DATA/Model_Nodes.dat"   ! Model Node file
        output = "Output_points.txt"                ! Regular output file

!------- Opening Grid and output file from OUT folder------

        open(10,file=inputplace//input)
        open(11,file=nodes)   ! Opening the model's node file
        
        read(10,*)
        read(10,*)
        read(10,*)

        read(11,*)

        do k=1,node
           read(11,*) LON(k),LAT(k)
           read(10,*) ID(k),ssh(k)
        end do
        cnt = 0
         i  = 1
         j  = 1
         m  = 1
30      if (i.gt.7) goto 31
        do k = 1,node
              if (ssh(k).ne.-999.000) then
                 LAT_SUB=abs(LAT(k)-LAT_TG(i))
                 LON_SUB=abs(LON(k)-LON_TG(i))
                 if (LAT_SUB.lt.band.and.LON_SUB.lt.band) then
                    write(*,*)LON_TG(i),LAT_TG(i),k,LON(k),LAT(k),band
                    cnt = cnt+1
                    kk = k
                 end if 
              end if
        end do
        if (cnt.eq.0) then
           band=band + 0.001
           cnt=0
           i=j
        elseif (cnt.eq.1) then
           val(m) = kk
           band = 0.001
           cnt=0
           i=i+1
           j=i
           m=m+1
        end if
        goto 30

31      close (10)
        
        open(12,file=inputplace//input)
        open(13,file=outputplace//output)
        
        read(12,*) 
        read(12,*) 
        
        do l=1,120
           read(12,*)
           write(*,*)l
           do k=1,node
              read(12,*) ID(k),ssh(k)
           end do
           write(13,20) (ssh(val(j))*100,j=1,7)
        end do 
        stop
20      format(7F15.8)
        end
