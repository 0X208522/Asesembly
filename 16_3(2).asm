
;		16_3(2)	直接定址表

;在上一个子程序中，我们更多的是为了算法的清晰和简洁，而采用了查表的方法。下面我们来看一
;下，为了加快运算速度而采用查表的方法的情况。	
			
;编写一个子程序，计算sin(x),x{0,30,60,90,120,150,180},并在屏幕中间显示计算结果。
;比如sin(30)的结果显示为"0.5"。
;我们可以利用麦克劳林公式来计算sin(x).x为角度，麦克劳林公式中需要代入弧度，则：
;sin(x)=sin(y)=y-1/(3!)*y3+1/(5!)*y5
;y=x/180*3.1415926

;可以看出，计算sin(x)需要进行多次乘法和除法。乘除是非常耗时的运算，它们的执行时间
;大约是加法、比较等指令的5倍。如何才能够不做乘除而计算sin(x)呢？我们看一下需要计算的
;sin(x)的结果：
;sin(0)=0
;sin(30)=0.5
;sin(60)=0.866
;sin(90)=1
;sin(120)=0.866
;sin(150)=0.5
;sin(180)=0

;我们可以看出，其实用不着计算，可以占用一些内存空间来换取运算的速度。将所要计算的sin(x)
;的结果都存储到一张表中；然后用角度值来查表，找到对应的sin(x)的值。

;用ax向子程序传递角度，程度如下：

showsin:	jmp short show

	table	dw ag0,ag30,ag60,ag90,ag120,ag150,ag180		;字符串偏移地址
	ag0		db '0',0			;sin(0)对应的字符"0"
	ag30	db '0.5',0			;sin(30)对应的字符"0.5"
	ag60	db '0.866',0		;sin(60)对应的字符"0.866"
	ag90	db '1',0			;sin(90)对应的字符"1"
	ag120	db '0.866',0		;sin(20)对应的字符"0.866"
	ag150	db '0.5',0			;sin(150)对应的字符"0.5"
	ag180	db '0',0			;sin(180)对应的字符"0"
	
show:	push bx
		push es
		push si 
		mov bx,0b800h
		mov es,bx				;指向显存
		
		;以下用角度值/30作为相对于table的偏移，取得对应的字符串的偏移地址，放在bx中
		mov ah,0			;用ax向子程序传递角度，ah置0，al中放角度的初始值
		mov bl,30
		
		div bl				;角度值ax/（bl）30得相对于table的偏移地址
							;商在al中，余数在ah中
		
		mov bl,al			;把al中的偏移地址值放入bl
		mov bh,0			;bh置0，bl中放的是标号table各数据（即每行字符串）的偏移地址
		add bx,bx			;偏移地址再加上偏移地址？为何？
		mov bx,table[bx]	;取得table[bx]每一字符串的（首地址）偏移地址值放入bx中
		
		;以下显示sin(x)对应的字符串
		mov si,160*12+40*2		;在si中放入屏幕中间的位置的数据12行，40列
shows:	mov ah,cs:[bx]			;bx中是每行字符串的(首地址)偏移地址，
								;把相对应字符串的值放入ah
								
		cmp ah,0				;与0比较
		je showret				;相等则跳转到showret
		mov es:[si],ah			;ah中字符串的值放入显存
		inc bx					;指向下一字符串
		add si,2				;指向下一显存
		jmp short shows			;循环执行shows
		
showret:
		pop si
		pop es
		pop bx
		ret
		
;在上面的子程序中，我们在角度值X和表示sin(x)的字符串集合table之间建立的映射关系为：
;以角度值/30为table表中的偏移，可以找到对应的字符串的首地址.

;编程的时候要注意程序的容错性，即对于错误的输入要有处理能力。在上面的子程序中，我们
;还应该再加上对提供的角度值是否超范围的检测。如果提供的角度值不在合法的集合中，程序
;将定位不到正确的字符串，出现错误。对于角度值的检测，请读者自行完成。

;上面的两个子程序中，我们将通过给出的数据进行计算或比较的到结果的问题，转化为用给出
;的数据作为查表的依据，通过查表得到结果的问题。具体的查表方法，是用查表的依据数据，
;直接计算出所要查找的元素在表中的位置。像这种可以通过依据数据，直接计算出所要找的
;元素的位置的表，我们称其为直接定址表。
		
		
