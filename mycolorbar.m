function cax = mycolorbar(tick,color,mode,vnumber,bar_pos)
% cax = MYCOLORBAR(tick,color,mode,vnumber,bar_pos)
% 本函数提供了带尖端的colorbar
% -----------------------输入变量说明----------------------- 
% mode 的可选项为'h'；'v'
% 分别为水平和垂直
% vnumber 的可选项为'none'或'=='；'lower'或'<='； 'upper'或'=>'；'all'或'<>' "
% 分别为无箭头 只有下限箭头 只有上限箭头 两个箭头均有
% bar_pos为colorbar在figure中的位置，如不设置，则采用默认值
% 
% -----------------------输出变量说明----------------------- 
% cax 为colorbar的绘图句柄
%
% -----------------------函数调用示例----------------------- 
%
% cax = MYCOLORBAR(-25:5:25,cm1,'h','all',[0.15, 0.045, 0.7, 0.02]);
%
% cax = MYCOLORBAR(-25:5:25,cm1,'v','<>');
% 
%  This fuction is by Yifan Liu, Academy of the Future Ocean, Ocean University of China.

m = size(color,1);
len_tick = length(tick);
if len_tick-m ~= 1
    error('tick的个数要比color的个数多1个')
end

if ~(isequal(vnumber,'none') || isequal(vnumber,'lower') || ...
        isequal(vnumber,'upper') || isequal(vnumber,'all') || isequal(vnumber,'==') || isequal(vnumber,'<=')...
        || isequal(vnumber,'=>') || isequal(vnumber,'<>'))
    error("vnumber的可选项为'none'或'=='；'lower'或'<='； 'upper'或'=>'；'all'或'<>' ")
end

if ~(isequal(mode,'h') || isequal(mode,'v'))
    error("mycolorbar格式出错，mode的可选项为'h'；'v'")
end

if nargin == 4
    if isequal(mode,'h')
        bar_pos = [0.1 0.1 0.8 0.03];
    else
        bar_pos = [0.9 0.1 0.03 0.8];
    end
end

set(gcf,'color','w');
cax=axes('position',bar_pos);
cdata = zeros(1,m);
for i=1:m
    cdata(i) = (i+i+1)/2;
end

if isequal(mode,'v')
    set(cax,'yaxislocation','right');
end

colormap(color);clim([1 len_tick])
if isequal(mode,'h')% 水平
    axis([0 m 0 1]);hold on
    line([0 1],[0 0],'linewidth',2,'color','w','parent',cax)
    line([m-1 m],[0 0],'linewidth',2,'color','w','parent',cax)
else
    axis([0 1 0 m]);hold on
    line([1 1],[0 1],'linewidth',2,'color','w','parent',cax)
    line([1 1],[m-1 m],'linewidth',2,'color','w','parent',cax)
end
box off
%------------------------
pat_v1 = zeros(4*(m-2),2);pat_v1(1:4,:)=[1 0;1 1;2 1;2 0];pat_f1=reshape(1:(m-2)*4,4,m-2)';
for j=2:m-2
    pat_v1(4*j-3:4*j,:) = [j 0;j 1;j+1 1;j+1 0];
end
pat_col1=[cdata(2:end-1)]';
if isequal(mode,'v')
    pat_v1 = flip(pat_v1,2);
end
patch('Faces',pat_f1,'Vertices',pat_v1,'FaceVertexCData',pat_col1,'FaceColor','flat','Edgecolor','none');
%--------------------------------------------------
if isequal(vnumber,'all') || isequal(vnumber,'<>')
    pat_v2=[0.5 0.5;1 0;1 1;m-1 1;m-1 0;m-0.5 0.5];
    pat_f2=[1 2 3;4 5 6];
    pat_col2=[cdata(1);cdata(end)];
    if isequal(mode,'v')
        pat_v2 = flip(pat_v2,2);
    end
    patch('Faces',pat_f2,'Vertices',pat_v2,'FaceVertexCData',pat_col2,'FaceColor','flat','Edgecolor','none');
    %----------------------FFF-----------------------------------
    if isequal(mode,'h')
        set(cax,'color','none','xcolor','k','ycolor','none');
        set(cax,'xtick',1:m-1,'xticklabel',num2cell(tick(2:end-1)),'ytick',[])
        plot([0.5 1 m-1 m-0.5 m-1 1 0.5],[0.5 0 0 0.5 1 1 0.5],'linewidth',1,'Color','k')
    else
        set(cax,'color','none','ycolor','k','xcolor','none');
        set(cax,'ytick',1:m-1,'yticklabel',num2cell(tick(2:end-1)),'xtick',[])
        plot([0.5 0 0 0.5 1 1 0.5],[0.5 1 m-1 m-0.5 m-1 1 0.5],'linewidth',1,'Color','k')
    end
elseif isequal(vnumber,'none') || isequal(vnumber,'==')
    pat_v2=[0 0;1 0;1 1;0 1;m-1 1;m-1 0;m 0;m 1];
    pat_f2=[1 2 3 4;5 6 7 8];
    pat_col2=[cdata(1);cdata(end)];
    if isequal(mode,'v')
        pat_v2 = flip(pat_v2,2);
    end
    patch('Faces',pat_f2,'Vertices',pat_v2,'FaceVertexCData',pat_col2,'FaceColor','flat','Edgecolor','none');
    %---------------------------------------------------------
    if isequal(mode,'h')
        set(cax,'color','none','xcolor','k','ycolor','none');
        set(cax,'xtick',0:m,'xticklabel',num2cell(tick),'ytick',[])
        plot([0 m m 0 0],[0 0 1 1 0],'linewidth',1,'Color','k')
    else
        set(cax,'color','none','ycolor','k','xcolor','none');
        set(cax,'ytick',0:m,'yticklabel',num2cell(tick),'xtick',[])
        plot([0 0 1 1 0],[0 m m 0 0],'linewidth',1,'Color','k')
    end
elseif isequal(vnumber,'lower') || isequal(vnumber,'<=')
    pat_v2=[0.5 0.5;1 0;1 1];
    pat_f2=[1 2 3];
    pat_col2 = cdata(1);
    if isequal(mode,'v')
        pat_v2 = flip(pat_v2,2);
    end
    patch('Faces',pat_f2,'Vertices',pat_v2,'FaceVertexCData',pat_col2,'FaceColor','flat','Edgecolor','none');
    %---------------------------------------------------------
    pat_v3 = [m-1 1;m-1 0;m 0;m 1];
    pat_f3 = [1 2 3 4];
    pat_col3 = cdata(end);
    if isequal(mode,'v')
        pat_v3 = flip(pat_v3,2);
    end
    patch('Faces',pat_f3,'Vertices',pat_v3,'FaceVertexCData',pat_col3,'FaceColor','flat','Edgecolor','none');
    if isequal(mode,'h')
        set(cax,'color','none','xcolor','k','ycolor','none');
        set(cax,'xtick',1:m,'xticklabel',num2cell(tick(2:end)),'ytick',[])
        plot([0.5 1 m m 1 0.5],[0.5 0 0  1 1 0.5],'linewidth',1,'Color','k')
    else
        set(cax,'color','none','ycolor','k','xcolor','none');
        set(cax,'ytick',1:m,'yticklabel',num2cell(tick(2:end)),'xtick',[])
        plot([0.5 0 0  1 1 0.5],[0.5 1 m m 1 0.5],'linewidth',1,'Color','k')
    end
elseif isequal(vnumber,'upper') || isequal(vnumber,'=>')
    pat_v2=[m-1 1;m-1 0;m-0.5 0.5];
    pat_f2=[1 2 3];
    pat_col2 = cdata(end);
    if isequal(mode,'v')
        pat_v2 = flip(pat_v2,2);
    end
    patch('Faces',pat_f2,'Vertices',pat_v2,'FaceVertexCData',pat_col2,'FaceColor','flat','Edgecolor','none');
    %---------------------------------------------------------
    pat_v3 = [0 0;1 0;1 1;0 1];
    pat_f3 = [1 2 3 4];
    pat_col3 = cdata(1);
    if isequal(mode,'v')
        pat_v3 = flip(pat_v3,2);
    end
    patch('Faces',pat_f3,'Vertices',pat_v3,'FaceVertexCData',pat_col3,'FaceColor','flat','Edgecolor','none');
    if isequal(mode,'h')
        set(cax,'color','none','xcolor','k','ycolor','none');
        set(cax,'xtick',0:m-1,'xticklabel',num2cell(tick(1:end-1)),'ytick',[])
        plot([0 m-1 m-0.5 m-1 0 0],[0 0 0.5 1 1 0],'linewidth',1,'Color','k')
    else
        set(cax,'color','none','ycolor','k','xcolor','none');
        set(cax,'ytick',0:m-1,'yticklabel',num2cell(tick(1:end-1)),'xtick',[])
        plot([0 0 0.5 1 1 0],[0 m-1 m-0.5 m-1 0 0],'linewidth',1,'Color','k')
    end
end
set(cax,'TickDir','none')
end
