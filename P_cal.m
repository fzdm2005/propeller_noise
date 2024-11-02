function p = P_cal(vlt,slope)
    if (nargin<2)
        slope = 0.045;
    end
p = vlt./slope;