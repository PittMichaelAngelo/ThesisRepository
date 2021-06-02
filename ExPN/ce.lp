%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        CONSTRUCTOR         %     	                        	  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
construct(a1,a2,t12,t21,m).
% construct(a2,a3,t23,t32,m).
construct(a1,a4,t14,t41,m).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        POWER TOKENS        %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
type(p,p1).
% type(m,m1).
% type(p,p2).
% type(m,m2).
type(p,p3).
% type(m,m3).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TOKEN & BOND DISTRIBUTION  %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holds(a2,p1,0).
% holds(a3,p2,0).
holds(a4,p3,0).

%%%%%%%%%%%
%  TIME   %     	                        	  
%%%%%%%%%%%
% time(0..3).
time(0..1).
% enabled(t,0).
%time(TS+1):- trans(T),enabled(T,TS),time(TS),TS<20.

%%%%%%%%%%%%%%%%%%
%  REACHABILITY  %     	                        	  
%%%%%%%%%%%%%%%%%%
goal:-time(0).
:-not goal.

