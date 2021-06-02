%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        CONSTRUCTOR         %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
construct(a1,a2,t12,t21,m).
construct(a1,a4,t14,t41,m).
construct(a2,a3,t23,t32,m).
construct(a2,a10,t210,t102,m).
construct(a4,a5,t45,t54,m).
construct(a4,a7,t47,t74,m).
construct(a5,a8,t58,t85,m).
construct(a5,a10,t510,t105,m).
construct(a6,a9,t69,t96,m).
construct(a6,a10,t610,t106,m).
construct(a8,a9,t89,t98,m).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        POWER TOKENS        %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
type(p,p1).
type(p,p2).
type(p,p3).
% type(p,p4).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TOKEN & BOND DISTRIBUTION  %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holds(a1,p1,0).
holds(a5,p2,0).
holds(a10,p3,0).

%%%%%%%%%%%
%  TIME   %     	                        	  
%%%%%%%%%%%
% time(0..7).

time(0..7).
% time(TS+1):- trans(T),enabled(T,TS),time(TS),TS<10.
%%%%%%%%%%%%%%%%%%
%  REACHABILITY  %     	                        	  
%%%%%%%%%%%%%%%%%%

% goal:-on(a6,_,7), on(a7,_,7), on(a9,_,7).
goal:-time(0).
:-not goal.

#show value/3.
#show value/4.
#show fires/2.
#show time/1.
#show enabled/2.
#show holds/3.
#show candidateOn/3.
% #show fwUnsatcond/4.
#show fwcond/5.