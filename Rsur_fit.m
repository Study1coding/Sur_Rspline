
function [PPx,PPy,PPz]=Rsur_fit(w,px,py,pz,tx,ty)
    N=length(px(1,:));
    M=length(py(:,1)); 
    Knotx=[0 0 0 linspace(0,1,N-2) 1 1 1];
    Knoty=[0 0 0 linspace(0,1,M-2) 1 1 1];
    n=length(tx);
    m=length(ty);
    Bx=zeros(N,length(tx));
    for i=1:N
        Bx(i,:)=C_Bspline(Knotx(i),Knotx(i+1),Knotx(i+2),Knotx(i+3),Knotx(i+4),tx);
    end  
    By=zeros(M,length(ty));
    for j=1:M
        By(j,:)=C_Bspline(Knoty(j),Knoty(j+1),Knoty(j+2),Knoty(j+3),Knoty(j+4),ty);
    end   

    Q=By'*w*Bx; %m*n 
    PPx=By'*(px.*w)*Bx./Q;
    PPy=By'*(py.*w)*Bx./Q;
    PPz=By'*(pz.*w)*Bx./Q;
end






% function [PPx,PPy,PPz]=Rsur_fit(wx,wy,px,py,pz,tx,ty)
%     N=length(px(1,:));
%     M=length(py(:,1));
%     
%     Knotx=[0 0 0 linspace(0,1,N-2) 1 1 1];
%     Knoty=[0 0 0 linspace(0,1,M-2) 1 1 1];
%     
%     n=length(tx);
%     m=length(ty);
%     
%     PPx=zeros(m,n);
%     PPy=zeros(m,n);
%     PPz=zeros(m,n);
%     
%     Bx=zeros(N,length(tx));
%     for i=1:N
%         Bx(i,:)=C_Bspline(Knotx(i),Knotx(i+1),Knotx(i+2),Knotx(i+3),Knotx(i+4),tx);
%     end
%     
%     By=zeros(M,length(ty));
%     for j=1:M
%         By(j,:)=C_Bspline(Knoty(j),Knoty(j+1),Knoty(j+2),Knoty(j+3),Knoty(j+4),ty);
%     end   
%     sx=wx*Bx;  %1:m
%     for i=1:1:N
%         Rx(i,:)=wx(i)*Bx(i,:)./sx;
%     end 
%     sy=wy*By;  %1:m
%     for i=1:1:M
%         Ry(i,:)=wy(i)*By(i,:)./sy;
%     end
%     
%     PPx=Ry'*px*Rx;
%     PPy=Ry'*py*Rx;
%     PPz=Ry'*pz*Rx;
% end