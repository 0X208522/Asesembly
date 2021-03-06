;11.9(3) 编程，统计data段中数值小于8的字节的个数，用ax保存统计结果
assume cs:code,ds:data

data segment

	db 8,11,8,1,8,5,63,38
	
data ends

code segment

start:	mov ax,data
		mov ds,ax
		
		mov ax,0
		
		mov bx,0
		mov cx,8
		
	s:	cmp byte ptr [bx],8
		jnb next			;如果不小于8转到next，继续循环
		inc ax				;如果小于8就将计数加1
	
next:	inc bx
		loop s 
		
code ends

end start