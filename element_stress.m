function s=element_stress(Ee,le,cos,sin,Qe)
s= Ee/le*[-cos, -sin, cos, sin]*Qe;
end