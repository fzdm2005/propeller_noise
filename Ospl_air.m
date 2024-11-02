function Ospl = Ospl_air(P)
P_ref = 2e-5;
Ospl = 10.*log10(sum(P.^2)./P_ref^2);