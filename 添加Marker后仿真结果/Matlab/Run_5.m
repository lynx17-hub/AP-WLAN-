%一般情况（考虑方案引入开销）
clear;clc;clf;
nodeNumPath = 1:1:30;
global nodeNum;
OFDM_rate   = 600;
Payload     = 384000;
%Payload     = 384000000;
Pd          = 1;
Per         = 0;
global CWmin;
CWmin=31;
global m;
m=5;
global N0;
N0=3;

for i=1:1:length(nodeNumPath)
    nodeNum = nodeNumPath(i);
    
   
    
    ana_CA(i) = apc_restrict(OFDM_rate,Payload,Pd,Per);
    ana_CA2(i) = apc_restrict(OFDM_rate,Payload/4,Pd,Per);
    %nodeNum = nodeNumPath(i);
    ana_CA3(i) = apc_restrict(OFDM_rate,Payload/16,Pd,Per);
    %nodeNum = nodeNumPath(i);
    anaadv_CA(i)= bianchiadv_withoverhead(OFDM_rate,Payload,Pd,Per) ;
    %nodeNum = nodeNumPath(i);
    anaadv_CA2(i)= bianchiadv_withoverhead(OFDM_rate,Payload/4,Pd,Per) ;
    %nodeNum = nodeNumPath(i);
    anaadv_CA3(i)= bianchiadv_withoverhead(OFDM_rate,Payload/16,Pd,Per) ;
    gain_CA(i)=anaadv_CA(i)/ana_CA(i);
    gain_CA2(i)=anaadv_CA2(i)/ana_CA2(i);
    gain_CA3(i)=anaadv_CA3(i)/ana_CA3(i);
end

%sim_plot= sim_CA;

ana_plot = ana_CA;
sim_plot= anaadv_CA;
ana_plot2 = ana_CA2;ana_plot3 = ana_CA3;
sim_plot2= anaadv_CA2;sim_plot3= anaadv_CA3;

figure(1);

%plot(nodeNumPath,ana_plot,nodeNumPath,sim_plot,nodeNumPath,ana_plot2,nodeNumPath,sim_plot2,nodeNumPath,ana_plot3,nodeNumPath,sim_plot3);
plot(nodeNumPath,ana_plot,'--o',nodeNumPath,sim_plot,'--.',nodeNumPath,ana_plot2,'--*',nodeNumPath,sim_plot2,'--x',nodeNumPath,ana_plot3,'--s',nodeNumPath,sim_plot3,'--d');

legend('聚合度256 未采用方案','聚合度256 采用方案','聚合度64 未采用方案','聚合度64 采用方案','聚合度16 未采用方案','聚合度16 采用方案');
%xlim([4 30]);
xlabel('节点数量 n')
ylabel('吞吐量（Mbps）')
grid on;
box off;

gain_plot=gain_CA;
gain_plot2=gain_CA2;
gain_plot3=gain_CA3;
figure(2);
%plot(nodeNumPath,gain_plot);
plot(nodeNumPath,gain_plot,'--*',nodeNumPath,gain_plot2,'--s',nodeNumPath,gain_plot3,'--d');
legend('聚合度256增益','聚合度64增益','聚合度16增益');
%xlim([4 30]);
xlabel('节点数量 n')
ylabel('增益')
grid on;
box off;

hfig = figure(1);
figWidth = 5;  % 设置图片宽度
figHeight = 5;  % 设置图片高度
set(hfig,'PaperUnits','inches'); % 图片尺寸所用单位
set(hfig,'PaperPosition',[0 0 figWidth figHeight]);
fileout = ['5-吞吐量.']; % 输出图片的文件名
print(hfig,[fileout,'tif'],'-r600','-dtiff'); % 设置图片格式、分辨率


hfig = figure(2);
figWidth = 3.5;  % 设置图片宽度
figHeight = 3.5;  % 设置图片高度
set(hfig,'PaperUnits','inches'); % 图片尺寸所用单位
set(hfig,'PaperPosition',[0 0 figWidth figHeight]);
fileout = ['5-增益.']; % 输出图片的文件名
print(hfig,[fileout,'tif'],'-r600','-dtiff'); % 设置图片格式、分辨率


%{
figure(3);
for i=1:1:length(nodeNumPath)
    bar_plot(i,1)=ana_CA(i);
    bar_plot(i,2)=anaadv_CA(i);
    bar_plot(i,3)=ana_CA2(i);
    bar_plot(i,4)=anaadv_CA2(i);
    bar_plot(i,5)=ana_CA3(i);
    bar_plot(i,6)=anaadv_CA3(i);
end
bar(bar_plot);
%}

%r_error = mean(r_error)*100;

%fprintf('Relative error = %.2f%%\n',r_error);