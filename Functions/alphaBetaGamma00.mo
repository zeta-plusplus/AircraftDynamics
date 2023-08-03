within AircraftDynamics.Functions;

function alphaBetaGamma00
  extends Modelica.Icons.Function;
  //****************************************
  import units= Modelica.Units.SI;
  //****************************************
  input units.Velocity u;
  input units.Velocity v;
  input units.Velocity w;
  input units.Velocity dXG;
  input units.Velocity dYG;
  input units.Velocity dZG;
  //----------
  output units.Angle alpha;
  output units.Angle beta;
  output units.Angle gamma;
  
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
