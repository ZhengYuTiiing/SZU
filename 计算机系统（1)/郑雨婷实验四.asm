;������
.ORIG X3000
BRnzp pre_MAIN 

;�ӳ���1  ��ӡ����
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
	ADD R3,R3,#6;    ��R3=6
	LEA R6,mat0x;

loop1	AND R4,R4,#0;     (R4=j)R4=1ʱҪ����һ�У�Ҫ����س���
	ADD R4,R4,#6; 
	
loop2	LDR R1,R6,#0		;��������ݴ���R1       
	ADD R6,R6,#1		;��һ������

	ADD R1,R1,#0		;
	BRn player2            ;(<0,�����X ��,���2��X��
	BRz nothing            ;�� =0�����- ��
	BRp player1            ;(>0,�����O�������һ��O )

player1 LD R0,PLAYO;
	trap x21           
	BRnzp SorE;            ;��ת������ո�

player2 LD R0,PLAYX;
	trap x21
	BRnzp SorE;

nothing LD R0,PLAYnon;
	trap x21
	


SorE	LD R0,SPACE;
	TRAP X21          ;out
	ADD R4,R4,#-1		;��������������һ�����������
	BRp loop2;
	    
	LD R0, ENTER; ��ӡ�س�      ;�����е����һ���Ļ�������
	TRAP x21
	ADD R3, R3, #-1
	BRp loop1	; ѭ��1���˽���
		

 	
		LD R0, SAVER0	; �ָ��Ĵ���
		LD R1, SAVER1
		LD R2, SAVER2
		LD R3, SAVER3
		LD R4, SAVER4
		LD R5, SAVER5
		LD R6, SAVER6
		LD R7, SAVER7

RET
;----------------------------------------------------
;�ӳ���2 ���ŵ�|
CASE1	ST R0,SAVER0;
	ST R1,SAVER1;
	ST R2,SAVER2;
	ST R3,SAVER3;
	ST R4,SAVER4;
	ST R5,SAVER5;
	ST R6,SAVER6;
	ST R7,SAVER7;

		AND R1,R1,#0;
		ADD R1,R1,#3;   R1=i,R1=3,���ѭ��;
		LEA R3,mat0x;

J1_L1 		AND R2,R2,#0;   R2=j,R2=6,�ڲ�ѭ����
		ADD R2,R2,#6;

J1_L2		ADD R4,R3,#-1;
		ADD R4,R4,R2; 	 R4ָ����һ�еĵ�������Ȼ���������ĸ��������ڶ�����һ��
		AND R5,R5,#0;    R5�з��м���P1���壻

		LDR R0,R4,#0;    ����һ������ɶ�� 1 or -1 or 0;
		BRz j1_l2ed		; �������0ֱ��break
		ADD R0, R0, #-1		;P1����
		BRz J1ADD1  ;
		BRnzp j1_ad1         
J1ADD1		ADD R5, R5, #1
j1_ad1		ADD R4, R4, #6	; R4ָ����һ��
		LDR R0, R4, #0	
		BRz j1_l2ed		; �������0ֱ��break
		ADD R0, R0, #-1
		BRz J1ADD2  ;
		BRnp j1_ad2 
J1ADD2  	ADD R5, R5, #1
j1_ad2		ADD R4, R4, #6	; R4ָ����һ��
		LDR R0, R4, #0	
		BRz j1_l2ed		; �������0ֱ��break
		ADD R0, R0, #-1
		BRz J1ADD3  ;
		BRnp j1_ad3 
J1ADD3  	ADD R5, R5, #1
j1_ad3		ADD R4, R4, #6	; R4ָ����һ��
		LDR R0, R4, #0	
		BRz j1_l2ed		; �������0ֱ��break
		ADD R0, R0, #-1
		BRz J1ADD4  ;
		BRnp j1_ad4 
J1ADD4  	ADD R5, R5, #1
j1_ad4		ADD R6, R5, #-4	; ֻҪ���ߵ�����ض�Ϊ4��1��-1
		BRz pre_P1WIN	; ���R5Ϊ4��p1Ӯ
		ADD R5, R5, #0
		BRz pre_P2WIN	; ���R5Ϊ0��p2Ӯ

j1_l2ed		ADD R2, R2, #-1
		BRp J1_L2		; ��ѭ�����˽���
	
		ADD R3, R3, #6	; R3ָ����һ��
		ADD R1, R1, #-1
		BRp J1_L1 ; ��ѭ�����˽���
; �ж�|����
	
		LD R0, SAVER0	; �ָ��Ĵ���
		LD R1, SAVER1
		LD R2, SAVER2
		LD R3, SAVER3
		LD R4, SAVER4
		LD R5, SAVER5
		LD R6, SAVER6
		LD R7, SAVER7	
		RET
;---------------------

;�ӳ���3  �жϺ��ŵġ�
CASE2		ST R0,SAVER0;
		ST R1,SAVER1;
		ST R2,SAVER2;
		ST R3,SAVER3;
		ST R4,SAVER4;
		ST R5,SAVER5;
		ST R6,SAVER6;
		ST R7,SAVER7;

		AND R1,R1,#0;
		ADD R1,R1,#6;   R1=i,R1=6,���ѭ��;
		LEA R3,mat0x;

J2_L1		AND R2,R2,#0;   R2=j,R2=3,�ڲ�ѭ����
		ADD R2,R2,#3;

J2_L2		ADD R4,R3,#-1;
		ADD R4,R4,R2;    R4ָ����һ�еĵ������ڶ�����һ��
		AND R5,R5,#0;    R5�з��м���P1���壻

		LDR R0, R4, #0	 
		BRz j2_l2ed		; �������0ֱ��break
		ADD R0, R0, #-1		;P1���ӣ�R5��һ
		BRz J2ADD1		
		BRnzp j2_ad1		
J2ADD1		ADD R5, R5, #1
j2_ad1		LDR R0, R4, #1		;ָ���ұ��Ǹ�	
		BRz j2_l2ed		; �������0ֱ��break
		ADD R0, R0, #-1
		BRz J2ADD2
		BRnzp j2_ad2		
J2ADD2		ADD R5, R5, #1
j2_ad2		LDR R0, R4, #1		;ָ���ұ��Ǹ�	
		BRz j2_l2ed		; �������0ֱ��break
		ADD R0, R0, #-1
		BRz J2ADD3
		BRnzp j2_ad3		
J2ADD3		ADD R5, R5, #1
j2_ad3		LDR R0,R4,#3			
		BRz j2_l2ed		; �������0ֱ��break
		ADD R0, R0, #-1
		BRz J2ADD4
		BRnzp j2_ad4		
J2ADD4		ADD R5, R5, #1
j2_ad4		ADD R6, R5, #-4	; ֻҪ���ߵ�����ض�Ϊ4��1��2
		BRz pre_P1WIN	; ���p1������Ϊ4��p1Ӯ
		ADD R5, R5, #0
		BRz pre_P2WIN	; ���p1������Ϊ0��p2Ӯ

j2_l2ed		ADD R2, R2, #-1
		BRp J2_L2		; ��ѭ�����˽���
	
		ADD R3, R3, #6	; R3ָ����һ��
		ADD R1, R1, #-1
		BRp J2_L1		; ��ѭ�����˽���
; �ж�-����
	
		LD R0, SAVER0	; �ָ��Ĵ���
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
SPACE 	.FILL 0x20	;�ո�
ENTER 	.FILL 0X0D	;�س�

SAVER0 	.FILL #0
SAVER1 	.FILL #0
SAVER2 	.FILL #0
SAVER3 	.FILL #0
SAVER4 	.FILL #0
SAVER5  .FILL #0
SAVER6 	.FILL #0
SAVER7	.FILL #0
;������
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
;�ӳ���4�ж�б�ŵġ�
CASE3		ST R0,SAVER0;
		ST R1,SAVER1;
		ST R2,SAVER2;
		ST R3,SAVER3;
		ST R4,SAVER4;
		ST R5,SAVER5;
		ST R6,SAVER6;
		ST R7,SAVER7;

		AND R1,R1,#0;
		ADD R1,R1,#3;   R1=i,R1=3,���ѭ��;
		LEA R3,mat0x;

J3_L1  		AND R2,R2,#0;   R2=j,R2=3,�ڲ�ѭ����
		ADD R2,R2,#3;

J3_L2		ADD R4,R3,#-1;
		ADD R4,R4,R2;  R4ָ����һ�еĵ�������Ȼ��ڶ�������һ��
		AND R5,R5,#0;

		LDR R0, R4, #0	
		BRz j3_l2ed		; �������0ֱ��break
		ADD R0, R0, #-1
		BRz J3ADD1
		BRnzp j3_ad1		
J3ADD1		ADD R5, R5, #1
j3_ad1		ADD R4, R4, #6	
		LDR R0, R4, #1		; R4ָ�����Ͻ�
		BRz j3_l2ed		; �������0ֱ��break
		ADD R0, R0, #-1
		BRz J3ADD2
		BRnzp j3_ad2		
J3ADD2		ADD R5, R5, #1
j3_ad2		ADD R4, R4, #6	
		LDR R0, R4, #2		; R4ָ�����Ͻ�
		BRz j3_l2ed		; �������0ֱ��break
		ADD R0, R0, #-1
		BRz J3ADD3
		BRnzp j3_ad3		
J3ADD3		ADD R5, R5, #1
j3_ad3		ADD R4, R4, #6	
		LDR R0, R4, #3			; R4ָ�����Ͻ�
		BRz j3_l2ed		; �������0ֱ��break
		ADD R0, R0, #-1
		BRz J3ADD4
		BRnzp j3_ad4		
J3ADD4		ADD R5, R5, #1
j3_ad4		ADD R6, R5, #-4	; ֻҪ���ߵ�����ض�Ϊ4��1��2
		BRz pre_P1WIN	; ���p1������Ϊ4��p1Ӯ
		ADD R5, R5, #0
		BRz pre_P2WIN	; ���p1������Ϊ0��p2Ӯ

j3_l2ed		ADD R2, R2, #-1
		BRp J3_L2		; ��ѭ�����˽���
	
		ADD R3, R3, #6	; R3ָ����һ��
		ADD R1, R1, #-1
		BRp J3_L1  ; ��ѭ�����˽���
; �ж�\����
	
		LD R0, SAVER0	; �ָ��Ĵ���
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
;�ӳ���5���ж�б�ŵ�/
CASE4		ST R0,SAVER0;
		ST R1,SAVER1;
		ST R2,SAVER2;
		ST R3,SAVER3;
		ST R4,SAVER4;
		ST R5,SAVER5;
		ST R6,SAVER6;
		ST R7,SAVER7;
		
		AND R1,R1,#0;
		ADD R1,R1,#3;   R1=i,R1=3,���ѭ��;
		LEA R3,mat0x;
	
J4_L1   	AND R2,R2,#0;   R2=j,R2=3,�ڲ�ѭ����
		ADD R2,R2,#3;
J4_L2		ADD R4,R3,#-1;
		ADD R4,R4,R2;  R4ָ����һ�еĵ�������Ȼ��ڶ�������һ��
		AND R5,R5,#0;
		
		LDR R0, R4, #0	
		BRz j4_l2ed		; �������0ֱ��break
		ADD R0, R0, #-1
		BRz J4ADD1
	        BRnzp j4_ad1 
J4ADD1		ADD R5, R5, #1
j4_ad1	 	ADD R4, R4, #6	; R4ָ����һ��
		LDR R0, R4, #-1	
		BRz j4_l2ed		; �������0ֱ��break
		ADD R0, R0, #-1
		BRz J4ADD2
	        BRnzp j4_ad2 
J4ADD2		ADD R5, R5, #1
j4_ad2		ADD R4, R4, #6	; R4ָ����һ��
		LDR R0, R4, #-2	
		BRz j4_l2ed		; �������0ֱ��break
		ADD R0, R0, #-1
		BRz J4ADD3
	        BRnzp j4_ad3 
J4ADD3		ADD R5, R5, #1
j4_ad3		ADD R4, R4, #6	; R4ָ����һ��
		LDR R0, R4, #-3	
		BRz j4_l2ed		; �������0ֱ��break
		ADD R0, R0, #-1
		BRz J4ADD4
	        BRnzp j4_ad4 
J4ADD4		ADD R5, R5, #1
j4_ad4		ADD R6, R5, #-4	; ֻҪ���ߵ�����ض�Ϊ4��1��2
		BRz pre_P1WIN	; ���p1������Ϊ4��p1Ӯ
		ADD R5, R5, #0
		BRz pre_P2WIN	; ���p1������Ϊ0��p2Ӯ	

j4_l2ed		ADD R2, R2, #-1
		BRp J4_L2		; ��ѭ�����˽���
	
		ADD R3, R3, #6	; R3ָ����һ��
		ADD R1, R1, #-1
		BRp J4_L1   ; ��ѭ�����˽���
; �ж�/����
		
		LD R0, SAVER0	; �ָ��Ĵ���
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

;ָ����
p0	.FILL #0
p1	.FILL #0
p2	.FILL #0
p3	.FILL #0
p4	.FILL #0
p5	.FILL #0
;--------------------------------------------------
;������
MAIN	
	AND R1,R1,#0;
	ADD R1,R1,#15;
	ADD R1,R1,#3;

	JSR DISPLAY;
;----------------��1����


	LEA R0, mat50		; ��ָ�븳ֵ	
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
AGAIN1	LEA R0, CALL1		; ��ӡ:�����2����
	TRAP x22
	TRAP x20			; ���2����
	TRAP x21
	ADD R0, R0, #-16
	ADD R0, R0, #-16
	ADD R0, R0, #-16 	; ����-48 asciiת����
	
	ADD R2, R0, #0		; ����س�
	LD R0, HUICHE
	TRAP x21
	ADD R0, R2, #0
	
	BRp i1t2			; �ж������Ƿ�>'0'
	LEA R0, ERROR	 ; ���������ʾ
	TRAP x22
	BRnzp AGAIN1	
i1t2	ADD R2, R0, #-7 	; R2=����-'7'
	BRn i1ed			; �ж������Ƿ�<'7'
	LEA R0, ERROR	 
	TRAP x22
	BRnzp AGAIN1
	
i1ed	AND R2, R2, #0
	ADD R2, R2, #1		; ���1������1
	LEA R3, p0		; R3ȡ��ָ���ַ
	ADD R3, R3, R0		; R3��ָ�밴������ƫ��
	LDR R4, R3, #-1		; ��ȡָ������
	STR R2, R4, #0		; ������д��R3ָ��ĵ�ַ
	ADD R4, R4, #-6		; ָ��--
	STR R4, R3, #-1		; ��ƫ�ƺ��ֵ���ȥ
		
	JSR DISPLAY
	JSR CASE1			; �ж� | ��Ӯ
	JSR CASE2			; �ж� \ ��Ӯ
	JSR CASE3			; �ж� / ��Ӯ
	JSR CASE4			; �ж� - ��Ӯ

AGAIN2	LEA R0, CALL2		; ��ӡ:�����2����
	TRAP x22
	TRAP x20			; ���2����
	TRAP x21
	ADD R0, R0, #-16
	ADD R0, R0, #-16
	ADD R0, R0, #-16 	; ����-48 asciiת����
	
	ADD R2, R0, #0		; ����س�
	LD R0, HUICHE
	TRAP x21
	ADD R0, R2, #0
	
	BRp i2t2			; �ж������Ƿ�>'0'
	LEA R0, ERROR	 ; ���������ʾ
	TRAP x22
	BRnzp AGAIN2	
i2t2	ADD R2, R0, #-7 	; R2=����-'7'
	BRn i2ed			; �ж������Ƿ�<'7'
	LEA R0, ERROR	 
	TRAP x22
	BRnzp AGAIN2	
		
i2ed	AND R2, R2, #0
	ADD R2, R2, #-1	; ���2������2
	LEA R3, p0		; R3ȡ��ָ���ַ
	ADD R3, R3, R0		; R3��ָ�밴������ƫ��
	LDR R4, R3, #-1		; ��ȡָ������
	STR R2, R4, #0		; ������д��R3ָ��ĵ�ַ
	ADD R4, R4, #-6		; ָ��--
	STR R4, R3, #-1		; ��ƫ�ƺ��ֵ���ȥ
		
	JSR DISPLAY
	JSR CASE1			; �ж� | ��Ӯ
	JSR CASE2			; �ж� \ ��Ӯ
	JSR CASE3			; �ж� / ��Ӯ
	JSR CASE4			; �ж� - ��Ӯ

	ADD R1, R1, #-1	
	BRp ma_lp1			; ѭ�����˽���
	
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

HUICHE	.FILL 0X0D	;�س�

CALL1	 .STRINGZ "Player 1, choose a column:"
CALL2 	 .STRINGZ "Player 2, choose a column:"
WIN1	 .STRINGZ "Player 1 Wins.\n"
WIN2 	 .STRINGZ "Player 2 Wins.\n"
NOWIN	 .STRINGZ "Tie Game\n"
ERROR	 .STRINGZ "Invalid move. Try again.\n"
.END