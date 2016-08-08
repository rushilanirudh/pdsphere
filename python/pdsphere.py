
import numpy as np
import matplotlib.pyplot as plt
import pylab
import scipy
from weighted_kde import gaussian_kde as weighted_gaussian_kde
from scipy.stats.distributions import norm

from numpy import linalg as LA
from mpl_toolkits.mplot3d.axes3d import Axes3D
from scipy.stats import gaussian_kde
from sphere_geometry import rdist,exp_map,log_map

def generate(data_length, odes, state, parameters):
    data = np.zeros([state.shape[0], data_length])

    for i in xrange(5000):
        state = rk4(odes, state, parameters)

    for i in xrange(data_length):
        state = rk4(odes, state, parameters)
        data[:, i] = state

    return data

def rk4(odes, state, parameters, dt=0.01):
    k1 = dt * odes(state, parameters)
    k2 = dt * odes(state + 0.5 * k1, parameters)
    k3 = dt * odes(state + 0.5 * k2, parameters)
    k4 = dt * odes(state + k3, parameters)
    return state + (k1 + 2 * k2 + 2 * k3 + k4) / 6

def lorenz_odes((x, y, z), (sigma, beta, rho)):
    return np.array([sigma * (y - x), x * (rho - z) - y, x * y - beta * z])


def lorenz_generate(data_length):
    return generate(data_length, lorenz_odes, \
        np.array([-8.0, 8.0, 27.0]), np.array([10.0, 8/3.0, 28.0]))

def rossler_odes((x, y, z), (a, b, c)):
    return np.array([-y - z, x + a * y, b + z * (x - c)])


def rossler_generate(data_length):
    return generate(data_length, rossler_odes, \
        np.array([10.0, 0.0, 0.0]), np.array([0.15, 0.2, 10.0]))

#---------------------------------------------------------------------------#

def persDiag2heatMap(data,sig):
	m1, m2 = data[:,0], data[:,1]
	xmin, xmax = min(m1), max(m1)
	ymin, ymax = min(m2), max(m2)
	weights = np.ones((1, 100))
	weights[0,60] = 20;
	weights /= np.sum(weights)

	x, y = np.mgrid[xmin:xmax:100j, ymin:ymax:100j]
	positions = np.vstack([x.ravel(), y.ravel()])
	values = np.vstack([m1, m2])
	#pdf = gaussian_kde(values,bw_method=sig)
	pdf = weighted_gaussian_kde(values,bw_method = sig,weights = weights)
	z = pdf(positions)
	f = np.reshape(z, x.shape)
	fig = plt.figure()
 	ax = fig.gca()
	ax.set_xlim(xmin, xmax)
 	ax.set_ylim(ymin, ymax)
 	cfset = ax.contourf(x, y, f, cmap='Blues')
 	cset = ax.contour(x, y, f, colors='k')
 	ax.clabel(cset, inline=1, fontsize=10)
 	ax.set_xlabel('Y1')
 	ax.set_ylabel('Y0')
 	plt.show()
	return z

def mapHeatMap2Sphere(data):
	a = data
	b = np.divide(a, LA.norm(a))
	return b

#---------------------------------------------------------------------------#
np.random.seed(0)
data = np.random.random((100,2))
f = persDiag2heatMap(data,.1)
mapHeatMap2Sphere(data)

s1 = mapHeatMap2Sphere(np.random.rand(1, 100))
s2 = mapHeatMap2Sphere(np.random.rand(1, 100))

vec = log_map(s1,s2)
s2_hat = exp_map(s1, vec, 1)




























