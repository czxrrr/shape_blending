#Shape_blending
>本程序参考论文 2-D Shape Blending: An Intrinsic Solution to the Vertex Path Problem
来实现二维的多边形的blending,这里为了简单化,便以5边形为例。同时为了说明文章中给出的算法 的优越性,我还同时实现了另外两种算法,以便进行对比。

#三种插值方法分别是
0. 利用对应点在直角坐标系中的坐标简单线性插值。
1. 多边形的边长和外角线性插值
2. 多边形的边长和外角线性插值,并且修正保证图形的封闭性。
3. 
#效果展示:
请参见文件夹video下
0.mov 动作显得生硬
1.mov 出现中间过程 图形不是完全闭合的现象 2.mov 比较完善,图形闭合
#开发过程:
1. 角度计算:选用余弦定理计算。但是这里要考虑到计算alpha和theta的起始点不一样,以及正角 和负角的判断问题。
2. 选择小于180度的角:避免旋转超过180,最终角减去起始角的差(记为A)若大于180度,那么 就把这个差修正为(360-A)。
#代码说明:
输入文件 in.txt 中有四行输入,分别是开始图形的x坐标,开始的y坐标,结束图形的x坐标,结束的 y坐标。
本程序使用Processing开发(源代码pde文件,类JAVA语法,用文本文件方式打开即可)。代码中可 以通过修改变量的值在0,1,2这三种方法中切换。
>void draw() {
if(move==1){ 
  background(255);
  fill(0); 
  interpolation(timeline,2); 
  timeline=timeline+10; 
  if(timeline>=1000){
    move=0; 
    }
}
saveFrame("frames/####.png"); }

最重输出的程序是用论文中的方法,即方法2。
