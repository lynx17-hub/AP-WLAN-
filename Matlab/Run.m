%Read the result from txt
clear;clc;clf;
NowDir    = pwd;
cd ../Result/CA;
ResultDir = pwd;
ReadPath  = dir(fullfile(ResultDir,'*.txt'));
NumTxt    = length(ReadPath);
for iterRead = 1:NumTxt
   CA_data(iterRead,:) = importdata(strcat(pwd,'\',ReadPath(iterRead).name));
end
cd(NowDir);
clear -regexp [^CA_data];

%sim result
sim_CA = CA_data;

nodeNumPath = 1:1:30;
global nodeNum;
OFDM_rate   = 600;
Payload     = 192000;
Pd          = 1;
Per         = 0;


for i=1:1:length(nodeNumPath)
    nodeNum = nodeNumPath(i);
    
   
    
    ana_CA(i) = bianchi(OFDM_rate,Payload,Pd,Per);
    anaadv_CA(i)= bianchiadv(OFDM_rate,Payload,Pd,Per);
    gain_CA(i)=anaadv_CA(i)/ana_CA(i);
    fprintf('n = %.2f% \n',nodeNum);
    fun_temp = fsolve(@p_tau,[0 0.05 0],optimset('Display','off'));
    q           = fun_temp(1);
    tau            = fun_temp(2);
    pw            = fun_temp(3);
    fprintf('pTX = %.2f%%\n',tau*100);
    fprintf('false = %.2f%%\n',q*100);
    fprintf('wait = %.2f%%\n',pw*100);
    fun_temp = fsolve(@p_tau_adv,[0 0.05 0],optimset('Display','off'));
    a           = fun_temp(1);
    b            = fun_temp(2);
    c            = fun_temp(3);
    fprintf('pTX = %.2f%%\n',b*100);
    fprintf('false = %.2f%%\n',a*100);
    fprintf('wait = %.2f%%\n',c*100);
    
end

%sim_plot= sim_CA;

ana_plot = ana_CA;
sim_plot= anaadv_CA;
figure(1);
plot(nodeNumPath,ana_plot,nodeNumPath,sim_plot);

legend('ana','sim');
%axis([1 30 0 54]);

grid on;
gain_plot=gain_CA;
figure(2);
plot(nodeNumPath,gain_plot);
grid on;
%r_error = abs(ana_CA-sim_CA)./sim_CA;
%r_error = mean(r_error)*100;

%fprintf('Relative error = %.2f%%\n',r_error);