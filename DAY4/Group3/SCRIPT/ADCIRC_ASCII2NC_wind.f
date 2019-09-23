!----------------------------------------------------------
!--------------  ADCIRC Post processing  ------------------
!----------------------------------------------------------
!----------------- Program to Convert --------------------- 
!----------Finite element grid to regular grid-------------
!----------------------------------------------------------
!
! Created on 20190920 by  B.Rohith
!---------------------------------------------------------

        real ssh(300000),LAT(300000),LON(300000)
        real uvel(300000),vvel(300000),pres(300000)
        real LAT_SUB,LON_SUB,sla,i,j,res,band
        real usum,vsum,psum,pavg,uavg,vavg
        integer ID(300000),m,n,subset(300000,1030),cont(300000),k,l
        integer node,time
        character*100 input,output,nodes
        CHARACTER(*), PARAMETER :: inputplace = "../DATA/"
        CHARACTER(*), PARAMETER :: outputplace = "../OUT/"
!------- Resolution of the regular grid (degees)  ------------------
        
        res=0.1      ! Resolution (degree) 
        band=res/2  
        node=116822   ! Total nummer of node points in the model
        Lat_min = 3   ! Minimum Latitude (degree)
        Lat_max = 25  ! Maximum Latitude (degree)
        Lon_min = 78  ! Minimum Longitude (degree)
        Lon_max = 100 ! Maximum Longitude (degree)
        time    = 40  ! Total time step 
!------  Input  data --------------------------------------
        PRINT '('' INPUT FILE NAME  '')'
        read(*,*)input                       ! ADCIRC Input File
        nodes  = "../DATA/Model_Nodes.dat"   ! Model Node file
        output = "Output_wind.txt"                ! Regular output file
!------- Opening Grid and output file from OUT folder------

        open(11,file=nodes)   ! Opening the model's node file

        read(11,*)

        do k=1,node
           read(11,*) LON(k),LAT(k)
        end do
        m=1
        do j=Lat_min,Lat_max,res
           do i=Lon_min,Lon_max,res
              n=1
              do k=1,node
                 LAT_SUB=abs(LAT(k)-j)
                 LON_SUB=abs(LON(k)-i)
                 if (LAT_SUB.lt.band.and.LON_SUB.lt.band) then
                    subset(m,n)=k
                    n=n+1
                 end if
              end do
              if (n.eq.1) then
                 cont(m)=0
              else 
                 cont(m)=n-1
              end if
              m=m+1
          end do 
        end do

        open(10,file=inputplace//input)
        open(40,file=output)

        read(10,*)
        read(10,*)
        do l=1,time
           read(10,*)
           write(*,*)l
           do k=1,node
              read(10,*) ID(k),uvel(k),vvel(k),pres(k)
           end do
           do i=1,m-1
              usum=0
              vsum=0
              psum=0
              kk=0
              if (cont(i).ne.0) then
                 do j=1,cont(i)
                    if (uvel(subset(i,j)).ne.-99999.00000) then
                       usum=usum+uvel(subset(i,j))
                       vsum=vsum+vvel(subset(i,j))
                       psum=psum+pres(subset(i,j))
                       kk=kk+1
                    end if
                 end do
                 uavg=usum/float(kk)
                 vavg=vsum/float(kk)
                 pavg=psum/float(kk)
                 if (uavg.gt.10000.or.uavg.lt.-10000) then
                    write(40,20)-999.0000,-999.0000,-999.0000
                 else
                    write(40,20)uavg,vavg,pavg
                 end if
              else
                 write(40,20)-999.000,-999.0000,-999.0000
                 end if
           end do
        end do
        stop
20      format(3F15.8)
        end
