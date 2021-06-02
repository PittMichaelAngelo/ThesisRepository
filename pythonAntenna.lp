#script (python)
import clingo
import numpy as np
import math
import bisect
import random as rnd

H=np.array([[1,1,1,1],[2,2,2,2],[3,3,3,3],[4,4,4,4],
            [5,5,5,5],[6,6,6,6],[7,7,7,7],[8,8,8,8],
            [9,9,9,9],[1,1,4,7],[0,0,1,0],[4,5,3,2]])
antenas=["a1","a2","a3","a4","a5","a6","a7","a8","a9","a10","a11","a12"]

SNR = 0.5
PREC=7

mydict={}


def genList(l,new):
    nl=str(l)[1:-1]
    t = nl.split()
    if str(new) not in t: 
        t.append(str(new))
        t.sort()
        nl=""
        for i in t:
            nl+=i+" "
    return(nl)

def getSize(l):
    t = str(l)[1:-1].split()
    return(len(t))
    
def calcSumCap(t):
    NTS = len(H)
    NR = len(H[0])
    Hc = np.zeros((NTS,NR),dtype=int)
    for onAnt in t:
        i = antenas.index(str(onAnt))
        Hc[i] = H[i]
    HcH = np.matrix(Hc).getH()
    P = np.zeros((NR, NR), float)
    np.fill_diagonal(P, (1/NR))
    I = np.identity(NTS)
    c = np.log2(np.linalg.det(np.add(I,SNR*NR/NTS*np.matmul(np.matmul(Hc,P),HcH))))
    return(round(np.real(c)*10**PREC))

def c(candOn,currOn,l):
    t = str(l)[1:-1].split()
    if (str(currOn) not in t): 
        return -1
    t.remove(str(currOn))
    bisect.insort(t,str(candOn)) #insert sorted
    nl=""
    for i in t:
        nl+=i+" "
    if nl in mydict:
        return(mydict[nl])
    mydict[nl]=calcSumCap(t)
    return(mydict[nl])

#end.   

