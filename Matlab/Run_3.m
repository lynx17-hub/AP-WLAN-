%极限情况
clear;clc;clf;


nodeNumPath = 1:1:30;
global nodeNum;
OFDM_rate   = 600;
%Payload     = 384000;
Payload     = 3840000000;
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
    anaadv_CA(i)= bianchiadv_withoverhead(OFDM_rate,Payload,Pd,Per) ;   
    gain_CA(i)=anaadv_CA(i)/ana_CA(i);

end

%sim_plot= sim_CA;

ana_plot = ana_CA;
sim_plot= anaadv_CA;

%ana_plot = anaadv_CA;
%sim_plot= anaadv1_CA;
figure(1);
%plot(nodeNumPath,ana_plot,nodeNumPath,sim_plot);
plot(nodeNumPath,ana_plot,nodeNumPath,sim_plot);

%legend('ana','sim');
legend('未采用方案','采用方案');
xlabel('节点数量 n')
ylabel('吞吐量（Mbps）')
%axis([1 30 0 54]);

grid on;
gain_plot=gain_CA;

figure(2);
%plot(nodeNumPath,gain_plot);
plot(nodeNumPath,gain_plot);
xlabel('节点数量 n')
ylabel('增益')
legend('增益');
grid on;
%r_error = abs(ana_CA-sim_CA)./sim_CA;
%r_error = mean(r_error)*100;

%fprintf('Relative error = %.2f%%\n',r_error);