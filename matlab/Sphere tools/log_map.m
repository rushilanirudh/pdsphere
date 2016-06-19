%logarithmic map
function vec=log_map(psi1,psi2)
u=psi2-(psi1'*psi2)*psi1;
vec=u/norm(u)*rdist(psi1,psi2);
end