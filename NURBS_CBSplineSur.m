function [PPx,PPy,PPz]=NURBS_CBSplineSur(w,px,py,pz,tx,ty)
    N=length(px(1,:));
    M=length(py(:,1));
    
    Knotx=[0 0 0 linspace(0,1,N-2) 1 1 1];
    Knoty=[0 0 0 linspace(0,1,M-2) 1 1 1];
    
    n=length(tx);
    m=length(ty);
    
    PPx=zeros(m,n);
    PPy=zeros(m,n);
    PPz=zeros(m,n);
    
    Bx=zeros(N,length(tx));
    for i1=1:N
        Bx(i1,:)=C_Bspline(Knotx(i1),Knotx(i1+1),Knotx(i1+2),Knotx(i1+3),Knotx(i1+4),tx);
    end
    Rx=zeros(N,length(tx));
    summx=zeros(1,length(tx));
    for i2=1:1:N
        Rx(i2,:)=w(i2)*Bx(i2,:);
        summx=summx+Rx(i2,:);
    end
    Rx=zeros(N,length(tx));
    for i3=1:1:N
        Rx(i3,:)=Bx(i3,:)./summx;
    end
    
    By=zeros(M,length(ty));
    for j1=1:M
        By(j1,:)=C_Bspline(Knoty(j1),Knoty(j1+1),Knoty(j1+2),Knoty(j1+3),Knoty(j1+4),ty);
    end
    Ry=zeros(M,length(ty));
    summy=zeros(1,length(ty));
    for j2=1:1:M
        Ry(j2,:)=w(j2)*By(j2,:);
        summy=summy+Ry(j2,:);
    end
    Ry=zeros(M,length(ty));
    for j3=1:1:M
        Ry(j3,:)=By(j3,:)./summy;
    end
    
    for i=1:N
        for j=1:M
            PPx=PPx+w(j,i)*px(j,i)*Ry(j,:)'*Rx(i,:);
            PPy=PPy+w(j,i)*py(j,i)*Ry(j,:)'*Rx(i,:);
            PPz=PPz+w(j,i)*pz(j,i)*Ry(j,:)'*Rx(i,:);
        end
    end
    
end