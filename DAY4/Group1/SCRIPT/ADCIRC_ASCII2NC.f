!----------------------------------------------------------
!--------------  ADCIRC Post processing  ------------------
!----------------------------------------------------------
!----------------- Program to Convert --------------------- 
!----------Finite element grid to regular grid-------------
!----------------------------------------------------------
!
! Created on 20190920 by  B.Rohith
!---------------------------------------------------------
	real ssh(200000),LAT(200000),LON(200000),ssh_sum
	real LAT_SUB,LON_SUB,ssh_avg,i,j
    integer ID(200000),m


!------- Opening Grid and output file from OUT folder------
    
    open(10,file='input_file.dat')
    open(11,file='grid_file.dat')
    open(40,file='output_file.dat')

!------- Opening Grid and output file from OUT folder------
    read(11,*)
    read(11,*)

    do k=1,144258
       read(11,*) LON(k),LAT(k)
    end do
    
    read(10,*)
    read(10,*)
    do m=1,9504
       read(10,*)
       write(*,*)m
       do k=1,144258
           read(10,*) ID(k),ssh(k)
       end do
       do j=-70,30,1
          do i=20,160,1
             ssh_sum=0
             ssh_avg=0
             l=0
             do k=1,144258
                LAT_SUB=abs(LAT(k)-j)
                LON_SUB=abs(LON(k)-i)
                if (LAT_SUB.lt.0.5.and.LON_SUB.lt.0.5.and.ssh(k).
     &                                    ne.-99999.00000) then
                   l=l+1
                   ssh_sum=ssh_sum+ssh(k)
                end if
             end do
             if (l.ne.0) then
               ssh_avg=ssh_sum/l
               write(40,20)i,j,ssh_avg
             else 
               write(40,20)i,j,-999.9999999999
             end if
        
          end do 
       end do 
33  end do   
    stop
20  format(F9.3,2x,F9.3,F20.10)
    end
