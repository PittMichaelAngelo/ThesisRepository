%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        CONSTRUCTOR         %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
construct(a1,a2,t12,t21,m).
construct(a1,a6,t16,t61,m).
construct(a1,a5,t15,t51,m).
construct(a2,a3,t23,t32,m).
construct(a2,a4,t24,t42,m).
construct(a3,a8,t38,t83,m).
construct(a4,a7,t47,t74,m).
construct(a5,a6,t56,t65,m).
construct(a6,a7,t67,t76,m).
construct(a7,a8,t78,t87,m).
construct(a7,a10,t710,t107,m).
construct(a8,a9,t89,t98,m).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        POWER TOKENS        %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
type(p,p1).
type(p,p2).
type(p,p3).
% type(m,m1).
% type(m,m2).
% type(m,m3).


type(p,p4).
% type(m,m4).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TOKEN & BOND DISTRIBUTION  %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holds(a1,p1,0).
% holdsbonds(m,m1,a1,0).
holds(a3,p3,0).
% holdsbonds(m,m3,a3,0). 
holds(a5,p2,0).
% holdsbonds(m,m2,a5,0).


holds(a12,p4,0).
% holdsbonds(m,m4,a12,0).
%%%%%%%%%%%
%  TIME   %     	                        	  
%%%%%%%%%%%
% time(0..7).

% time(0..2).
% time(TS+1):- trans(T),enabled(T,TS),time(TS),TS<10.
%%%%%%%%%%%%%%%%%%
%  REACHABILITY  %     	                        	  
%%%%%%%%%%%%%%%%%%

goal:-time(0).
:-not goal.

% #show value/3.
% #show fires/2.
% #show time/1.
% #show enabled/2.
% #show holds/3.
% #show candidateOn/3.
% #show fwUnsatcond/4.
% #show fwcond/5.