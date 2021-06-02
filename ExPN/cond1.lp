ptarcb(p,t1,u,a,v,b).
tparcb(t1,r,u,a,v,b).

fwcond(t1,u,">",10).
fwcond(t1,u,"<",15).
fwcond(t1,v,"!=",0).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        TYPE - TOKENS       %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type(a,a1). 
type(a,a2). 
type(b,b1).
type(b,b2).
value(a1,11,0).
value(a2,100,0).
value(b1,1,0).
value(b2,2,0).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TOKEN & BOND DISTRIBUTION  %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holdsbonds(p,a1,b1,0).
holdsbonds(p,a2,b2,0).

% holds(l,a2,0).
% holds(l,a3,0).
% holds(l,a3,0).
% holdsbonds(l,m1,a1,0). 

%%%%%%%%%%%
%  TIME   %     	                        	  
%%%%%%%%%%%
time(0..1).

%%%%%%%%%%%
%  GOAL   %     	                        	  
%%%%%%%%%%%
goal:- time(0).
:-not goal.

#show value/3.
% #show fwcond/5.
#show fwsatcond/5.
#show assigned/5.
#show satAllFwCond/4.
#show enabled/2.
% #show ptValTypePair/4.