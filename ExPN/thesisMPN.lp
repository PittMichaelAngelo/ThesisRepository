%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            ARCS            %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ptarc(x,t,u,a).
ptarcb(y,t,v,a,w,b).
tparcb(t,z,u,a,w,b).
tparc(t,z,v,a).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        TYPE - TOKENS       %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
type(a,a1). type(a,a2).
type(b,b1). type(b,b2).  
type(c,c1). type(c,c2). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TOKEN & BOND DISTRIBUTION  %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holdsbonds(x,a1,c1,0).
holdsbonds(y,a2,b2,0).
holdsbonds(y,b2,c2,0).

%%%%%%%%%%%
%  TIME   %     	                        	  
%%%%%%%%%%%
time(0..1).

%%%%%%%%%%%
%  GOAL   %     	                        	  
%%%%%%%%%%%
goal:-time(0).

:-not goal.



           
% PLACES      \
% TRANSITIONS  | => AUTO - GENERATED
% TOKENS      /