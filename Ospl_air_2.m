function Ospl = Ospl_air_2(P,f)
P_ref = 2e-5;
for i = 1:length(f)-1
    df = f(i+1)-f(i);
    p_sum(i) = P(i)*df;
end
Ospl = 10.*log10(sum(p_sum.^2)./P_ref^2);