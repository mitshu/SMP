clc
clear all;
close all;
%read an instance of SMP
filename = ['Inputs\I40-1.mat'];
load(filename,'menList','womenList');
%generate a random matching
n = size(menList,1);
% X = rand(1,n);
% [~,M] = sort(X);
M = [ 35 30 18 22 36 37 15 6 3 10 34 9 38 1 25 16 5 31 12 39  13 2 8 40 17    28    20     7     4    33 ...
      32    11    23    27    19    14    29    21    26    24];
 
%algorithm
MAX_ITERS = 10000;
iter = 1;
p = 0.05; %how to decide p?
tic;
while (iter <= MAX_ITERS)
    %find the blocking pair set of matching M
    BP = [];
    for i = 1:n
        mi = i;
        wi = M(i);
        for j = 1:n
            mj = j;
            wj = M(j);
            if (BlockingPair(menList,womenList,mi,wi,mj,wj))
                %find the dominance cost of blocking pair
                mr_wj = find(menList(mi,:) == wj);
                %add the dominace cost to the last BP
                BP(end+1,:) = [mi,wi,mj,wj,mr_wj];
            end
        end
    end
    
    %find the neighbor set of matching M
    neighbors = [];
    for i = 1:n
        %swap only for undominated blocking pair
        rows = find(BP(:,1) == i);
        if ~isempty(rows)
            UBP = BP(rows,:);
            %collum 5 dominance cost
            [v,index] = min(UBP(:,5));
            M_child = M;
            mi = UBP(index,1);
            wi = UBP(index,2);
            mj = UBP(index,3);
            wj = UBP(index,4);
            M_child(mi) = wj;
            M_child(mj) = wi;
            neighbors(end+1,:) = M_child;
        end
    end
    if rand() < p
         i = randi(size(neighbors,1),1,1);
         M = neighbors(i,:);
    else
        %find the minimum number of the blocking pairs
        fmin = inf;
        for i = 1:size(neighbors,1)
            fnbp = CountBlockingPairs(menList,womenList,neighbors(i,:));
            if fmin >= fnbp
                fmin = fnbp;
                M = neighbors(i,:);
            end
        end
    end
    f = CountBlockingPairs(menList,womenList,M);
    if (f == 0)
        break;
    end
    iter = iter + 1;
end
toc
iter
M
fmin