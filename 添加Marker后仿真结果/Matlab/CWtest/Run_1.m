%生成不同CW下的吞吐量、增益
clear;clc;clf;




nodeNumPath = 1:1:30;
CWRank=1:1:4;

global CWmin;
global m;
global nodeNum;
CWmin=7;
m=8;
global N0;
N0=5;
OFDM_rate   = 600;
Payload     = 384000;
%Payload     = 384000000;
Pd          = 1;
Per         = 0;
 
for j=1:1:length(CWRank)
    
    for i=1:1:length(nodeNumPath)
    nodeNum = nodeNumPath(i);
    
    ana_CA(j,i) = bianchi(OFDM_rate,Payload,Pd,Per);
    
    anaadv_CA(j,i)= bianchiadv_withoverhead(OFDM_rate,Payload,Pd,Per); 
    
    gain_CA(j,i)=anaadv_CA(j,i)/ana_CA(j,i);
    end 
    %{
    ana_CA_ma(j,:)= ana_CA;
    anaadv_CA_ma(j,:)= anaadv_CA;
    gain_CA_ma(j,:)= gain_CA;
    
    ana_plot = ana_CA;
    sim_plot= anaadv_CA;
    figure;
    plot(nodeNumPath,ana_plot,nodeNumPath,sim_plot);
    legend('ana1','sim1');
    grid on;hold on;
    gain_plot=gain_CA;
    figure;
    plot(nodeNumPath,gain_plot);
   hold on;
    %}
    CWmin=(CWmin+1)*2-1;
    m=m-1;
end
%sim_plot= sim_CA;
c=colormap(jet(j));
[linestyles,MarkerEdgeColors,Markers]=generate_line_styles(2*length(CWRank));
figure(1);
for k=1:1:length(CWRank)
    
    ana_plot = ana_CA(k,:);
    sim_plot= anaadv_CA(k,:);
    
    %plot(nodeNumPath,ana_plot,nodeNumPath,sim_plot,'color',c(k,:));
   %hold on;
   %plot(nodeNumPath,ana_plot,nodeNumPath,sim_plot);
   plot(nodeNumPath,ana_plot,'Color',MarkerEdgeColors(k,:));
   hold all;
   plot(nodeNumPath,sim_plot,'Color',MarkerEdgeColors(k+length(CWRank),:));
   hold all;
  
end
legend('CWmin=7 not adopted solution','CWmin=7 adopted solution','CWmin=15 not adopted solution','CWmin=15 adopted solution','CWmin=31 not adopted solution','CWmin=31 adopted solution','CWmin=63 not adopted solution','CWmin=63 adopted solution','Location','East');
 xlabel('Node number n');
ylabel('Thoughput（Mbps）');
box off;
grid on;

hfig = figure(1);
figWidth = 8;  % 设置图片宽度
figHeight = 5;  % 设置图片高度
set(hfig,'PaperUnits','inches'); % 图片尺寸所用单位
set(hfig,'PaperPosition',[0 0 figWidth figHeight]);
fileout = ['4-吞吐量.']; % 输出图片的文件名
print(hfig,[fileout,'tif'],'-r600','-dtiff'); % 设置图片格式、分辨率


for k=1:1:length(CWRank)
    gain_plot=gain_CA(k,:);
figure(2);
plot(gain_plot,[linestyles{1} Markers{k}],'Color',MarkerEdgeColors(k,:));

hold all;

 
end
legend('CWmin=7','CWmin=15','CWmin=31','CWmin=63');
xlabel('Node number n')
ylabel('Benefit')
grid on;
box off;

hfig = figure(2);
figWidth = 8;  % 设置图片宽度
figHeight = 5;  % 设置图片高度
set(hfig,'PaperUnits','inches'); % 图片尺寸所用单位
set(hfig,'PaperPosition',[0 0 figWidth figHeight]);
fileout = ['4-增益.']; % 输出图片的文件名
print(hfig,[fileout,'tif'],'-r600','-dtiff'); % 设置图片格式、分辨率
%r_error = abs(ana_CA-sim_CA)./sim_CA;
%r_error = mean(r_error)*100;

%fprintf('Relative error = %.2f%%\n',r_error);