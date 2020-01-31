function [f] = count_blocking_pairs(men_list,women_list,M)
    %count all of the block pairs
    n = size(M,2); 
    f = 0;
    for mi = 1:n
        wi = M(mi);
        for mj = 1:n
            wj = M(mj);
            if (mi ~= mj) && (check_blocking_pair(men_list,women_list,mi,wi,mj,wj))
                f = f + 1;
            end
        end
    end
end

