function B=C_Bspline(t0,u1,t2,u3,t4,t)
%������[a,b]�ϵ�����B����
if t0==u1 && u1==t2 && t2==u3 && u3==t4
    error('The input is Wrong! Please check!')
elseif t0==u1 && u1==t2 && t2==u3 && u3~=t4
    B=(t4-t)/(t4-u1).*Q_Bspline(u1,t2,u3,t4,t);
elseif t0~=u1 && u1==t2 && t2==u3 && u3==t4
    B=(t-t0)/(u3-t0).*Q_Bspline(t0,u1,t2,u3,t);
else
    B=(t-t0)/(u3-t0).*Q_Bspline(t0,u1,t2,u3,t)+(t4-t)/(t4-u1).*Q_Bspline(u1,t2,u3,t4,t);
end
end

