
;	和13.6	BIOS中断例程应用

;int 10h中断例程是BIOS提供的中断例程，其中包含了多个和屏幕输出相关的子程序。
;一般，一个供程序员调用的中断例程中往往包括多个子程序，中断例程内部用传递进来的
;参数来决定执行哪一个子程序。BIOS和DOS提供的中断例程，都用ah来传递内部子程序的编号。

;下面看一下int 10h中断例程的设置光标位置功能。
mov ah,2			;置光标
mov bh,0			;第0页
mov dh,5			;dh中放行号
mov dl,12			;dl中放列号
int 10h


;(ah)=2表示调用第10h号中断例程的2号子程序，功能为设置光标位置，可以提供光标所在的行号
;(80*25字符模式下：0~24)、列号(80*25字符模式下：0~79),和页号作为参数。
;(bh)=0,(dh)=5,(dl)=12,设置光标到第0页，第5行，第12列。

;bh中页号的含义：内存地址空间中，B8000H~BFFFFH共32kB的空间，为80*25彩色字符模式的显示
;缓冲区。一屏的内容在显示缓冲区中共占4000个字节。
;显示缓冲区分为8页，每页4KB(4000B),显示器可以显示任意一页的内容。一般情况下，显示第0页
;的内容。也就是说，通常情况下，B8000H~B8F9FH中的4000个字节的内容将出现在显示器上。

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;再看一下int 10h中断例程的在光标位置显示字符功能。：
mov ah,9		;在光标位置显示字符
mov al,'a'		;字符
mov bl,7		;颜色属性
mov bh,0		;第0页
mov cx,3		;字符重复个数
int 10h

;(ah)=9表示调用第10h号中断例程的9号子程序，功能为在光标位置显示字符，可以提供要显示的字符
;颜色属性、页号、字符重复个数作为参数
;bl中的颜色属性格式如下：

;含义：		7		6	5	4		3		2	1	0
;			BL		R	G	B		I		R	G	B
;			闪烁	背		景		高亮	背		景
;可以看出和显存中的属性字节的格式相同