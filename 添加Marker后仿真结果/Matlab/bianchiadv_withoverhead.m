
function ana = bianchiadv_withoverhead(rate,L_p,Pd,Per)

    %mac prob
    global CWmin;
    global m;
    global nodeNum;
    global N0;
    global pe;

    CWmin      = 31;
    m          = 5;
    %N0=3;
    pe=0.005;
    loc_nodeNum=ceil(nodeNum/N0);%only ap in contention
    %header_rate= 1;
    data_rate  = rate;

    L_ph       = 208;
    L_mh       = 224;
    % L_Header   = (L_ph + L_mh);
    L_Payload  =  L_p * 8;
    L_Ack      =  14 * 8;
    L_MURTS=28*8+40;

    t_SIFS     = 16; 
    t_SLOT     = 9;
    t_DIFS     = t_SIFS + t_SLOT * 2;
    t_PROP     = 0;
    
 
    t_ph=40;
    t_Header   = t_ph+L_mh/data_rate;
    t_Payload  = L_Payload / data_rate;
    t_Ack      = t_ph+L_Ack/ data_rate;
    t_p        = t_Header + t_Payload;
    t_MURTS= t_ph+ L_MURTS/24;
   
    t_s       = t_DIFS + t_p + 3*t_SIFS +2* t_Ack + 2*t_PROP+t_MURTS;
    %    t_s       =  t_p + t_SIFS + t_Ack + 2*t_PROP;
    t_c       = t_DIFS +t_MURTS+t_SIFS+t_Ack;
    
    fun_temp = fsolve(@p_tau_adv,[0 0.05 0],optimset('Display','off'));
    q           = fun_temp(1);
    tau            = fun_temp(2);
    pw            = fun_temp(3);
    %{
    Ptr_temp    = (1 - tau)^nodeNum;
    Ptr         = 1 - Ptr_temp;
    Ps_temp     = (1 - tau)^(nodeNum-1);
    Ps          = nodeNum * tau * Ps_temp;
    %}
    Ptr_temp    = (1 - tau)^loc_nodeNum;
    Ptr         = 1 - Ptr_temp;
    Ps_temp     = (1 - tau)^(loc_nodeNum-1);
    Ps          = loc_nodeNum * tau * Ps_temp;
     
    P1  = 1 - Ptr;
    T1  = t_SLOT;
    
    P2  = Ps;
    T2  = t_s;
    
    P3  = Ptr - Ps;
    T3  = t_c ;
    
    t_all  = (P1 * T1 + P2 * T2 + P3 * T3);
    
    lambda_rate = (Pd*1+(1-Pd)*Per) * Ps / (t_all);
    
    %anaadv         = L_Payload * lambda_rate; 
     ana=L_Payload*lambda_rate;
end
