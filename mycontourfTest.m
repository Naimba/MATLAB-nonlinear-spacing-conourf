clear;clc;close all

fn = 'E:\学习\毕业论文\非定常波的气候学研究\ClimatologicalData\uwnd.mon.mean.nc';
lon = ncread(fn,'lon');lat = ncread(fn,'lat');
u = ncread(fn,'uwnd',[1 1 8 543],[inf inf 1 1]);
lon = double(lon);lat = double(lat);u = double(u);
[u,lon] = add_cyclic_point(u,lon);
[X,Y] = meshgrid(lon,lat);

load('E:\学习\毕业论文\非定常波的气候学研究\othercolor\colorData.mat','RdBu11');
cm = flip(RdBu11);clear RdBu11
cm = cat(1,cm(1:5,:),cm(7:end,:));

fig = figure;
set(gcf,'Position',[500 500 1000 500])
levels = [-10 -8 -6 -4 -2 0 2 5 10 20 30];
cax = mycolorbar(levels,cm,'h','<>',[0.15, 0.045, 0.7, 0.03]);
axes
m_proj('Equidistant Cylindrical','lon',[0 360],'lat',[-90 90]);hold on
[~,~,u1] = mycontourf(X,Y,u',levels,cm,'m');
m_grid('box','on','xtick',0:60:360,'tickdir','in','ytick',-90:30:90,'linestyle','none');
m_coast('line','color',[0.6 0.6 0.6],'linewidth',1,'linestyle','-');

% figure
% m_proj('Equidistant Cylindrical','lon',[0 360],'lat',[-90 90]);hold on
m_contour(X,Y,u',levels(levels>0),'-','Linewidth',1,'color','k')
m_contour(X,Y,u',levels(levels<0),'--','Linewidth',1,'color','k')
m_contour(X,Y,u',[0 0],'-','Linewidth',1.5,'color','k')

% m_grid('box','on','xtick',0:60:360,'tickdir','in','ytick',-90:30:90,'linestyle','none');
% m_coast('line','color',[0.6 0.6 0.6],'linewidth',1,'linestyle','-');
% set(gcf,'Position',[1500 500 1000 500])
