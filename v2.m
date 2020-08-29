function [S,Q]=v2(r)
% node list
n1=[18.28,9.14];
n2=[18.28,0];
n3=[9.14, 9.14];
n4=[9.14, 0];
n5=[0, 9.14];
n6=[0,0];
e=[n3,n5,3,5;
    n1,n3,1,3;
    n4,n6,4,6;
    n2,n4,2,4;
    n3,n4,3,4;
    n1,n2,1,2;
    n4,n5,4,5;
    n3,n6,3,6;
    n2,n3,2,3;
    n1,n4,1,4];

%get the length of the bars
for i=1:10
    L(i)=((e(i,3)-e(i,1))^2+(e(i,4)-e(i,2))^2)^0.5;
end

%get the trigonometric function of the bars
for i=1:10
    sin(i)= (e(i,4)-e(i,2))/L(i);
    cos(i)= (e(i,3)-e(i,1))/L(i);
end

%konw
r1=r(1);
r2=r(2);
% r1=0.1;
% r2=0.05;
E=200e+9;

%get elemental stiffness matrix
for i=1:6 
        eval(['K',num2str(i),'=','element_k(r1,E,L(i),cos(i),sin(i))',';']);
end
for i=7:10
        eval(['K',num2str(i),'=','element_k(r2,E,L(i),cos(i),sin(i))',';']);
end

for i=1:12
    for j=1:12
        K(i,j)=0;
    end
end

for i=1:10
        tag=[e(i,5)*2-1,e(i,5)*2,e(i,6)*2-1,e(i,6)*2];
        eval(['k_temp=K' num2str(i) ';']);
        for j=1:4
            for k=1:4
                K(tag(j),tag(k))=K(tag(j),tag(k))+k_temp(j,k);
            end
        end                         
end

%displacement
K_reduce=K(1:8,1:8);
F=[0;0;0;-1e+7;0;0;0;-1e+7];
Q_reduce= K_reduce\F;
Q=[Q_reduce;0;0;0;0];

%stress
for i=1:10
     eval(['Q',num2str(i),'=','[Q(e(i,5)*2-1);Q(e(i,5)*2);Q(e(i,6)*2-1);Q(e(i,6)*2)]',';']);
end
for i=1:10
        eval(['Qe=Q' num2str(i) ';'])
        S(i,:) = E/L(i)*[-cos(i), -sin(i), cos(i), sin(i)]*Qe;
end

%reaction
K_reaction=K(9:12,1:12);
R=K_reaction*Q;

%sin 跟cos 打反了北七
%Q(1)打成Q(11)了北七
