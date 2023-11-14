.ORIG    x3000
LD R6,STACK	   ; initialize the stack pointer����ʼ��ջָ��

LD R1,ENTRY;   ; set up the keyboard interrupt vector table entry�����ü����жϺ�
LD R2,START;
STR R2,R1,#0  	;     
;---------------- enable keyboard interrupts����KBSR��IEλ��1
LD R3,IE	;��KBSR��IEλ��1��֧���ж�
STI R3,KBSR           
;---------------- start of actual user program to print ICS checkerboard����ʼ�û�����
PRINT1	LEA R0,LINE1;
	TRAP X22;
	JSR DELAY 		;��ʱ�ӳ����������һ��
	BR PRINT2;

PRINT2	LEA R0,LINE2;
	TRAP X22;
	JSR DELAY;
	BR PRINT1;

HALT
LINE1 .STRINGZ "ICS     ICS     ICS     ICS     ICS     ICS      \n"
LINE2 .STRINGZ "    ICS     ICS     ICS     ICS     ICS          \n" 

;��ʱ�ӳ���countΪ2500ʱ����������ÿ죬�����壬�����Ҿ͸ĳ���25000���������Ĵ�
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
IE	.FILL X4000   ;(0100 0000 0000 0000),������IEΪ��1

.END


