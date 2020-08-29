function [g,geq]=nonlcon(r)
[S,Q]=v2(r);
for i=1:10
    g(i)=abs(S(i))-250e+6;
end
g(11)=(Q(3)^2+Q(4)^2)^0.5-0.02;
geq=[];