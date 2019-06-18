within AircraftDynamics.Functions;

function calcAngles4display
  extends Modelica.Icons.Function;
  input Modelica.SIunits.Angle angCumulative;
  output Modelica.SIunits.Angle ang4disp;
algorithm
  if( (2.0*Modelica.Constants.pi) <= angCumulative)then
    ang4disp:=mod(angCumulative, 2.0*Modelica.Constants.pi);
  elseif(angCumulative < (-2.0*Modelica.Constants.pi) )then
    ang4disp:= -1.0*mod((-1.0*angCumulative), 2.0*Modelica.Constants.pi);
  else
    ang4disp:=angCumulative;
  end if;
  
end calcAngles4display;
