      SUBROUTINE DISPLAY(STATUS,N)
      DIMENSION STATUS(35,35)
      CHARACTER*70 STRING
      
      DO 7 I=1,N
      STRING=' '
      DO 14 J=1,N

      IF (STATUS(I,J).EQ.1.) THEN
      STRING=TRIM(STRING)//' @ '
      ELSE 
      STRING=TRIM(STRING)//' . '
      ENDIF   
      
   14 CONTINUE
      WRITE(*,*)STRING
    7 CONTINUE
C *** UNFORTUNATELY THIS IS QUANTIZED IN UNITS OF 1 SEC
C      CALL SLEEP(1)
C *** ANOTHER WAY TO DO THIS (WASTE SOME TIME)
      DO 17 J=1,5000000
      RN1=RAND()
   17 CONTINUE
      RETURN
      END
C **************************************************
      PROGRAM LIFE
      DIMENSION STATUS(35,35),NEXT(35,35)
      
      N=35
      
      WRITE(*,*)"ENTER 1 FOR MANUAL SETUP, 0 FOR RANDOM"
      READ(*,*)RAN
      
C *** SET UP THE BOARD
      DO 7 I=1,N
      DO 14 J=1,N
      STATUS(I,J)=0.
      NEXT(I,J)=0.
   14 CONTINUE
    7 CONTINUE

      IF(RAN.EQ.1.)THEN     
C *** INITIALIZE LIVE CELLS
   15 WRITE(*,*)'ENTER COORDINATES OF LIVE CELLS, 0,0 WHEN DONE'
      READ(*,*)I,J
      IF((I.EQ.0).AND.(J.EQ.0))GOTO 17
      STATUS(I,J)=1.
C *** DISPLAY MOVE
      CALL DISPLAY(STATUS,N)
      GOTO 15
      ELSE

      WRITE(*,*)"ENTER A FIVE DIGIT INTEGER TO CHANGE SEED"
      READ(*,*)NSEED
      CALL SRAND(NSEED)
      
      DO 57 I=1,N
      DO 54 J=1,N
      RN1=RAND()
Cc *** notice you can change this fraction of live cells in your studies
      IF(RN1.LT.0.5)THEN
      STATUS(I,J)=0.
      ELSE
      STATUS(I,J)=1.
      ENDIF
   54 CONTINUE
   57 CONTINUE
      CALL DISPLAY(STATUS,N)
    
      ENDIF
     
 17   CONTINUE
      
C *** MAKE IT ALIVE!!! ***
C *** SEE http://www.bitstorm.org/gameoflife/
C *** RULES:
C *** For a space that is 'populated':
C *** Each cell with one or no neighbors dies, as if by loneliness. 
C *** Each cell with four or more neighbors dies, as if by overpopulation. 
C *** Each cell with two or three neighbors survives. 
C *** For a space that is 'empty' or 'unpopulated':
C *** Each cell with three neighbors becomes populated. 
      
      WRITE(*,*)"ADJUST YOUR SCREEN TO BE 36 LINES LONG"
   30 DO 10 I = 1, N
      DO 13 J = 1, N

      NE = 0
      IF(I.NE.1 .AND. J.NE.1) THEN
        IF(I.NE.35 .AND. J.NE.35) THEN
          NE = STATUS(I-1,J-1)+STATUS(I-1,J+1)+STATUS(I-1,J)    
     &      +STATUS(I,J-1)+STATUS(I,J+1)+STATUS(I+1,J)    
     &      +STATUS(I+1,J-1)+STATUS(I+1,J+1)
        ELSEIF(I.EQ.35 .AND. J.EQ.35) THEN
          NE = STATUS(I-1,J-1)+STATUS(I-1,J)+STATUS(I,J-1)
        ELSEIF(I.EQ.35) THEN
          NE =  STATUS(I-1,J-1)+STATUS(I-1,J+1)+STATUS(I-1,J)    
     &      +STATUS(I,J-1)+STATUS(I,J+1)
        ELSEIF(J.EQ.35) THEN
          NE =  STATUS(I-1,J-1)+STATUS(I-1,J)    
     &      +STATUS(I,J-1)+STATUS(I+1,J)+STATUS(I+1,J-1)
        ENDIF
      ELSEIF(I.EQ.1 .AND. J.EQ.1) THEN
        NE = STATUS(I,J+1)+STATUS(I+1,J)+STATUS(I+1,J+1)
      ELSEIF(I.EQ.1) THEN  
        NE = STATUS(I,J-1)+STATUS(I,J+1)+STATUS(I+1,J)    
     &      +STATUS(I+1,J-1)+STATUS(I+1,J+1)
      ELSEIF(J.EQ.1) THEN
        NE = STATUS(I-1,J+1)+STATUS(I-1,J)    
     &      +STATUS(I,J+1)+STATUS(I+1,J)+STATUS(I+1,J+1)
      ENDIF

      IF (I.EQ.1.OR.I.EQ.N.OR.J.EQ.N) THEN
      NEXT(I,J)=0
      ENDIF
   
      IF (NE.LE.1) THEN
        NEXT(I,J)=0
        ELSEIF (NE.GE.4) THEN
          NEXT(I,J)=0
        ELSEIF (NE.EQ.2.AND.STATUS(I,J).EQ.1) THEN
          NEXT(I,J)=1
        ELSEIF (NE.EQ.1.OR.NE.EQ.3) THEN
          NEXT(I,J)=1
      ENDIF
      IF ((STATUS(I,J).EQ.0).AND.(NE.EQ.3)) THEN
      NEXT (I,J)=1

      ENDIF
   13 Continue
   10 Continue
      STATUS = NEXT

      CALL DISPLAY(STATUS,N)
      GOTO 30

      
      WRITE(*,*)'DONE, PRESS "RETURN" TO EXIT'   
      STOP
      END

