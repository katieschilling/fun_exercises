      OPEN (UNIT=1,FILE='PI.out',STATUS='UNKNOWN')
      DO 14 K=1,10000
      PI = 0
      COUNT = 0  
      DO 7 J=1,100*K
      X = 0
      Y = 0
      F = 0
      X = RAND()
      Y = RAND()
      D = X*X + Y*Y
      IF (D.LE.1) COUNT = COUNT+1
    7 CONTINUE
      PI = 4 * COUNT/(1000 * K)
      WRITE (1,*) PI
      PERC = K / 100
      WRITE (*,*) PERC, "% DONE"
   14 CONTINUE
      END
