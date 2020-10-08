from math import sin,cos,pi
import numpy as np
import numpy.linalg as la

def lms(u,w,d,mu,n):
    un = np.array(u(n))
    wn = np.array(w(n))
    dn = d(n)
    
    en = dn - un.transpose().dot(wn)
    
    return wn + mu*un*en

def nlms(u,w,d,beta,eps,n):
    un = np.array(u(n))
    wn = np.array(w(n))
    dn = d(n)
    
    en = dn - un.transpose().dot(wn)
    
    scale = beta/(eps + la.norm(un)**2)
    
    return wn + scale*un*en

def apa(U,w,d,beta,eps,n):
    Un = np.array(U(n))
    wn = np.array(w(n))
    dn = np.array(d(n))
    
    en = dn - Un.transpose().dot(wn)
    
    inner_Un = Un.transpose().dot(Un)
    inner = eps*np.ones(inner_Un.shape) + inner_Un
    
    return wn + beta*Un.dot(la.inv(inner)).dot(en)