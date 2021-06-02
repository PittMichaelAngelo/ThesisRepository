%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        CONSTRUCTOR         %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
construct(a1,a2,t12,t21,m).
construct(a2,a3,t23,t32,m).
construct(a2,a4,t24,t42,m).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        POWER TOKENS        %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
type(p,p1).
type(m,m1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TOKEN & BOND DISTRIBUTION  %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holds(a1,p1,0).
holdsbonds(m,m1,a1,0). 

%%%%%%%%%%%
%  TIME   %     	                        	  
%%%%%%%%%%%
time(0..2).

%%%%%%%%%%%%%%%%%%
%  REACHABILITY  %     	                        	  
%%%%%%%%%%%%%%%%%%
goal:-time(0).
:-not goal.


