%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            ARCS            %     	                        	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ptarcb(x,t1,u,a,v,b).
ptarcb(x,t1,u,a,w,c).
tparcb(t1,z,u,a,w,c).
tparc(t1,y,v,b).

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
holdsbonds(x,a1,b1,0).
holdsbonds(z,a2,c2,0).
holds(y,b2,0).


%%%%%%%%%%%
%  TIME   %     	                        	  
%%%%%%%%%%%
time(0..2).

%%%%%%%%%%%
%  GOAL   %     	                        	  
%%%%%%%%%%%
goal:-  holdsbonds(x,a2,b1,2),
        holdsbonds(x,a2,c2,2),
        holdsbonds(z,a1,c1,2).

:-not goal.



           
% PLACES      \
% TRANSITIONS  | => AUTO - GENERATED
% TOKENS      /