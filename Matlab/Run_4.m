%固定数目的节点竞争，改变AP关联设备的数量
clear;clc;clf;
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
nodeNum=30;
nodeNumPath=1:1:nodeNum/2;
for i=1:1:length(nodeNumPath)
    N0=nodeNumPath(i);
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
%ana_plot = anaadv_CA;
%sim_plot= anaadv1_CA;
figure(1);
%plot(nodeNumPath,ana_plot,nodeNumPath,sim_plot);
plot(nodeNumPath,ana_plot,nodeNumPath,sim_plot,nodeNumPath,ana_plot2,nodeNumPath,sim_plot2,nodeNumPath,ana_plot3,nodeNumPath,sim_plot3);

%legend('ana','sim');
legend('聚合度256 未采用方案','聚合度256 采用方案','聚合度64 未采用方案','聚合度64 采用方案','聚合度16 未采用方案','聚合度16 采用方案');

xlabel('AP关联的STA数量 N0')
ylabel('吞吐量（Mbps）')
%axis([1 30 0 54]);

grid on;
gain_plot=gain_CA;
gain_plot2=gain_CA2;
gain_plot3=gain_CA3;
figure(2);
%plot(nodeNumPath,gain_plot);
plot(nodeNumPath,gain_plot,nodeNumPath,gain_plot2,nodeNumPath,gain_plot3);
legend('聚合度256增益','聚合度64增益','聚合度16增益');
xlabel('AP关联的STA数量 N0')
ylabel('增益')
grid on;
%r_error = abs(ana_CA-sim_CA)./sim_CA;
%r_error = mean(r_error)*100;

%fprintf('Relative error = %.2f%%\n',r_error);