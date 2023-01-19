function E=forwardSorting(E,n,a)
%使数组中的全部元素向前移动一位
%E=zeros(1,n);
for i=1:n-1
    E(i)=E(i+1);
end
E(n)=a;