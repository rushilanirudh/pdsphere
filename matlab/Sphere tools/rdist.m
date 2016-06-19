function out= rdist(r1,r2)
k = norm(r1)^2 + norm(r2)^2;
out=abs(acos(2*r1'*r2/k));
end