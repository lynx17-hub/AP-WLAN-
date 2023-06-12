function output = p_tau_AP(input)
% p and tau Calculate Using Bianchi Model
% Input  : [input]
% Output : [output]
% copyright by Edward.xu(MUST)
% 280599580@qq.com
%
%------------------------- Log -------------------------- 
% 20141129 - create by Edward.xu
%--------------------------------------------------------

    global CWmin;
    global m;
    global nodeNum;
    global N0;
    global pe;
loc_nodeNum=ceil(nodeNum/N0)
    q   = input(1);
    tau = input(2);
    pw  = input(3);
    %{
    sum = 0;
    for k=0:1:m-1;
        sum = (2*p)^k + sum;
    end
    %}
    %output1_temp   = (1-pe)*((1-tau)^nodeNum);
    output1_temp   = (1-pe)*((1-tau)^loc_nodeNum)*(1-(tau*((1-tau)^(nodeNum-1))));
    output(1)      = 1-output1_temp-q;
    output2_temp   = 2*(1-pw)*(1-2*q)/(CWmin*((1-q)*(1-(2*q)^(m+1)))+(CWmin*(2^m)-1)*(1-2*q)*(q^(m+1))-(1-2*pw)*(1-2*q));
    %output2_temp   = 2*(1-pw)*(1-2*q)*(1-q^(m+1))/(CWmin*((1-q)*(1-(2*q)^(m+1)))+(1-2*pw)*(1-2*q)*(1-q^(m+1)));
    %orgin output2_temp   = 2*(1-2*q)/((CWmin+1)*(1-2*q)+q*CWmin*(1-(2*q)^m));
    output(2)      = output2_temp-tau;
    %output3_temp   =(1-(tau*(N0-1)*(1-tau)^(nodeNum-1))/nodeNum)* ((1-tau)^(nodeNum+1));
    output3_temp   =(1-(tau*(1-tau)^(nodeNum-1)))*(1-tau)^(1+loc_nodeNum);
    output(3)      = 1-output3_temp-pw;
    
end