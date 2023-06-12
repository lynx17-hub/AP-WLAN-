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
    
   
    
    ana_CA(i) = bianchi(OFDM_rate,Payload,Pd,Per);
    ana_CA2(i) = bianchi(OFDM_rate,Payload/4,Pd,Per);
    %nodeNum = nodeNumPath(i);
    ana_CA3(i) = bianchi(OFDM_rate,Payload/16,Pd,Per);
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

plot(nodeNumPath,ana_plot,"",nodeNumPath,sim_plot,nodeNumPath,ana_plot2,nodeNumPath,sim_plot2,nodeNumPath,ana_plot3,nodeNumPath,sim_plot3);

legend('Aggregation256 not adopted solution','Aggregation256 adopted solution','Aggregation64 not adopted solution','Aggregation64 adopted solution','Aggregation16 not adopted solution','Aggregation16 adopted solution','Location','East');

xlabel('Node number n')
ylabel('Throughput（Mbps）')
grid on;
box off;

hfig = figure(1);
figWidth = 8;  % 设置图片宽度
figHeight = 5;  % 设置图片高度
set(hfig,'PaperUnits','inches'); % 图片尺寸所用单位
set(hfig,'PaperPosition',[0 0 figWidth figHeight]);
fileout = ['4-增益.']; % 输出图片的文件名
print(hfig,[fileout,'tif'],'-r600','-dtiff'); % 设置图片格式、分辨率




gain_plot=gain_CA;
gain_plot2=gain_CA2;
gain_plot3=gain_CA3;


figure(2);
%plot(nodeNumPath,gain_plot);
plot(nodeNumPath,gain_plot, '--*',nodeNumPath,gain_plot2, '--o',nodeNumPath,gain_plot3, '--x');
legend('Aggregate256 gain','Aggregate64 gain','Aggregate16 gain');
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