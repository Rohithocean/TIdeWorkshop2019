	    real original(3000000),avg1,sum1        
	    integer day(3000000),year(3000000)
        CHARACTER(*), PARAMETER :: inputplace = "../OUT/"
        CHARACTER*40 input
        
        PRINT '('' Input file name (eq. Cochin_2012_output.dat )'')'
        READ(*,*)input
        open(11,file=inputplace//input)
        open(12,file=inputplace//'day_dummy')
        i=1
        m=0
41      read(11,21,end=99)year(i),day(i),original(i)
        i=i+1
        m=m+1
        goto 41

99      k=1
        avg1=0.0
	    sum1=0.0
        do i=1,m
           if (day(i).eq.day(i+1))then
              if (original(i).ne.0.0)then
                 sum1 = sum1+original(i)
                 k=k+1
              end if
           else
              avg1 = sum1/k
              write(12,22)year(i),day(i),avg1
              sum1=0
              avg1=0
              k=1
           end if
        end do

      stop
21      format(10x,i4,1x,i3,16x,F8.2)
22      format(i4,1x,i3,1x,F8.3)
23      format(i4,1x,i3,1x,F8.2)
        end

