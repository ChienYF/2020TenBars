function k=element_k(r,e,l,c,s)
k=e*r^2*pi/l*...
    [ c^2, c*s, -c^2, -c*s;
    c*s, s^2, -c*s, -s^2;
    -c^2, -c*s, c^2, c*s;
    -c*s, -s^2, c*s, s^2];