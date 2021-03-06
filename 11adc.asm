;11章			adc指令：带进位加法指令

;adc是带进位加法指令，它利用了CF上记录的进位值
;指令格式：adc	操作对象1，操作对象2
;功能：操作对象1=操作对象1 + 操作对象2 + CF
;比如指令adc ax,bx 实现的功能是：（ax）=（ax）+（bx）+ CF

;(1)编程，计算1EF000H+201000H,结果放在ax（高16位）和bx（低16位）中。
mov ax,001EH
mov bx,0f000H
add bx,1000H
adc ax,0020H			;指令相当于(ax)=(ax)+0020H+(CF),此时为进位标志位（加法）


;(2)编程，计算1EF0001000H+2010001EF0H,结果放在ax（最高16位）和bx（次高16位）中，
;cx(低16位)。
;计算分三步：
;(1)先将低16位相加，完成后，CF中记录本次相加的进位值
;(2)再将次高16位和CF（来自低16位的进位值）相加，完成后，CF中记录本次相加的进位值
;(3)最后高16位和CF(来自低次高16位的进位值）相加，完成后，CF中记录本次相加的进位值
mov ax,001EH
mov bx,0F000H
mov cx,1000H
add cx,1EF0H
adc bx,1000H
adc ax,0020H
