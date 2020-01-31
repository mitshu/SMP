function [f] = BlockingPair(menList,womenList, mi,wi,mj,wj)
    mr_wi = find(menList(mi,:) == wi);
    mr_wj = find(menList(mi,:) == wj);
    
    wr_mi = find(womenList(wj,:) == mi);
    wr_mj = find(womenList(wj,:) == mj);
    f = false;
    if ((mr_wj < mr_wi) && (wr_mi < wr_mj)) 
        f = true;
    end
end