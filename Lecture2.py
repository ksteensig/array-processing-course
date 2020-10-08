from math import sin,cos,pi
import numpy as np

N=4
var=0.001

lmax=(1+2*var+abs(cos(2*pi/N)))
lmin=(1+2*var-abs(cos(2*pi/N)))

mu=2/(lmax+lmin)

condR = lmax/lmin

Ru = np.array([[1+2*var, cos(2*pi/N)], [cos(2*pi/N), 1+2*var]])
rud = np.array([[0], [-sin(2*pi/N)]])

w = np.zeros((2,1))

g = lambda w: 2*Ru.dot(w) - 2*rud

while True:
    w_old = w
    w = w - 0.5*mu*g(w)
    #print(w)
    print(np.linalg.norm(w-w_old))
    if np.linalg.norm(w-w_old) < 0.000001:
        break