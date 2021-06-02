%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        CONSTRUCTOR         %     	                        	  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
construct(a1,a2,t12,t21,m).
construct(a2,a3,t23,t32,m).
construct(a4,a5,t45,t54,m).
construct(a5,a6,t56,t65,m).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        POWER TOKENS        %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
type(p,p1).
type(p,p2).
type(p,p3).
type(p,p4).
% type(m,m1).
% type(m,m2).
% type(m,m3).
% type(m,m4).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TOKEN & BOND DISTRIBUTION  %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holds(a1,p1,0).
% holdsbonds(m,m1,a1,0). 
holds(a3,p2,0).
% holdsbonds(m,m2,a3,0). 
holds(a4,p3,0).
% holdsbonds(m,m3,a4,0). 
holds(a6,p4,0).
% holdsbonds(m,m4,a6,0). 

%%%%%%%%%%%
%  TIME   %     	                        	  
%%%%%%%%%%%
time(0..1).

%%%%%%%%%%%%%%%%%%
%  REACHABILITY  %     	                        	  
%%%%%%%%%%%%%%%%%%
goal:-time(0).
:-not goal.


