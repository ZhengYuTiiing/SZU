	.ORIG x3000		
	LD R0,score		;��x3200����R0
	LD R1,sortC		;��x4000����R3
	AND R2,R2,#0		
	ADD R2,R2,#15		
	ADD R2,R2,#1		;��R2��Ϊ16����Ϊ������

copy	BRz Sort		;�ж�R5�Ƿ�Ϊ0����Ϊ0������ѭ��
  	LDR R3,R0,#0		;����ַx3200�����ݴ���R3��
  	STR R3,R1,#0		;��R3�����ݴ����ַM[R1]
  	ADD R0,R0,#1		
  	ADD R1,R1,#1		
  	ADD R2,R2,#-1		
  	BRnzp copy			
;
;�Գɼ���������ѡ���������£�
Sort 	LD R1,sortC		
  	AND R2,R2,#0		
  	ADD R2,R2,#15		
  	ADD R2,R2,#1		;R2����������
JudR1 	BRz over		;R2=0ʱ���������ѭ��
  	ADD R3,R2,#-1		;R3=R2-1��Ϊ�ڲ�ѭ��������
  	LDR R4,R1,#0		;R4�洢������
  	ADD R5,R1 ,#0		;R5Ϊ�ڲ�ָ�룬
  	ADD R6,R1,#0		;R6�洢��С�����ĵ�ַ
  	NOT R4,R4		
  	ADD R4,R4,#1		;��R4����

compar 	ADD R5,R5,#1	
  	LDR R7,R5,#0		;����һ����ַ�����ݴ���R7
 	ADD R7,R4,R7		;�Ƚ�R7��R4�ڵĴ�С
  	BRnz sub			;�����R7>R4)��ô���ֵҪ����
	;�������ֵ����
  	LDR R4,R5,#0		��R5���ڲ�
  	NOT R4,R4		
  	ADD R4,R4,#1		
  	ADD R6,R5,#0		;����R6��С���ĵ�ַ

sub 	ADD R3,R3,#-1	;�ڲ��������ȥ1
  	BRp compar		

	;���ѭ���������Ƚϵ��������ֵ��λ�û�����ÿ��ѭ���������ֵ����ǰ��
  	LDR R0,R1,#0		;
  	STR R0,R6,#0		;���Ƚϵ����洢�����ֵ���ڵĵ�ַ
  	NOT R4,R4		
  	ADD R4,R4,#1		
  	STR R4,R1,#0      	
  	ADD R1,R1,#1		
  	ADD R2,R2,#-1		;���ѭ����������1
  	BRnzp JudR1		

;������A��ѧ������
over	LD R0,sortA		
	AND R1,R1,#0		;R1Ϊ������
	AND R2,R2,#0		
	AND R3,R3,#0		
	AND R4,R4,#0		
	AND R5,R5,#0		
	AND R6,R6,#0		
	AND R7,R7,#0		;��R2~R7�Ĵ���������
	ADD R1,R1,#4		;M[R4]=4,��ʾ����ǰ25%��4��

CounA	BRz DataA		;R1Ϊ0����תȥ�洢ѧ������
	ADD R1,R1,#-1		;��������һ
	LDR R2,R0,#0		
	LD R7,levelA		;M[R7]=-85
	ADD R3,R2,R7		;����R2-85���
	BRn compaB		    ;R2<85��ȥ�ж��Ƿ�ΪB
	ADD R4,R4,#1		;����ȼ�A������������R4
	BRnzp addreA		;
compaB  LD R7,levelB		;M[R7]=-75;
	ADD R5,R2,R7		;����R2-75���
	BRn addreA		
	ADD R6,R6,#1		;���ǰ������>75��<85�ģ�����ȼ�B������������R6

addreA	ADD R0,R0,#1	;��ַ��1
	ADD R1,R1,#0		
	BRp CounA		
DataA	STI R4,countA	;���ȼ�ΪA�����������ַx5100
;
;������B������
	LD R0,sortB		    ;��R0��ַ��x5008��ʼ
	AND R1,R1,#0		;
	AND R2,R2,#0		;
	AND R3,R3,#0		;����
	ADD R1,R1,#4		;ѭ��������
CounB   ADD R1,R1,#0		
	BRz DateB		
	ADD R1,R1,#-1		;��������һ
	LDR R2,R0,#0		;���ɼ�����R2
	LD R5,levelB		;M[R5]=-75
	ADD R3,R2,R5		;
	BRn addreB		
	ADD R6,R6,#1		;�ɼ�����75���ȼ�B������һ
		
addreB	ADD R0,R0,#1		
	BRnzp CounB		
DateB	STI R6,countB	
HALT				
;
levelA .fill #-85		
levelB .fill #-75		
score .fill x3200   	;���16���ɼ�����ʼ��ַ
sortC .fill x4000   	;��������ĳɼ�C����ʼ��ַ
sortB .fill x4004		;��ųɼ�B����ʼ��ַ
sortA .fill x4000		;��ųɼ�A����ʼ��ַ
countA .fill x4100  	;��ųɼ�A�������ĵ�ַ
countB .fill x4101  	;��ųɼ�B�������ĵ�ַ
.END				


