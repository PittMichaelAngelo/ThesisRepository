
%   █▀▄▀█ █ █▀▄▀█ █▀█ █▀█ █▀█ ▀█▀ ▀█   █   █▀█
%   █ ▀ █ █ █ ▀ █ █▄█ █▄█ █▀▀  █  █▄ ▄ █▄▄ █▀▀


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  CONSTRUCTOR                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type(a,Ai ; a,Aj ) :- construct(Ai,Aj,Tij,Tji,Mk).

ptarc(Ai,Tij,u,p ; Aj,Tji,u,p ; Aj,Tij,q,a ; Ai,Tji,q,a) :- construct(Ai,Aj,Tij,Tji,Mk).
tparc(Tji,Ai,u,p ; Tij,Aj,u,p ; Tji,Aj,q,a ; Tij,Ai,q,a) :- construct(Ai,Aj,Tij,Tji,Mk).

holds(A,A,0):- #count{P:holds(A,P,0),type(p,P)}=0, type(a,A).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               ON-ANTENNAS LIST                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

list(@genList("",A),TS):- on(A,Q,TS), Q=#min{O:type(p,O)},time(TS).
list(@genList(L ,A),TS):- on(A,Q,TS), Q=#max{O:type(p,O)},list(L,1,TS),time(TS). 
list(@genList(L, A),TS):- on(A,Q,TS), type(p,Q), list(L,S,TS), S>1.
list(L,@getSize(L),TS) :- list(L,TS),time(TS).

corrlist(L,TS):- list(L,C,TS), C=#count{T:type(p,T)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                    VALUES                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
off(A,Q,TS):- holds(A,Q,TS), type(a,Q), time(TS).
on(A,Q,TS):- holds(A,Q,TS), type(p,Q), time(TS).

value(Q,@c(A,P,L),P,TS):- candidateOn(A,P,TS), off(A,Q,TS),
                         corrlist(L,TS), time(TS).

value(Q,V,TS):- value(Q,V,P,TS).

value(Q,@c(P,P,L),TS):- on(P,Q,TS), corrlist(L,TS),
                        time(TS),TS=#min{X:time(X)}.

value(Qp,V,TS):- type(p,Qp), TS>#min{X:time(X)}, time(TS), fires(T,TS-1),
                    assigned(P,T,q,A,TS-1), V=#max{Z:value(A,Z,TS-1)}.

value(Q,0,TS) :-  not candidateOn(A,_,TS), off(A,Q,TS), time(TS).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 CONDITIONS                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% get greatest for place
fwcond(Tij,q,"unsat",0,TS) :-   #count{X:candidateOn(Aj,X,TS)}>1,    
                                ptarc(P,Tij,u,p), tparc(Tij,Aj,u,p),
                                candidateOn(Aj,P,TS),
                                M=#max{V:value(Q,V,TS)}, holds(Aj,Q,TS),
                                not value(Q,M,P,TS), time(TS).

% greedy
% fwcond(Tij,q,"=",M,TS) :- candidateOn(Aj,Nj,TS), maxdiff(M,TS),
%                           ptarc(Nj,Tij,u,p), tparc(Tij,Aj,u,p),
%                           not fwcond(Tij,q,"unsat",_,TS).

% maxdiff(M,TS):- M=#max{V:value(Q,V,TS)},time(TS).

% increasing sum capacity
fwcond(Tij,q,">",VQnj,TS) :-    candidateOn(Aj,Nj,TS), on(Nj,Qnj,TS),
                                value(Qnj,VQnj,TS), ptarc(Nj,Tij,u,p),
                                not fwcond(Tij,q,"unsat",_,TS),
                                tparc(Tij,Aj,u,p), time(TS).


candidateOn(A,P,TS) :-  connected(A,T), connected(T,P),
                        off(A,O,TS), on(P,Q,TS),
                        time(TS).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                   ERRORS                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

error("Type_Not_Specified",A):- holdsbonds(_,A,_,_), not type(_,A).
error("Type_Not_Specified",A):- holdsbonds(_,_,A,_), not type(_,A).
error("Type_Not_Specified",A):- holds(_,A,_), not type(_,A).
error("Token_Not_Used",Q):- type(T,Q), not holds(_,Q,0), not holdsbonds(_,Q,_,0),T!=a.
error("Wrong_power_in_PY.Correct_is:",C):- C=#count{T:type(p,T)}, value(_,-1,0).


%   █▀█ █▄█ ▀█▀ █ █ █▀█ █▄ █ ▄▀█ █▄ █ ▀█▀ █▀▀ █▄ █ █▄ █ ▄▀█ ▀█   █   █▀█
%   █▀▀  █   █  █▀█ █▄█ █ ▀█ █▀█ █ ▀█  █  ██▄ █ ▀█ █ ▀█ █▀█ █▄ ▄ █▄▄ █▀▀

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

mydict={}

sums=0

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
    return(round(np.real(c)*10**7))

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
    
def temp(l):
    global sums
    sums += 1
    if (sums>4400):
        print(l,sums)

#end.   


%    █▀▄▀█ █▀█ █▄ █ █▀▀ █▀█ █▄ █ █▀▄    █   █▀█
%    █ ▀ █ █▀▀ █ ▀█ █▄▄ █▄█ █ ▀█ █▄▀ 3▄ █▄▄ █▀▀


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                               NEW PREDICATES                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

token(Q):- type(_,Q).

place(P):- ptarc(P,_,_,_).                  
place(P):- tparc(_,P,_,_).                  
place(P):- ptarcb(P,_,_,_,_,_).             
place(P):- tparcb(_,P,_,_,_,_).                  

trans(T):- ptarc(_,T,_,_).        
trans(T):- tparc(T,_,_,_).   
trans(T):- ptarcb(_,T,_,_,_,_).     
trans(T):- tparcb(T,_,_,_,_,_).

holdsbonds(P,Q2,Q1,TS):-holdsbonds(P,Q1,Q2,TS).

same(Q,Q) :- token(Q).
same(P,P) :- place(P).

has(P,Q,TS):-holds(P,Q,TS).
has(P,Q,TS):-holdsbonds(P,Q,_,TS).

connected(P,T):-ptarc(P,T,_,_).
connected(P,T):-ptarcb(P,T,_,_,_,_).
connected(T,P):-tparc(T,P,_,_).
connected(T,P):-tparcb(T,P,_,_,_,_).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               ENABLING ASSIGNMENT                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

{satisfied(P,T,V,Q,TS)} :-  ptarc(P,T,V,X), has(P,Q,TS),
                            not unavailable(Q,TS),
                            satAllFwCond(T,V,Q,TS),
                            type(X,Q), time(TS).


{satisfied(P,T,V1,Q1,V2,Q2,TS)} :-  ptarcb(P,T,V1,T1,V2,T2),        % for a ptarcb
                                    holdsbonds(P,Q1,Q2,TS),         % if it has the bond needed
                                    type(T1,Q1), type(T2,Q2),       % of the correct type,
                                    not same(Q1,Q2),                % tokens are not the same
                                    not unavailable(Q1,TS),         % and both are not unavailable
                                    not unavailable(Q2,TS),         % then might be satisfied 
                                    not splitcycle(P,Q1,Q2,TS),     % if its not undecidable
                                    satAllFwCond(T,V1,Q1,TS),
                                    satAllFwCond(T,V2,Q2,TS),
                                    time(TS).              

% Because bonds might break or be formed, assign single tokens to single functions and not bonds.
assigned(P,T,F1,Q1,TS) :-   satisfied(P,T,F1,Q1,TS), time(TS).          % assign token Q1 to F1
assigned(P,T,F1,Q1,TS ; P,T,F2,Q2,TS) :-   satisfied(P,T,F1,Q1,F2,Q2,TS), time(TS).

% if more than 1 Function is assigned to a Token Q atm, then discard the set
numVarsAsgnToToken(P,T,Q,C,TS):-   C=#count{A:assigned(P,T,A,Q,TS)}, assigned(P,T,_,Q,TS).                       
:-numVarsAsgnToToken(P,T,Q,C,TS), C>1 , time(TS).

% if more than 1 Token is assigned to a Function F atm, then discard the set
numTokensAsgnToVar(P,T,F,C,TS):-   C=#count{A:assigned(P,T,F,A,TS)}, assigned(P,T,F,_,TS).
:-numTokensAsgnToVar(P,T,F,C,TS), C>1 , time(TS).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            TRANSITION CONDITIONS                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fwcond(T,Var,Eq,Val,TS) :- fwcond(T,Var,Eq,Val), time(TS).

ptValTypePair(P,T,V,TY):-ptarc(P,T,V,TY).
ptValTypePair(P,T,V1,T1 ; P,T,V2,T2):-ptarcb(P,T,V1,T1,V2,T2).


%conditions for both forward and collective-reverse executions
fwUnsatcond(T,V,Q,TS) :-    fwcond(T,V,">",X,TS), 
                            ptValTypePair(P,T,V,TY),
                            has(P,Q,TS), type(TY,Q),
                            A=#max{M:value(Q,M,TS)}, not A > X, time(TS).
                            
fwUnsatcond(T,V,Q,TS) :-    fwcond(T,V,"<",X,TS), 
                            ptValTypePair(P,T,V,TY), 
                            has(P,Q,TS), type(TY,Q),
                            A=#max{M:value(Q,M,TS)}, not A < X, time(TS).    

fwUnsatcond(T,V,Q,TS) :-    fwcond(T,V,"=",X,TS),
                            ptValTypePair(P,T,V,TY), 
                            has(P,Q,TS), type(TY,Q),
                            A=#max{M:value(Q,M,TS)}, A != X, time(TS).                                                      
                        
fwUnsatcond(T,V,Q,TS):-     fwcond(T,V,"!=",X,TS), 
                            ptValTypePair(P,T,V,TY), 
                            has(P,Q,TS), type(TY,Q),
                            A=#max{M:value(Q,M,TS)}, A = X, time(TS).

fwUnsatcond(T,V,Q,TS):-     fwcond(T,V,"unsat",X,TS),
                            ptValTypePair(P,T,V,TY), 
                            has(P,Q,TS), type(TY,Q),
                            value(Q,M,TS), time(TS).                            

satAllFwCond(T,V,Q,TS):-    not fwUnsatcond(T,V,Q,TS), place(P),
                            ptValTypePair(P,T,V,TY), has(P,Q,TS), type(TY,Q), time(TS).

:-  not assigned(P,T,Vns,_,TS), satAllFwCond(T,Vns,Q,TS), assigned(P,T,V,Q,TS), Vns!=V,
    satAllFwCond(T,V,Q2,TS), not same(Q,Q2), not assigned(P,T,_,Q2,TS), not unavailable(Q2,TS), time(TS).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             TOKEN DESCRIPTIONS                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% If Q1 and Q2 are chained after breaking Q1 and Q2, then they are in a circle and its undecidable how
% to split them on the seperating bond.
splitcycle(P,Q1,Q2,TS) :-   chain(P,Q1,Q2,Q1,Q2,TS).  

chain(P,Q1,Q2,A,B,TS) :-    holdsbonds(P,Q1,Q2,TS),            % IDEA:
                            holdsbonds(P,A,B,TS),              % create the chain between all bonds 
                            not same(Q1,A), not same(Q1,B),    % except the seperating bond A and B.
                            splitbond(P,T,F1,T1,F2,T2),        
                            type(T1,A), type(T2,B),                             
                            time(TS). 

chain(P,Q1,Q2,A,B,TS) :-    chain(P,Q1,Q3,A,B,TS),      % if Q1-Q3-Q2 is chained                                 
                            chain(P,Q2,Q3,A,B,TS),      % then Q1 is chained with Q2
                            not same(Q1,Q2),
                            time(TS).
 
chain(P,Q1,Q2,A,B,TS) :-    chain(P,Q2,Q1,A,B,TS).


unavailable(Q,TS) :-    holdsbonds(P,Q,QQ,TS),          % a not assigned Token
                        not assigned(P,_,_,Q,TS),       % is unavailable
                        assigned(P,_,_,QQ,TS),          % if it is bonded with an assigned token
                        time(TS).

unavailable(Q,TS) :-    holdsbonds(P,Q,QQ,TS),          % a not assigned Token
                        not assigned(P,_,_,Q,TS),       % is unavailable
                        unavailable(QQ,TS),             % if it is bonded with an unavailable token
                        time(TS).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                    ENABLED                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% T is enabled if the number of distinct ptarcb/6 is equal to the number of satisfied/7 arcs
enabled(T,TS) :-    C1=#count{P,F1,T1,F2,T2:ptarcb(P,T,F1,T1,F2,T2), place(P)}, 
                    C1{satisfied(_,T,_,_,_,_,TS)}C1, 
                    C2=#count{P,F1,T1:ptarc(P,T,F1,T1), place(P)},
                    C2{satisfied(_,T,_,_,TS)}C2, 
                    C1 + C2 > 0,
                    trans(T), time(TS).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%					              VALUE UPDATE  	                       	   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%if a new value has not been given, then keep the same value
updated(Q,TS+1):- value(Q,V,TS), value(Q,VN,TS+1), VN!=V, time(TS+1).
value(Q,V,TS+1):- value(Q,V,TS), not updated(Q,TS+1), time(TS+1).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%					                  FIRE  	                        	   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

{fires(T,TS)} :- enabled(T,TS), time(TS).

firing(C,TS) :- C=#count{T:fires(T,TS)}, time(TS).
:-firing(C,TS), C>1, time(TS).                      
:-firing(C,TS), C=0, enabled(T,TS), time(TS). 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%					               AFTER FIRE  	                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

splitbond(P,T,F1,T1,F2,T2) :-   ptarcb(P,T,F1,T1,F2,T2),   
                                not tparcb(T,_,F1,T1,F2,T2). 

splitbond(T,Q1,Q2 ; T,Q2,Q1) :- splitbond(P,T,F1,T1,F2,T2),
                                assigned(PT,T,F1,Q1,TS), assigned(PT,T,F2,Q2,TS),
                                time(TS).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     NOT ASSIGNED TOKENS / BONDS      %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

holds(P,Q,TS+1) :-  fires(T,TS),
                    holds(P,Q,TS),
                    not assigned(P,T,_,Q,TS),
                    not unavailable(Q,TS),         
                    time(TS+1).

holdsbonds(P,Q1,Q2,TS+1) :- fires(T,TS),
                            holdsbonds(P,Q1,Q2,TS),   
                            not assigned(P,T,_,Q1,TS),
                            not unavailable(Q1,TS),
                            time(TS+1).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       ASSIGNED TOKENS / BONDS        %    	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% single token transfer
% it could also execute when a bond is broken after execution of T
holds(P,Q1,TS+1):-  fires(T,TS),                           % P now holds Q1         
                    tparc(T,P,F1,T1),                      % if F1:T1 comes to P,                
                    assigned(PT,T,F1,Q1,TS), type(T1,Q1),  % Q1 was assigned to F1
                    not holdsbonds(PT,Q1,_,TS),            % and Q1 was not boneded
                    time(TS+1).

% OR Q1 was boned but the bond broke and left Q1 unbonded
holds(P,Q1,TS+1):-  fires(T,TS),
                    tparc(T,P,F1,T1),                      % if F1:T1 comes to P                
                    assigned(PT,T,F1,Q1,TS), type(T1,Q1),  % Q1 was assigned to F1.
                    holdsbonds(PT,Q1,Q2,TS),               % Q1 was bonded with Q2
                    not holdsbonds(PT,Q1,Q3,TS),           % only
                    token(Q3), not same(Q2,Q3), 
                    splitbond(T,Q1,Q2),                    % but the bond broke
                    time(TS+1).

% a new bond was Formed from T, connecting tokens from PT1 and PT2
holdsbonds(P,Q1,Q2,TS+1):-  fires(T,TS),
                            tparcb(T,P,F1,T1,F2,T2),
                            assigned(PT1,T,F1,Q1,TS), type(T1,Q1),
                            assigned(PT2,T,F2,Q2,TS), type(T2,Q2),
                            time(TS+1).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   BONDED TO ASSIGNED TOKENS / BONDS  %    	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Situation: tparc(P,T,F1,Q1) but Q1 was bonded 
holdsbonds(P,Q1,Q2,TS+1):-  fires(T,TS),                            
                            holdsbonds(PT,Q1,Q2,TS),                % if a token Q2 was bonded at PT,
                            assigned(PT,T,F1,Q1,TS), type(T1,Q1),   % with an assigned token F1:Q1, 
                            not splitbond(T,Q1,Q2),                 % the bond didnt break
                            tparc(T,P,F1,T1),                       % and Q1 was coming to P
                            unavailable(Q2,TS),                     % then move the whole bond to P
                            time(TS+1).                                  

% Situation: a bond transfered to P was bonded with other tokens as well before, so we also move them.
holdsbonds(P,Q1,Q2,TS+1):-  fires(T,TS),   
                            holdsbonds(P,Q1,_,TS+1),      % if P holds Q1            
                            holdsbonds(PT,Q1,Q2,TS),      % it should hold its bonds also
                            not splitbond(T,Q1,Q2),       % if they didnt break
                            unavailable(Q2,TS),                  
                            time(TS+1).

holds(A,B,TS+1) :- holds(A,B,TS),not fires(_,TS),time(TS+1).
holdsbonds(A,B,C,TS+1) :- holdsbonds(A,B,C,TS),not fires(_,TS),time(TS+1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   ASSIGN ALL TOKENS THAT CAN BE ASSIGNED  	               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
                                                                % REMOVE WORLDS WHERE:
:-  has(P,Q,TS), type(T1,Q), ptarc(P,T,V1,T1),                      % a place P holds an available                             
    not satisfied(P,T,V1,_,TS), satAllFwCond(T,V1,Q,TS),               % and appropriate token,
    not assigned(P,T,_,Q,TS), not unavailable(Q,TS), time(TS).      % but does not get assigned to V1
   
:-  holdsbonds(P,Q1,Q2,TS), ptarcb(P,T,V1,T1,V2,T2),                % a place P holds an available
    type(T1,Q1), type(T2,Q2),                                       % and appropriate bond
    not satisfied(P,T,V1,_,V2,_,TS),                                % but does not get assigned
    not assigned(P,T,_,Q1,TS), not unavailable(Q1,TS),
    not assigned(P,T,_,Q2,TS), not unavailable(Q2,TS),
    satAllFwCond(T,V1,Q1,TS), satAllFwCond(T,V2,Q2,TS),
    not splitcycle(P,Q1,Q2,TS), 
    time(TS).
