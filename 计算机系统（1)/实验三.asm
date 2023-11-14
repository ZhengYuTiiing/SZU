	.ORIG x3000		
	LD R0,score		;将x3200存入R0
	LD R1,sortC		;将x4000存入R3
	AND R2,R2,#0		
	ADD R2,R2,#15		
	ADD R2,R2,#1		;将R2置为16，作为计数器

copy	BRz Sort		;判断R5是否为0，若为0，跳出循环
  	LDR R3,R0,#0		;将地址x3200的内容存入R3中
  	STR R3,R1,#0		;将R3的内容存入地址M[R1]
  	ADD R0,R0,#1		
  	ADD R1,R1,#1		
  	ADD R2,R2,#-1		
  	BRnzp copy			
;
;对成绩进行排序（选择排序）如下：
Sort 	LD R1,sortC		
  	AND R2,R2,#0		
  	ADD R2,R2,#15		
  	ADD R2,R2,#1		;R2是外层计数器
JudR1 	BRz over		;R2=0时，跳出外层循环
  	ADD R3,R2,#-1		;R3=R2-1作为内层循环计数器
  	LDR R4,R1,#0		;R4存储最大的数
  	ADD R5,R1 ,#0		;R5为内层指针，
  	ADD R6,R1,#0		;R6存储最小的数的地址
  	NOT R4,R4		
  	ADD R4,R4,#1		;求R4补码

compar 	ADD R5,R5,#1	
  	LDR R7,R5,#0		;将下一个地址的内容存入R7
 	ADD R7,R4,R7		;比较R7与R4内的大小
  	BRnz sub			;如果（R7>R4)那么最大值要更换
	;进行最大值更换
  	LDR R4,R5,#0		；R5是内层
  	NOT R4,R4		
  	ADD R4,R4,#1		
  	ADD R6,R5,#0		;更新R6最小数的地址

sub 	ADD R3,R3,#-1	;内层计数器减去1
  	BRp compar		

	;外层循环：将被比较的数与最大值的位置互换，每次循环，把最大值放在前面
  	LDR R0,R1,#0		;
  	STR R0,R6,#0		;将比较的数存储在最大值所在的地址
  	NOT R4,R4		
  	ADD R4,R4,#1		
  	STR R4,R1,#0      	
  	ADD R1,R1,#1		
  	ADD R2,R2,#-1		;外层循环计数器减1
  	BRnzp JudR1		

;计算获得A的学生人数
over	LD R0,sortA		
	AND R1,R1,#0		;R1为计数器
	AND R2,R2,#0		
	AND R3,R3,#0		
	AND R4,R4,#0		
	AND R5,R5,#0		
	AND R6,R6,#0		
	AND R7,R7,#0		;将R2~R7寄存器都清零
	ADD R1,R1,#4		;M[R4]=4,表示排名前25%即4名

CounA	BRz DataA		;R1为0，跳转去存储学生人数
	ADD R1,R1,#-1		;计数器减一
	LDR R2,R0,#0		
	LD R7,levelA		;M[R7]=-85
	ADD R3,R2,R7		;计算R2-85结果
	BRn compaB		    ;R2<85，去判断是否为B
	ADD R4,R4,#1		;计算等级A的人数，存于R4
	BRnzp addreA		;
compaB  LD R7,levelB		;M[R7]=-75;
	ADD R5,R2,R7		;计算R2-75结果
	BRn addreA		
	ADD R6,R6,#1		;如果前四名有>75且<85的，算入等级B的人数，存于R6

addreA	ADD R0,R0,#1	;地址加1
	ADD R1,R1,#0		
	BRp CounA		
DataA	STI R4,countA	;将等级为A的数量放入地址x5100
;
;计算获得B的人数
	LD R0,sortB		    ;将R0地址从x5008开始
	AND R1,R1,#0		;
	AND R2,R2,#0		;
	AND R3,R3,#0		;清零
	ADD R1,R1,#4		;循环计数器
CounB   ADD R1,R1,#0		
	BRz DateB		
	ADD R1,R1,#-1		;计数器减一
	LDR R2,R0,#0		;将成绩传给R2
	LD R5,levelB		;M[R5]=-75
	ADD R3,R2,R5		;
	BRn addreB		
	ADD R6,R6,#1		;成绩大于75，等级B人数加一
		
addreB	ADD R0,R0,#1		
	BRnzp CounB		
DateB	STI R6,countB	
HALT				
;
levelA .fill #-85		
levelB .fill #-75		
score .fill x3200   	;存放16个成绩的起始地址
sortC .fill x4000   	;存放排序后的成绩C的起始地址
sortB .fill x4004		;存放成绩B的起始地址
sortA .fill x4000		;存放成绩A的起始地址
countA .fill x4100  	;存放成绩A的数量的地址
countB .fill x4101  	;存放成绩B的数量的地址
.END				


