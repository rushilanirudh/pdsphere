import numpy as np
from numpy import linalg as LA
import math

EPS = 10**-14

def exp_map(psi,vec,t):
	v = LA.norm(vec)+EPS
	a = math.cos(v*t)
	b = math.sin(v*t)
	c = np.multiply(vec, b)
	return a*psi + np.divide(c,v)

def log_map(psi1,psi2):
	dot = np.dot(psi1,psi2.T)
	u = psi2 - np.multiply(psi1,dot)
	vec1 = np.divide(u, LA.norm(u))
	return np.multiply(vec1, rdist(psi1,psi2))

def rdist(vec1,vec2):
	k = LA.norm(vec1)**2 + LA.norm(vec2)**2
	return np.abs(math.acos(2*np.dot(vec1,vec2.T)/k))