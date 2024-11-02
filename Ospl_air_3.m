function Ospl = Ospl_air_3(P,f)
P_ref = 2e-5;
p2 = P.^2./P_ref^2;
s = trapz(f,p2);
Ospl = 10.*log10(s);