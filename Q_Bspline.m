function B = Q_Bspline(t0,u1,t2,u3,t)
%区间[a,b]上的二次B样条
n = length(t);
if t0==u1 && u1==t2 && t2==u3
    error('The input is Wrong! Please check!')
elseif t0==u1 && u1==t2 && t2~=u3
    B=(u3-t)/(u3-u1).*L_Bspline(u1,t2,u3,t);
elseif t0~=u1 && u1==t2 && t2==u3
    B=(t-t0)/(t2-t0).*L_Bspline(t0,u1,t2,t);
else
    B=(t-t0)/(t2-t0).*L_Bspline(t0,u1,t2,t)+(u3-t)/(u3-u1).*L_Bspline(u1,t2,u3,t);
end
end
