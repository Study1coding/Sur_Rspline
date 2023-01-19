
% 代码基本完成，出现了Dini曲面的误差极大情形，开eg4进行专项研究.
clearvars;close all;
n=40;
m=40;
u=linspace(0,1,n);
v=linspace(0,1,m);
x1 = linspace(-2,2,n); 
y1 = linspace(-2,2,m);
[x,y]=meshgrid(x1,y1);
z=((x).^2-(y).^2);
% z=sin(x).^2+y.^2;
% z=3*(1-x).^2.*exp(-(x.^2)-(y+1).^2)-10*(x/5-x.^3-y.^5).*exp(-x.^2-y.^2)-1/3*exp(-(x+1).^2-y.^2);

% 例子2
% [x,y,z]=Dini(m,n);

% x=x+1/10*rand(m,n)-1/20;
% y=y+1/10*rand(m,n)-1/20;
% z=z+1/10*rand(m,n)-1/20;
fprintf("数据点数目(v,u)=%d,%d",m,n);
M=8;  N=8;
index1=[1,floor(n/(N-1)*(1:N-2)),n];
index2=[1,floor(m/(M-1)*(1:M-2)),m];
px=x(index2,index1);
py=y(index2,index1);
pz=z(index2,index1);
fprintf("控制点数目(v,u)=%d,%d",M,N);

Esp=1e-2;
%收敛到极限的判断

E=1e5;
delta=E;
%E为误差大小，delta为两次迭代的误差差距；
i=0;
%i为迭代的次数；

Iteration=100;
%收敛的判别区域
CuE=delta*ones(1,Iteration+1);
%构建一个比较矩阵

Knotx=[0 0 0 linspace(0,1,N-2) 1 1 1];
Bx=zeros(N,length(u));
for j1=1:N
    Bx(j1,:)=C_Bspline(Knotx(j1),Knotx(j1+1),Knotx(j1+2),Knotx(j1+3),Knotx(j1+4),u);
end
Knoty=[0 0 0 linspace(0,1,M-2) 1 1 1];
By=zeros(M,length(v));
for j2=1:M
    By(j2,:)=C_Bspline(Knoty(j2),Knoty(j2+1),Knoty(j2+2),Knoty(j2+3),Knoty(j2+4),v);
end


% wx=ones(1,N);  wy=ones(1,M);
A=Bx*Bx';
lambda1=max(abs(eig(A)));
B=By*By';
lambda2=max(abs(eig(B)));
mu=4/(lambda1*lambda2)*0.40;
% mu=min(2/lambda1,2/lambda2)*0.9;

% mu=4e-2;
mu2=1e-7;
%u为步长
w=ones(M,N);
w2=w;
Q=By'*w*Bx;  %m*n
tic
while delta>Esp
    [ppx2,ppy2,ppz2]=Rsur_fit(w,px,py,pz,u,v);  %修改权重
    a=x-ppx2;
    b=y-ppy2;
    c=z-ppz2;
   
    dx=mu*By*(a./Q)*Bx';
    dy=mu*By*(b./Q)*Bx';
    dz=mu*By*(c./Q)*Bx';
    px=px+dx;
    py=py+dy;
    pz=pz+dz;
    
    [ppx2,ppy2,ppz2]=Rsur_fit(w,px,py,pz,u,v);  %修改权重
    a=x-ppx2;
    b=y-ppy2;
    c=z-ppz2;
    dw=mu2*px.*(By*(a./Q)*Bx')+ mu2*py.*(By*(b./Q)*Bx') + mu2*pz.*(By*(c./Q)*Bx');   
    w2=w2+dw;
     
    disp('-------------误差计算-------------');
    i=i+1;
    disp(['迭代次数第',num2str(i),'次时']);
    E=sum(sum(a.*a+b.*b+c.*c));
    MSE=E/n/m;
    disp(['均方误差MSE：',num2str(MSE)]);
    disp(['最小二乘意义下的误差E：',num2str(E)]);
    CuE=forwardSorting(CuE,Iteration+1,E);
    if i>Iteration+2
        delta=abs(CuE(Iteration+1)-CuE(1));
        disp(['迭代误差：',num2str(delta)]);
    end
end
mesh(ppx2,ppy2,ppz2);hold on ; plot3(px,py,pz,'o');
% surf(ppx2,ppy2,ppz2,'edgecolor','none');hold on ; plot3(px,py,pz,'r.')
% title("拟合曲面和控制点分布");plot3(x,y,z,'b.');
toc

    
