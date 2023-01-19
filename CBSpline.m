function [PPx,PPy]=CBSpline(px,py,t)
    N=length(px);
    Knot=[0 0 0 linspace(0,1,N-2) 1 1 1];
    PPx=linspace(0,0,length(t)); 
    PPy=linspace(0,0,length(t));
    B=zeros(N,length(t));
    for i=1:N
        B(i,:)=C_Bspline(Knot(i),Knot(i+1),Knot(i+2),Knot(i+3),Knot(i+4),t);
    end
    for i=1:N
        PPx=PPx+px(i)*B(i,:);
        PPy=PPy+py(i)*B(i,:);
    end
end