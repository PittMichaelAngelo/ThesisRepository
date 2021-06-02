place(l). place(p). place(s). place(r).
token(a). token(b).
trans(t1). trans(t2). trans(t3). trans(t4).

ptarc(l,t1,a).
ptarc(l,t2,b).
ptarc(s,t3,a).
ptarc(p,t3,b).
ptarcbond(r,t4,a,b).

tparc(t1,s,a). 
tparc(t2,p,b).
tparcbond(t3,r,a,b).
tparcbond(t4,l,a,b).

holds(l,a,0).
holds(l,b,0).

time(0..5).
history(0..5).

transHistory(T,0,0):-trans(T).

goal :- fires(t1,X).
:- not goal.