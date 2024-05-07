function [M,c,Z1] = mycontourf(X,Y,Z,levels,cm,mode)
% [M,c] = MYCONTOURF(X,Y,Z,levels,cm)
% 本函数将配合mycolorbar函数实现不等间距等值线填色
% 注意：对于不等间距的格点插值是线性插值
% -----------------------输入变量说明----------------------- 
% X、Y：指定Z中各值的x和y坐标，同contourf；
% Z：Z的列和行索引分别是平面中的x和y坐标，同contourf；
% levels：单调递增值的向量，以在某些特定高度绘制等高线并填色；
% cm：填色的colormap
% mode：可选项，'m'为用m_map的m_contourf，'M'为MATLAB自带的contourf，默认为'm'
% -----------------------输出变量说明----------------------- 
% M：等高线矩阵；
% c：等高线对象，显示等高线图后，使用c设置属性。
%
% -----------------------函数调用示例----------------------- 
% [M,c,Z1] = mycontourf(X,Y,u',-25:5:25,cm,'m');
% 
% [M,c,Z1] = mycontourf(X,Y,u',[-10 -8 -6 -4 -2 0 2 10 15 20 40],cm,'m');
% 
%  This fuction is made by Yifan Liu, Academy of the Future Ocean, Ocean University of China.

if nargin == 5
    mode = 'm';
end

if ~(isequal(mode,'m') || isequal(mode,'M'))
    error("my_contourf输入格式出错，mode的可选项为'm'；'M'")
end

% 根据levels设置等间距的值（线性插值）
n = length(levels);
Z1 = zeros(size(Z));

% 线性插值
Z1(Z>levels(1) & Z<=levels(n)) = interp1(levels(1:n),1:n,...
    Z(Z>levels(1) & Z<=levels(n)),'linear');

% 样条插值
% Z1(Z>levels(1) & Z<=levels(n)) = interp1(levels(1:n),1:n,...
%     Z(Z>levels(1) & Z<=levels(n)),'spline');

% 设置边界值
Z1(Z<=levels(1)) = 1;
Z1(Z>levels(n)) = n-1;

if isequal(mode,'m')
    [M,c] = m_contourf(X,Y,Z1,1:n,'LineStyle','none');
else
    [M,c] = contourf(X,Y,Z1,1:n,'LineStyle','none');
end
colormap(cm)
clim([1 n])


end
