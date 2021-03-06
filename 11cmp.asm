;		11.8	cmp指令：比较指令
;cmp的功能相当于减法指令，只是不保存结果

;cmp指令格式：cmp 操作对象1，操作对象2
;功能：计算操作对象1-操作对象2 但不保存结果，仅仅根据计算结果对标志寄存器进行设置
;比如，指令cmp ax,ax,做（ax）-（ax）的运算，结果为0，但并不在ax中保存，仅影响flag
;的相关各位。指令执行后：zf=1,pf=1,sf=0,cf=0,of=0

mov ax,8
mov bx,3
cmp ax,bx
;上面指令执行后：（ax）=8,zf=0,pf=1,sf=0,cf=0,of=0.

;注意：CF是对无符号数运算有意义的标志位，而OF是对有符号数运算的标志位


;同add、sub指令一样，CPU在执行cmp指令时，也包含两种含义：进行无符号运算和进行有符号运算。
;所以cmp指令可以对无符号数进行比较，也可以对有符号数进行比较。

;因为在运算中结果可能产生溢出导致数变为负数，SF标志位尽管为1，但还不能判断两个数的大小
;所以我们应该在考查sf（得知实际结果的正负）的同时考查of（得知有没有溢出），就可以得知
;逻辑上真正结果的正负，同时知道比较的结果

;下面，我们以cmp ah,bh为例，总结一下CPU执行cmp指令后，sf和of的值是如何来说明比较的结果的

;(1)如果sf=1，而of=0
;of=0，说明没有溢出，逻辑上真正的结果的正负=实际结果的正负
;因sf=1，实际结果为负，所以逻辑上真正的结果为负，所以（ah）< （bh）

;(2)如果sf=1，而of=1
;of=1，说明有溢出，逻辑上真正的结果的正负 不等于 实际结果的正负
;因sf=1，实际结果为负
;实际结果为负，而又有溢出，这说明是由于溢出导致了结果的正负，简单分析一下，就可以看出
;如果因为溢出导致了实际结果为负，那么逻辑上真正的结果必然为正
;这样，sf=1，of=1，说明了（ah）>（bh）

;(3)如果sf=0，而of=1
;of=1，说明有溢出，逻辑上真正结果的正负 不等于 实际结果的正负
;因sf=0，实际结果为非负。而of=1说明有溢出，则结果非0，所以，实际结果为正
;实际结果为正，而又有溢出，这说明是由于溢出导致了实际结果为负，简单分析一下
;就可以看出，如果因为溢出导致了实际结果为正，那么逻辑上的真正结果必然为负。
;这样，sf=0，of=1，说明了（ah）<（bh）

;(4)如果sf=0，而of=0
;of=0，说明没有溢出，逻辑上真正结果的正负=实际结果的正负
;因sf=0，实际结果为非负，所以逻辑上真正的结果为非负，所以（ah）》（bh）


