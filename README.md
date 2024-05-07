mycontourf为不等间距绘制填色图的函数（采用三次样条插值），原理为归一化为等间距的levels；

mycolorbar为带箭头且不等间距；

注意：mycolorbar和mycontourf使用后，禁止在主程序中使用clim和caxis函数！！！
