place(p). place(s).
token(a).
trans(t1). trans(t2). 

ptarc(s,t1,a).
ptarc(p,t2,a).

tparc(t1,p,a).
tparc(t2,s,a).

holds(s,a,0).

time(0..6).
history(0..6).

transHistory(T,0,0):-trans(T).


goal :- holds(s,a,TS).
:- not goal.