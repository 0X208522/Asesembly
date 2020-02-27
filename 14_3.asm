
;				14.3	shl和shr指令

;shl和shr是逻辑转移指令

;shl是逻辑左移指令，它的功能为：
;(1)将一个寄存器或内存单元中的数据想左移位
;(2)将最后移出的一位写入标志寄存器CF中
;(3)最低位用0补充

;指令：
mov al,01001000b
shl al,1		;将al中的数据左移一位
				;执行后（al）=10010000b,CF=0
				
				
shl al,1		;如果接着上面继续执行一句shl al,1
				;将al中的数据左移一位
				;执行后（al）=00100000b，CF=1
				
				
	
;如果移动位数大于1时，必须将移动位数放在cl中：
;比如，指令：
mov al,01010001b
mov cl,3
shl al,cl

;执行后(al)=10001000b,因为最后移出的一位是0，所以CF=0.

;可以看出，将X逻辑左移一位，相当于执行X=X*2
;比如：
mov al,00000001b		;执行后(al)=00000001b=1
shl al,1				;执行后(al)=00000010b=2
shl al,1				;执行后(al)=00000100b=4
shl al,1				;执行后(al)=00001000b=8
mov cl,3
shl al,cl				;执行后(al)=01000000b=64
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;shr是逻辑右移指令，它和shl所进行的操作刚好相反。

;(1)将一位寄存器或内存单元中的数据刚好相反。
;(2)将最后移出的一位写入标志寄存器CF中
;(3)最高位用0补充

;指令：
;mov al,10000001b
;shr al,1				;将al中的数据右移一位

;执行后(al)=01000000b,CF=1
;如果接着上面，继续执行一条shr al,1,则执行后：(al)=00100000b,CF=0
;如果位移位数大于1时,必须将移动位数放在cl中：
;比如，指令：
mov al,01010001b
mov cl,3
shr al,cl
;执行后(al)=00001010吧，因为最后移出的一位是0，所以CF=0
;可以看出将X逻辑右移一位，相当于执行X=X/2.


