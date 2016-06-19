%exponential map
function out = exp_map(psi,vec,t)
v=norm(vec)+eps;
out = cos(t*v)*psi+ sin(t*v)*vec/v;
end