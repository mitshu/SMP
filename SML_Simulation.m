function SML_Simulation 
clc
clear all;
close all;
f_arr_time = [];
f_arr_iter = [];
for n = 10:20:40
    for j = 0:9
        filename = ['Inputs\I',num2str(n+j),'.mat'];
        load(filename,'menList','womenList');
        [f_time,f_iters] = SML_evaluation(menList,womenList);
        f_arr_time(end+1) = f_time;
        f_arr_iter(end+1) = f_iters;
        [n+j,f_time,f_iters]
    end
end
figure;
bar(f_arr_time)
figure;
bar(f_arr_iter)
end
%===========================================================
function [f_time,f_iters] = SML_evaluation(menList,womenList)
%generate a random matching
n = size(menList,1);
X = rand(1,n);
[~,M] = sort(X);
%algorithm
MAX_ITERS = 10000;
iter = 1;
p = 0.05;
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
            if (i ~=j) && (BlockingPair(menList,womenList,mi,wi,mj,wj))
                BP(end+1,:) = [mi,wi,mj,wj];
            end
        end
    end
    %find the neighbor set of matching M
    neighbors = [];
    for i = 1:size(BP,1)
        M_child = M;
        mi = BP(i,1);
        wi = BP(i,2);
        mj = BP(i,3);
        wj = BP(i,4);
        M_child(mi) = wj;
        M_child(mj) = wi;
        neighbors(end+1,:) = M_child;
    end
    if rand() < p
         i = randi(size(neighbors,1),1,1);
         M = neighbors(i,:);
    else
        %find the minimum number of the blocking pairs
        fmin = CountBlockingPairs(menList,womenList,M);
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
f_time = toc;
f_iters = iter;
end
%======================================================================