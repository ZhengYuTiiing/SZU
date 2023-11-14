.ORIG x3000

PRINT1	LEA R0,LINE1;
	TRAP X22;
	JSR DELAY;
	BR PRINT2;

PRINT2	LEA R0,LINE2;
	TRAP X22;
	JSR DELAY;
	BR PRINT1;

	HALT
LINE1 .STRINGZ "ICS     ICS     ICS     ICS     ICS     ICS      \n"
LINE2 .STRINGZ "    ICS     ICS     ICS     ICS     ICS          \n" 

DELAY   ST  R1, SaveR1
        LD  R1, COUNT
REP     ADD R1,R1,#-1
        BRp REP
        LD  R1, SaveR1
        RET
COUNT   .FILL #2500
SaveR1  .BLKW 1

.END