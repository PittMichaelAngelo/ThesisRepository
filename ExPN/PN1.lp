place(r). place(p). place(s). place(u). place(z).
token(a). token(b).
trans(t1). trans(t2). trans(t3).

ptarc(r,t1,a).
ptarc(p,t2,b).
ptarc(s,t3,a).
ptarc(u,t3,b).

tparc(t1,s,a).
tparc(t2,u,b).
tparcbond(t3,z,a,b).

holds(r,a,0).
holds(u,b,0).

time(0..5).
history(0..5).

transHistory(T,0,0):-trans(T).

goal :- enabledB(t2,X),holds(z,A,B).
:- not goal.

