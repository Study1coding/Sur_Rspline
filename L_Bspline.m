function B=L_Bspline(t0,u1,t2,t)
    %在区间[a,b]上的一次B样条
    [m,n]=size(t); 
    for j=1:1:m
        for i=1:1:n
            if t0~=u1 && t0<=t(j,i) && t(j,i)<=u1
                B(j,i)=(t(j,i)-t0)/(u1-t0);
            elseif u1~=t2 && u1<=t(j,i) && t(j,i)<=t2
                B(j,i)=(t2-t(j,i))/(t2-u1);
            else
                B(j,i)=0;
            end
        end
    end
 end
