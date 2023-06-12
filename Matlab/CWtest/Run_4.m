%生成不同CW下的吞吐量、增益
clear;clc;clf;




nodeNumPath = 1:1:30;
CWRank=1:1:4;

global CWmin;
global m;
global nodeNum;
CWmin=7;
m=8;
OFDM_rate   = 600;
Payload     = 384000;
%Payload     = 384000000;
Pd          = 1;
Per         = 0;
 
for j=1:1:length(CWRank)
    CWmin=(CWmin+1)*2-1;
    m=m-1;
    for i=1:1:length(nodeNumPath)
    nodeNum = nodeNumPath(i);
    
    ana_CA(j,i) = bianchi(OFDM_rate,Payload,Pd,Per);
    anaadv_CA(j,i)= bianchiadv_withoverhead(OFDM_rate,Payload,Pd,Per) ;   
    gain_CA(j,i)=anaadv_CA(i)/ana_CA(i);
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
end
%sim_plot= sim_CA;
c=colormap(jet(j))
for k=1:1:length(CWRank)
    ana_plot = ana_CA(k,:);
    sim_plot= anaadv_CA(k,:);
    figure(1);
    %plot(nodeNumPath,ana_plot,nodeNumPath,sim_plot,'color',c(k,:));
   %hold on;
   plot(nodeNumPath,ana_plot,nodeNumPath,sim_plot);
   hold all;
  
end
legend('CWmin=7','CWmin=15','CWmin=31','CWmin=63','CWmin=127','Location','East');
 xlabel('节点数量 n')
ylabel('吞吐量（Mbps）')
grid on;
for k=1:1:length(CWRank)
    gain_plot=gain_CA(k,:);
figure(2);
plot(gain_plot);

hold all;

 
end
legend('CWmin=7','CWmin=15','CWmin=31','CWmin=63','CWmin=127');
xlabel('节点数量 n')
ylabel('增益')
grid on;

%r_error = abs(ana_CA-sim_CA)./sim_CA;
%r_error = mean(r_error)*100;

%fprintf('Relative error = %.2f%%\n',r_error);