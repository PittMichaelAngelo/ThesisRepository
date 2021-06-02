
tparcb(t,r,u,a,v,a).
ptarc(l,t,u,a).
ptarc(l,t,v,a).

fwcond(t,u,">",30).
fwcond(t,v,">",20).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        TYPE - TOKENS       %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type(a,a1). value(a1,35,0).
type(a,a2). value(a2,25,0).
type(a,a3). value(a3,15,0).
type(a,a4). value(a4,3,0).
type(a,a5). value(a5,235,0).
type(a,a6). value(a6,20,0).
% type(a,a2). value(a2,2,0).
% type(a,a3). value(a3,4,0).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TOKEN & BOND DISTRIBUTION  %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holds(l,a1,0).
holds(l,a2,0).
holds(l,a3,0).
holds(l,a4,0).
holds(l,a5,0).
holds(l,a6,0).

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
#show fwcond/5.
#show fwsatcond/5.
#show fwsatcond/6.
#show satAllFwCond/3.
#show satAllFwCond/4.
#show enabled/2.
#show ptValTypePair/4.