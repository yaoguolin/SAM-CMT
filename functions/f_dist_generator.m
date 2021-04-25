function [soyN_kgha_dist,soyP_kgha_dist,soyW_Lha_dist] = f_dist_generator(N_data,P_data,W_data,num_sim, perc)
% a function that generate distributions of three environmental impacts of
% a certain crop type
%   Detailed explanation goes here

seed = 523;
rng(seed)

soyN_kgha = N_data;
soyN_kgha_dist = nan(6,num_sim);

soyP_kgha = P_data;
soyP_kgha_dist = nan(6,num_sim);

soyW_Lha = W_data;
soyW_Lha_dist = nan(6,num_sim);
for cn = 1:1:6
    if soyN_kgha(cn)> 0
        pdN = makedist('Triangular','a',soyN_kgha(cn) * (1 - perc),'b', soyN_kgha(cn),'c',soyN_kgha(cn) * (1 + perc));
        soyN_kgha_dist(cn,:) = random(pdN,1,num_sim); 
    else
        soyN_kgha_dist(cn,:) = 0;
    end
        
    if soyP_kgha(cn)> 0
        pdP = makedist('Triangular','a',soyP_kgha(cn) * (1 - perc),'b', soyP_kgha(cn),'c',soyP_kgha(cn) * (1 + perc));
        soyP_kgha_dist(cn,:) = random(pdP,1,num_sim); 
    else
        soyP_kgha_dist(cn,:) = 0;
    end
    
    if soyW_Lha(cn)> 0
        pdW = makedist('Triangular','a',soyW_Lha(cn) * (1 - perc),'b', soyW_Lha(cn),'c',soyW_Lha(cn) * (1 + perc));
        soyW_Lha_dist(cn,:) = random(pdW,1,num_sim); 
    else 
        soyW_Lha_dist(cn,:) = 0;
    end
end


end

