function [PPx,PPy]=CRspline(w,px,py,t)
    % % curve 
    N=length(px);
    Knot=[0 0 0 linspace(0,1,N-2) 1 1 1];
    PPx =zeros(length(t)); PPy=zeros(length(t));
    R=zeros(N,length(t));
    for i=1:N
    B(i,:)=C_Bspline(Knot(i),Knot(i+1),Knot(i+2),Knot(i+3),Knot(i+4),t);
    end
    t=zeros(1,N);  
    t=w*B;  %1:m
    for i=1:1:N
        R(i,:)=w(i)*B(i,:)./t;
    end
    PPx=px*R;PPy=py*R;