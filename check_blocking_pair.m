function [f] = check_blocking_pair(men_list,women_list, mi,wi,mj,wj)
    mr_wi = find(men_list(mi,:) == wi);
    mr_wj = find(men_list(mi,:) == wj);
    
    wr_mi = find(women_list(wj,:) == mi);
    wr_mj = find(women_list(wj,:) == mj);
    f = false;
    if ((mr_wj < mr_wi) && (wr_mi < wr_mj)) 
        f = true;
    end
end