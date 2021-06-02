place(r).
token(a). token(b).
trans(t1). trans(t2).

ptarc(r,t1,a).
ptarc(r,t2,b).

tparc(t1,r,a).
tparc(t2,r,b).

holdsbonds(r,a,b,0).
holds(r,a,0).
holds(r,b,0).

time(0..4).
history(0..4).

transHistory(T,0,0):-trans(T).

goal :- holdsbonds(r,a,b,B).
:- not goal.