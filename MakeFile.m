clc;
clear all;
for n = 20
   % for j = 1:10
        %sinh ra 2 ma tran ngau nhien A va B
        A = rand(n,n);
        B = rand(n,n);
        %tao menList va womanList
        [~,menList] = sort(A,2);
        [~,womenList] = sort(B,2);
        %
        filename = ['Inputs\I',num2str(n),'.mat'];
        save(filename,'menList','womenList');
    %end
end
