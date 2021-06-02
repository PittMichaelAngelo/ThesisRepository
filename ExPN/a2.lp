%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        CONSTRUCTOR         %     	                        	  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
construct(a1,a2,t12,t21,m).
construct(a2,a5,t25,t52,m).
construct(a2,a3,t23,t32,m).
construct(a3,a4,t34,t43,m).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        POWER TOKENS        %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
type(p,p1).
type(m,m1).
type(p,p2).
type(m,m2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TOKEN & BOND DISTRIBUTION  %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holds(a1,p1,0).
holdsbonds(m,a1,m1,0).
holds(a4,p2,0).
holdsbonds(m,a4,m2,0).


%%%%%%%%%%%
%  TIME   %     	                        	  
%%%%%%%%%%%
% time(0..3).
time(0..5).
% time(TS+1):- trans(T),enabled(T,TS),time(TS),TS<20.

%%%%%%%%%%%%%%%%%%
%  REACHABILITY  %     	                        	  
%%%%%%%%%%%%%%%%%%
goal:-time(0).
:-not goal.


#show value/3.
#show fires/2.
#show time/1.
#show enabled/2.
#show holds/3.
#show candidateOn/3.
#show fwUnsatcond/4.
