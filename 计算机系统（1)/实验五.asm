.ORIG    x3000
LD R6,STACK	   ; initialize the stack pointer，初始化栈指针

LD R1,ENTRY;   ; set up the keyboard interrupt vector table entry，设置键盘中断号
LD R2,START;
STR R2,R1,#0  	;     
;---------------- enable keyboard interrupts，将KBSR的IE位置1
LD R3,IE	;将KBSR的IE位置1，支持中断
STI R3,KBSR           
;---------------- start of actual user program to print ICS checkerboard，开始用户程序
PRINT1	LEA R0,LINE1;
	TRAP X22;
	JSR DELAY 		;延时子程序，让输出慢一点
	BR PRINT2;

PRINT2	LEA R0,LINE2;
	TRAP X22;
	JSR DELAY;
	BR PRINT1;

HALT
LINE1 .STRINGZ "ICS     ICS     ICS     ICS     ICS     ICS      \n"
LINE2 .STRINGZ "    ICS     ICS     ICS     ICS     ICS          \n" 

;延时子程序，count为2500时，还是输出好快，看不清，所以我就改成了25000，还用了四次
DELAY   ST  R1, SaveR1
        LD  R1, COUNT
REP     ADD R1,R1,#-1
        BRp REP
	LD  R1, COUNT
REP1     ADD R1,R1,#-1
        BRp REP1
	LD  R1, COUNT
REP2    ADD R1,R1,#-1
        BRp REP2
	LD  R1, COUNT
REP3    ADD R1,R1,#-1
        BRp REP3
        LD  R1, SaveR1
        RET

COUNT   .FILL #25000
SaveR1  .BLKW 1

KBSR	.FILL XFE00
ENTRY .FILL X0180
START .FILL X2000
STACK .FILL X3000
IE	.FILL X4000   ;(0100 0000 0000 0000),用来吧IE为置1

.END


