# Readme

 CQU小学期硬件设计







## 调试程序中出现的问题

1. sign_extend模块传入指令应为instrD，即D阶段的指令，错误的将其传为当前指令，导致logic类指令测试出现问题





## 按照类别测试指令结果&说明



#### DataMoveInstTest

<img src="image_for_report/datamoveInst_TestResult.png" alt="img1" style="zoom: 100%;" />

对比inst_rom.S

```R
   .org 0x0
   .set noat
   .global _start
_start:
   lui $1,0x0000          # $1 = 0x00000000 
   lui $2,0xffff          # $2 = 0xffff0000
   lui $3,0x0505          # $3 = 0x05050000
   lui $4,0x0000          # $4 = 0x00000000 

   mthi $0                ## hi = 0x00000000
   mthi $2                ## hi = 0xffff0000
   mthi $3                ## hi = 0x05050000
   mfhi $4                ## $4 = 0x05050000

   mtlo $3                ## lo = 0x05050000
   mtlo $2                ## lo = 0xffff0000
   mtlo $1                ## lo = 0x00000000
   mflo $4                ## $4 = 0x00000000    
```

在第一条蓝竖线处，rst信号变为0，开始执行。仿真波形中橙色的波形为alu的三条线，两个输入数据和一个运算结果数据。
参考下方放大的波形图，首先执行的是四条lui指令，对寄存器进行赋值，可以看到寄存器堆的1，2，3，4号寄存器分别存储了对应的值，接着执行三条mthi，将0，2，3号寄存器内的值赋给hi寄存器。观察橙色信号alu计算结果y的波形，能够与inst_rom中应得的值对应（00000000，ffff0000，05050000）。
接着执行mfhi，将hi中的值存入rd寄存器中，alu对于这条指令不进行处理，直接将y置为00000000，通过resultW传入寄存器。图中resultW在该周期可以与inst_rom对应，观察寄存器内的值也可与之对应，该类指令测试通过。



<img src="image_for_report/datamoveInst_TestResult_zoomon.png" alt="img1" style="zoom: 100%;" />

