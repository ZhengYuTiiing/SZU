;主程序
.ORIG X3000
BRnzp pre_MAIN 

;子程序1  打印棋盘
;-------------------------------------
DISPLAY ST R0,SAVER0;
	ST R1,SAVER1;
	ST R2,SAVER2;
	ST R3,SAVER3;
	ST R4,SAVER4;
	ST R5,SAVER5;
	ST R6,SAVER6;
	ST R7,SAVER7;
	AND R3,R3,0;     (R3=i)
	ADD R3,R3,#6;    令R3=6
	LEA R6,mat0x;

loop1	AND R4,R4,#0;     (R4=j)R4=1时要换下一行，要输出回车；
	ADD R4,R4,#6; 
	
loop2	LDR R1,R6,#0		;矩阵的数据存入R1       
	ADD R6,R6,#1		;下一个数据

	ADD R1,R1,#0		;
	BRn player2            ;(<0,输出“X ”,玩家2是X）
	BRz nothing            ;（ =0，输出- ）
	BRp player1            ;(>0,输出“O”，玩家一是O )

player1 LD R0,PLAYO;
	trap x21           
	BRnzp SorE;            ;跳转到输出空格

player2 LD R0,PLAYX;
	trap x21
	BRnzp SorE;

nothing LD R0,PLAYnon;
	trap x21
	


SorE	LD R0,SPACE;
	TRAP X21          ;out
	ADD R4,R4,#-1		;如果不是这行最后一个，继续输出
	BRp loop2;
	    
	LD R0, ENTER; 打印回车      ;是这行的最后一个的话，换行
	TRAP x21
	ADD R3, R3, #-1
	BRp loop1	; 循环1到此结束
		

 	
		LD R0, SAVER0	; 恢复寄存器
		LD R1, SAVER1
		LD R2, SAVER2
		LD R3, SAVER3
		LD R4, SAVER4
		LD R5, SAVER5
		LD R6, SAVER6
		LD R7, SAVER7

RET
;----------------------------------------------------
;子程序2 竖着的|
CASE1	ST R0,SAVER0;
	ST R1,SAVER1;
	ST R2,SAVER2;
	ST R3,SAVER3;
	ST R4,SAVER4;
	ST R5,SAVER5;
	ST R6,SAVER6;
	ST R7,SAVER7;

		AND R1,R1,#0;
		ADD R1,R1,#3;   R1=i,R1=3,外层循环;
		LEA R3,mat0x;

J1_L1 		AND R2,R2,#0;   R2=j,R2=6,内层循环；
		ADD R2,R2,#6;

J1_L2		ADD R4,R3,#-1;
		ADD R4,R4,R2; 	 R4指向这一行的第六个，然后第五个第四个第三个第二个第一个
		AND R5,R5,#0;    R5中放有几个P1的棋；

		LDR R0,R4,#0;    看这一格里是啥棋 1 or -1 or 0;
		BRz j1_l2ed		; 如果遇到0直接break
		ADD R0, R0, #-1		;P1的子
		BRz J1ADD1  ;
		BRnzp j1_ad1         
J1ADD1		ADD R5, R5, #1
j1_ad1		ADD R4, R4, #6	; R4指向下一行
		LDR R0, R4, #0	
		BRz j1_l2ed		; 如果遇到0直接break
		ADD R0, R0, #-1
		BRz J1ADD2  ;
		BRnp j1_ad2 
J1ADD2  	ADD R5, R5, #1
j1_ad2		ADD R4, R4, #6	; R4指向下一行
		LDR R0, R4, #0	
		BRz j1_l2ed		; 如果遇到0直接break
		ADD R0, R0, #-1
		BRz J1ADD3  ;
		BRnp j1_ad3 
J1ADD3  	ADD R5, R5, #1
j1_ad3		ADD R4, R4, #6	; R4指向下一行
		LDR R0, R4, #0	
		BRz j1_l2ed		; 如果遇到0直接break
		ADD R0, R0, #-1
		BRz J1ADD4  ;
		BRnp j1_ad4 
J1ADD4  	ADD R5, R5, #1
j1_ad4		ADD R6, R5, #-4	; 只要能走到这里必定为4个1或-1
		BRz pre_P1WIN	; 如果R5为4则p1赢
		ADD R5, R5, #0
		BRz pre_P2WIN	; 如果R5为0则p2赢

j1_l2ed		ADD R2, R2, #-1
		BRp J1_L2		; 内循环到此结束
	
		ADD R3, R3, #6	; R3指向下一行
		ADD R1, R1, #-1
		BRp J1_L1 ; 外循环到此结束
; 判断|结束
	
		LD R0, SAVER0	; 恢复寄存器
		LD R1, SAVER1
		LD R2, SAVER2
		LD R3, SAVER3
		LD R4, SAVER4
		LD R5, SAVER5
		LD R6, SAVER6
		LD R7, SAVER7	
		RET
;---------------------

;子程序3  判断横着的—
CASE2		ST R0,SAVER0;
		ST R1,SAVER1;
		ST R2,SAVER2;
		ST R3,SAVER3;
		ST R4,SAVER4;
		ST R5,SAVER5;
		ST R6,SAVER6;
		ST R7,SAVER7;

		AND R1,R1,#0;
		ADD R1,R1,#6;   R1=i,R1=6,外层循环;
		LEA R3,mat0x;

J2_L1		AND R2,R2,#0;   R2=j,R2=3,内层循环；
		ADD R2,R2,#3;

J2_L2		ADD R4,R3,#-1;
		ADD R4,R4,R2;    R4指向这一行的第三个第二个第一个
		AND R5,R5,#0;    R5中放有几个P1的棋；

		LDR R0, R4, #0	 
		BRz j2_l2ed		; 如果遇到0直接break
		ADD R0, R0, #-1		;P1的子，R5加一
		BRz J2ADD1		
		BRnzp j2_ad1		
J2ADD1		ADD R5, R5, #1
j2_ad1		LDR R0, R4, #1		;指向右边那个	
		BRz j2_l2ed		; 如果遇到0直接break
		ADD R0, R0, #-1
		BRz J2ADD2
		BRnzp j2_ad2		
J2ADD2		ADD R5, R5, #1
j2_ad2		LDR R0, R4, #1		;指向右边那个	
		BRz j2_l2ed		; 如果遇到0直接break
		ADD R0, R0, #-1
		BRz J2ADD3
		BRnzp j2_ad3		
J2ADD3		ADD R5, R5, #1
j2_ad3		LDR R0,R4,#3			
		BRz j2_l2ed		; 如果遇到0直接break
		ADD R0, R0, #-1
		BRz J2ADD4
		BRnzp j2_ad4		
J2ADD4		ADD R5, R5, #1
j2_ad4		ADD R6, R5, #-4	; 只要能走到这里必定为4个1或2
		BRz pre_P1WIN	; 如果p1计数器为4则p1赢
		ADD R5, R5, #0
		BRz pre_P2WIN	; 如果p1计数器为0则p2赢

j2_l2ed		ADD R2, R2, #-1
		BRp J2_L2		; 内循环到此结束
	
		ADD R3, R3, #6	; R3指向下一行
		ADD R1, R1, #-1
		BRp J2_L1		; 外循环到此结束
; 判断-结束
	
		LD R0, SAVER0	; 恢复寄存器
		LD R1, SAVER1
		LD R2, SAVER2
		LD R3, SAVER3
		LD R4, SAVER4
		LD R5, SAVER5
		LD R6, SAVER6
		LD R7, SAVER7	
		RET	
;-----------------------------------------
pre_MAIN BRnzp preMAIN 

PLAYX 	.FILL 0x58      ;X
PLAYnon .FILL 0x2D	;-
PLAYO 	.FILL 0x4F	;O  
SPACE 	.FILL 0x20	;空格
ENTER 	.FILL 0X0D	;回车

SAVER0 	.FILL #0
SAVER1 	.FILL #0
SAVER2 	.FILL #0
SAVER3 	.FILL #0
SAVER4 	.FILL #0
SAVER5  .FILL #0
SAVER6 	.FILL #0
SAVER7	.FILL #0
;矩阵存放
mat0x	.FILL #0
	.FILL #0		
	.FILL #0		
	.FILL #0		
	.FILL #0		
	.FILL #0
mat1x	.FILL #0	
	.FILL #0		
	.FILL #0		
	.FILL #0		
	.FILL #0		
	.FILL #0
mat2x	.FILL #0	
	.FILL #0		
	.FILL #0		
	.FILL #0		
	.FILL #0		
	.FILL #0
mat3x	.FILL #0	
	.FILL #0		
	.FILL #0		
	.FILL #0		
	.FILL #0		
	.FILL #0
mat4x	.FILL #0	
	.FILL #0		
	.FILL #0		
	.FILL #0		
	.FILL #0		
	.FILL #0
mat50	.FILL #0
mat51	.FILL #0
mat52	.FILL #0
mat53	.FILL #0
mat54	.FILL #0
mat55	.FILL #0

preMAIN BRnzp MAIN;
pre_P1WIN	BRnzp P1WIN;
pre_P2WIN	BRnzp P2WIN;
;子程序4判断斜着的、
CASE3		ST R0,SAVER0;
		ST R1,SAVER1;
		ST R2,SAVER2;
		ST R3,SAVER3;
		ST R4,SAVER4;
		ST R5,SAVER5;
		ST R6,SAVER6;
		ST R7,SAVER7;

		AND R1,R1,#0;
		ADD R1,R1,#3;   R1=i,R1=3,外层循环;
		LEA R3,mat0x;

J3_L1  		AND R2,R2,#0;   R2=j,R2=3,内层循环；
		ADD R2,R2,#3;

J3_L2		ADD R4,R3,#-1;
		ADD R4,R4,R2;  R4指向这一行的第三个，然后第二个，第一个
		AND R5,R5,#0;

		LDR R0, R4, #0	
		BRz j3_l2ed		; 如果遇到0直接break
		ADD R0, R0, #-1
		BRz J3ADD1
		BRnzp j3_ad1		
J3ADD1		ADD R5, R5, #1
j3_ad1		ADD R4, R4, #6	
		LDR R0, R4, #1		; R4指向左上角
		BRz j3_l2ed		; 如果遇到0直接break
		ADD R0, R0, #-1
		BRz J3ADD2
		BRnzp j3_ad2		
J3ADD2		ADD R5, R5, #1
j3_ad2		ADD R4, R4, #6	
		LDR R0, R4, #2		; R4指向左上角
		BRz j3_l2ed		; 如果遇到0直接break
		ADD R0, R0, #-1
		BRz J3ADD3
		BRnzp j3_ad3		
J3ADD3		ADD R5, R5, #1
j3_ad3		ADD R4, R4, #6	
		LDR R0, R4, #3			; R4指向左上角
		BRz j3_l2ed		; 如果遇到0直接break
		ADD R0, R0, #-1
		BRz J3ADD4
		BRnzp j3_ad4		
J3ADD4		ADD R5, R5, #1
j3_ad4		ADD R6, R5, #-4	; 只要能走到这里必定为4个1或2
		BRz pre_P1WIN	; 如果p1计数器为4则p1赢
		ADD R5, R5, #0
		BRz pre_P2WIN	; 如果p1计数器为0则p2赢

j3_l2ed		ADD R2, R2, #-1
		BRp J3_L2		; 内循环到此结束
	
		ADD R3, R3, #6	; R3指向下一行
		ADD R1, R1, #-1
		BRp J3_L1  ; 外循环到此结束
; 判断\结束
	
		LD R0, SAVER0	; 恢复寄存器
		LD R1, SAVER1
		LD R2, SAVER2
		LD R3, SAVER3
		LD R4, SAVER4
		LD R5, SAVER5
		LD R6, SAVER6
		LD R7, SAVER7		
		RET
;-----------------------------------------------------
SAVER00 	.FILL #0
SAVER11 	.FILL #0
SAVER22 	.FILL #0
SAVER33 	.FILL #0
SAVER44 	.FILL #0
SAVER55 	.FILL #0
SAVER66 	.FILL #0
SAVER77 	.FILL #0
;子程序5：判断斜着的/
CASE4		ST R0,SAVER0;
		ST R1,SAVER1;
		ST R2,SAVER2;
		ST R3,SAVER3;
		ST R4,SAVER4;
		ST R5,SAVER5;
		ST R6,SAVER6;
		ST R7,SAVER7;
		
		AND R1,R1,#0;
		ADD R1,R1,#3;   R1=i,R1=3,外层循环;
		LEA R3,mat0x;
	
J4_L1   	AND R2,R2,#0;   R2=j,R2=3,内层循环；
		ADD R2,R2,#3;
J4_L2		ADD R4,R3,#-1;
		ADD R4,R4,R2;  R4指向这一行的第三个，然后第二个，第一个
		AND R5,R5,#0;
		
		LDR R0, R4, #0	
		BRz j4_l2ed		; 如果遇到0直接break
		ADD R0, R0, #-1
		BRz J4ADD1
	        BRnzp j4_ad1 
J4ADD1		ADD R5, R5, #1
j4_ad1	 	ADD R4, R4, #6	; R4指向下一行
		LDR R0, R4, #-1	
		BRz j4_l2ed		; 如果遇到0直接break
		ADD R0, R0, #-1
		BRz J4ADD2
	        BRnzp j4_ad2 
J4ADD2		ADD R5, R5, #1
j4_ad2		ADD R4, R4, #6	; R4指向下一行
		LDR R0, R4, #-2	
		BRz j4_l2ed		; 如果遇到0直接break
		ADD R0, R0, #-1
		BRz J4ADD3
	        BRnzp j4_ad3 
J4ADD3		ADD R5, R5, #1
j4_ad3		ADD R4, R4, #6	; R4指向下一行
		LDR R0, R4, #-3	
		BRz j4_l2ed		; 如果遇到0直接break
		ADD R0, R0, #-1
		BRz J4ADD4
	        BRnzp j4_ad4 
J4ADD4		ADD R5, R5, #1
j4_ad4		ADD R6, R5, #-4	; 只要能走到这里必定为4个1或2
		BRz pre_P1WIN	; 如果p1计数器为4则p1赢
		ADD R5, R5, #0
		BRz pre_P2WIN	; 如果p1计数器为0则p2赢	

j4_l2ed		ADD R2, R2, #-1
		BRp J4_L2		; 内循环到此结束
	
		ADD R3, R3, #6	; R3指向下一行
		ADD R1, R1, #-1
		BRp J4_L1   ; 外循环到此结束
; 判断/结束
		
		LD R0, SAVER0	; 恢复寄存器
		LD R1, SAVER1
		LD R2, SAVER2
		LD R3, SAVER3
		LD R4, SAVER4
		LD R5, SAVER5
		LD R6, SAVER6
		LD R7, SAVER7	
		RET
;------------------------------------------------------------
;

;指针存放
p0	.FILL #0
p1	.FILL #0
p2	.FILL #0
p3	.FILL #0
p4	.FILL #0
p5	.FILL #0
;--------------------------------------------------
;主程序
MAIN	
	AND R1,R1,#0;
	ADD R1,R1,#15;
	ADD R1,R1,#3;

	JSR DISPLAY;
;----------------让1下棋


	LEA R0, mat50		; 列指针赋值	
	ST R0, p0
	LEA R0, mat51		
	ST R0, p1
	LEA R0, mat52		
	ST R0, p2
	LEA R0, mat53		
	ST R0, p3
	LEA R0, mat54		
	ST R0, p4
	LEA R0, mat55		
	ST R0, p5

ma_lp1	ADD R0,R0,#0
AGAIN1	LEA R0, CALL1		; 打印:请玩家2输入
	TRAP x22
	TRAP x20			; 玩家2输入
	TRAP x21
	ADD R0, R0, #-16
	ADD R0, R0, #-16
	ADD R0, R0, #-16 	; 输入-48 ascii转数字
	
	ADD R2, R0, #0		; 输出回车
	LD R0, HUICHE
	TRAP x21
	ADD R0, R2, #0
	
	BRp i1t2			; 判断输入是否>'0'
	LEA R0, ERROR	 ; 输出错误提示
	TRAP x22
	BRnzp AGAIN1	
i1t2	ADD R2, R0, #-7 	; R2=输入-'7'
	BRn i1ed			; 判断输入是否<'7'
	LEA R0, ERROR	 
	TRAP x22
	BRnzp AGAIN1
	
i1ed	AND R2, R2, #0
	ADD R2, R2, #1		; 玩家1填数字1
	LEA R3, p0		; R3取列指针地址
	ADD R3, R3, R0		; R3列指针按照输入偏移
	LDR R4, R3, #-1		; 读取指针数据
	STR R2, R4, #0		; 将数据写入R3指向的地址
	ADD R4, R4, #-6		; 指针--
	STR R4, R3, #-1		; 将偏移后的值存回去
		
	JSR DISPLAY
	JSR CASE1			; 判断 | 输赢
	JSR CASE2			; 判断 \ 输赢
	JSR CASE3			; 判断 / 输赢
	JSR CASE4			; 判断 - 输赢

AGAIN2	LEA R0, CALL2		; 打印:请玩家2输入
	TRAP x22
	TRAP x20			; 玩家2输入
	TRAP x21
	ADD R0, R0, #-16
	ADD R0, R0, #-16
	ADD R0, R0, #-16 	; 输入-48 ascii转数字
	
	ADD R2, R0, #0		; 输出回车
	LD R0, HUICHE
	TRAP x21
	ADD R0, R2, #0
	
	BRp i2t2			; 判断输入是否>'0'
	LEA R0, ERROR	 ; 输出错误提示
	TRAP x22
	BRnzp AGAIN2	
i2t2	ADD R2, R0, #-7 	; R2=输入-'7'
	BRn i2ed			; 判断输入是否<'7'
	LEA R0, ERROR	 
	TRAP x22
	BRnzp AGAIN2	
		
i2ed	AND R2, R2, #0
	ADD R2, R2, #-1	; 玩家2填数字2
	LEA R3, p0		; R3取列指针地址
	ADD R3, R3, R0		; R3列指针按照输入偏移
	LDR R4, R3, #-1		; 读取指针数据
	STR R2, R4, #0		; 将数据写入R3指向的地址
	ADD R4, R4, #-6		; 指针--
	STR R4, R3, #-1		; 将偏移后的值存回去
		
	JSR DISPLAY
	JSR CASE1			; 判断 | 输赢
	JSR CASE2			; 判断 \ 输赢
	JSR CASE3			; 判断 / 输赢
	JSR CASE4			; 判断 - 输赢

	ADD R1, R1, #-1	
	BRp ma_lp1			; 循环到此结束
	
	LEA R0,NOWIN;
	TRAP X22
	BR GOVER;

P1WIN	LEA R0,WIN1;
	TRAP X22;
	BR GOVER;
P2WIN 	LEA R0,WIN2;
	TRAP X22;
	BR GOVER;

GOVER	AND R0,R0,#0

HUICHE	.FILL 0X0D	;回车

CALL1	 .STRINGZ "Player 1, choose a column:"
CALL2 	 .STRINGZ "Player 2, choose a column:"
WIN1	 .STRINGZ "Player 1 Wins.\n"
WIN2 	 .STRINGZ "Player 2 Wins.\n"
NOWIN	 .STRINGZ "Tie Game\n"
ERROR	 .STRINGZ "Invalid move. Try again.\n"
.END