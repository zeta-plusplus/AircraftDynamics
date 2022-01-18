within AircraftDynamics.Functions;

function alphaBetaGamma00
  extends Modelica.Icons.Function;
  //****************************************
  import Units= Modelica.SIunits;
  //****************************************
  input Units.Velocity u;
  input Units.Velocity v;
  input Units.Velocity w;
  input Units.Velocity dXG;
  input Units.Velocity dYG;
  input Units.Velocity dZG;
  //----------
  output Units.Angle alpha;
  output Units.Angle beta;
  output Units.Angle gamma;
  
algorithm
  alpha:= atan2(w, u);
  beta:= atan2(v, u);
  
  if((dXG^2+dYG^2)<>0)then
    gamma:= (-1*dZG)/(sqrt(dXG^2+dYG^2));
  else
    if(0<(-1*dZG))then
      gamma:= 90*Modelica.Constants.pi/180;
    elseif((-1*dZG)<0)then
      gamma:= -90*Modelica.Constants.pi/180;
    else
      gamma:=0;
    end if;
  end if;
  
end alphaBetaGamma00;
