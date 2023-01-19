function [x,y,z] =Dini(m,n)
%
a=1; b=2;
u=linspace(0,4*pi,m);v=linspace(0.001,2,n);
x=a*cos(u)'*sin(v);y=a*sin(u)'*sin(v);
z=a*ones(m,1)*(cos(v)+log(tan(v./2)))+b*u'*ones(1,n);
end

