%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        CONSTRUCTOR         %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
construct(a1,a2,t12,t21,m).
% construct(a1,a6,t16,t61,m).
construct(a1,a5,t15,t51,m).
construct(a2,a3,t23,t32,m).
% construct(a2,a4,t24,t42,m).
construct(a2,a12,t212,t122,m).
construct(a3,a8,t38,t83,m).
construct(a3,a11,t311,t113,m).
construct(a4,a7,t47,t74,m).
construct(a5,a6,t56,t65,m).
construct(a6,a7,t67,t76,m).
% construct(a7,a8,t78,t87,m).
construct(a7,a10,t710,t107,m).
construct(a8,a9,t89,t98,m).
% construct(a4,a12,t412,t124,m).
construct(a11,a12,t1112,t1211,m).


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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TOKEN & BOND DISTRIBUTION  %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holds(a1,p1,0).
% holdsbonds(m,m1,a1,0).
holds(a5,p2,0).
% holdsbonds(m,m2,a5,0).
holds(a6,p3,0).
holds(a2,p4,0).
% holdsbonds(m,m3,a6,0). 


%%%%%%%%%%%
%  TIME   %     	                        	  
%%%%%%%%%%%
time(0..1).

%%%%%%%%%%%%%%%%%%
%  REACHABILITY  %     	                        	  
%%%%%%%%%%%%%%%%%%
goal:-time(0).
:-not goal.


