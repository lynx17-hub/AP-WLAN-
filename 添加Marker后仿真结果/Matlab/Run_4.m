%�̶���Ŀ�Ľڵ㾺�����ı�AP�����豸������
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
nodeNum=100;
nodeNumPath=1:1:ceil(nodeNum/3);
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
%plot(nodeNumPath,ana_plot,nodeNumPath,sim_plot,nodeNumPath,ana_plot2,nodeNumPath,sim_plot2,nodeNumPath,ana_plot3,nodeNumPath,sim_plot3);
plot(nodeNumPath,ana_plot,'--o',nodeNumPath,sim_plot,'--.',nodeNumPath,ana_plot2,'--*',nodeNumPath,sim_plot2,'--x',nodeNumPath,ana_plot3,'--s',nodeNumPath,sim_plot3,'--d');
%xlim([0 15]);
%legend('ana','sim');
legend('�ۺ϶�256 δ���÷���','�ۺ϶�256 ���÷���','�ۺ϶�64 δ���÷���','�ۺ϶�64 ���÷���','�ۺ϶�16 δ���÷���','�ۺ϶�16 ���÷���');

xlabel('AP������STA���� N0')
ylabel('��������Mbps��')
%axis([1 30 0 54]);
box off;
grid on;
%set(gca,'XScale','log');

hfig = figure(1);
figWidth = 5;  % ����ͼƬ���
figHeight = 5;  % ����ͼƬ�߶�
set(hfig,'PaperUnits','inches'); % ͼƬ�ߴ����õ�λ
set(hfig,'PaperPosition',[0 0 figWidth figHeight]);
fileout = ['3-������.']; % ���ͼƬ���ļ���
print(hfig,[fileout,'tif'],'-r600','-dtiff'); % ����ͼƬ��ʽ���ֱ���

gain_plot=gain_CA;
gain_plot2=gain_CA2;
gain_plot3=gain_CA3;
figure(2);
%plot(nodeNumPath,gain_plot);
plot(nodeNumPath,gain_plot,'--*',nodeNumPath,gain_plot2,'--s',nodeNumPath,gain_plot3,'--d');
legend('�ۺ϶�256����','�ۺ϶�64����','�ۺ϶�16����');
xlabel('AP������STA���� N0')
ylabel('����')
box off;
grid on;
xlim([0 15]);
set(gca,'XScale','log');

hfig = figure(2);
figWidth = 3.5;  % ����ͼƬ���
figHeight = 3.5;  % ����ͼƬ�߶�
set(hfig,'PaperUnits','inches'); % ͼƬ�ߴ����õ�λ
set(hfig,'PaperPosition',[0 0 figWidth figHeight]);
fileout = ['3-����.']; % ���ͼƬ���ļ���
print(hfig,[fileout,'tif'],'-r600','-dtiff'); % ����ͼƬ��ʽ���ֱ���

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
legend('�ۺ϶�256 δ���÷���','�ۺ϶�256 ���÷���','�ۺ϶�64 δ���÷���','�ۺ϶�64 ���÷���','�ۺ϶�16 δ���÷���','�ۺ϶�16 ���÷���');
xlim([0 15]);

xlabel('AP������STA���� N0')
ylabel('��������Mbps��')
box off;
hfig = figure(3);
figWidth = 8;  % ����ͼƬ���
figHeight = 8;  % ����ͼƬ�߶�
set(hfig,'PaperUnits','inches'); % ͼƬ�ߴ����õ�λ
set(hfig,'PaperPosition',[0 0 figWidth figHeight]);
fileout = ['3-������bar.']; % ���ͼƬ���ļ���
print(hfig,[fileout,'tif'],'-r600','-dtiff'); % ����ͼƬ��ʽ���ֱ���

figure(4);
%plot(nodeNumPath,gain_plot);
plot(nodeNumPath,gain_plot,'--*',nodeNumPath,gain_plot2,'--s',nodeNumPath,gain_plot3,'--d');
legend('�ۺ϶�256����','�ۺ϶�64����','�ۺ϶�16����');
xlabel('AP������STA���� N0')
ylabel('����')
box off;
grid on;
xlim([0 15]);

hfig = figure(4);
figWidth = 3.5;  % ����ͼƬ���
figHeight = 3.5;  % ����ͼƬ�߶�
set(hfig,'PaperUnits','inches'); % ͼƬ�ߴ����õ�λ
set(hfig,'PaperPosition',[0 0 figWidth figHeight]);
fileout = ['3-����2.']; % ���ͼƬ���ļ���
print(hfig,[fileout,'tif'],'-r600','-dtiff'); % ����ͼƬ��ʽ���ֱ���
