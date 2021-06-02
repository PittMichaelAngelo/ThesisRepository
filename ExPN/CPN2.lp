place(l). place(e). place(m). place(i). place(r).
token(a). token(b). token(c).
trans(t1). trans(t2). trans(t3).

ptarc(l,t1,a).
ptarc(e,t1,b).
ptarc(m,t2,a).
ptarc(i,t2,c).
ptarc(r,t3,b).
ptarc(r,t3,c).

tparcbond(t1,m,a,b).
tparcbond(t2,r,a,c).
tparcbond(t3,i,b,c).

holds(l,a,0).
holds(e,b,0).
holds(i,c,0).

time(0..5).
history(0..5).

transHistory(T,0,0):-trans(T).

goal :- fires(t3,2).
:- not goal.