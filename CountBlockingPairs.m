function [f] = CountBlockingPairs(menList,womenList,M)
    %count all of the block pairs
    n = size(M,2); 
    f = 0;
    for i = 1:n
        mi = i;
        wi = M(i);
        for j = 1:n
            mj = j;
            wj = M(j);
            if (i ~= j) && (BlockingPair(menList,womenList,mi,wi,mj,wj))
                f = f + 1;
            end
        end
    end
end

