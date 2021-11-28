within AircraftDynamics.Functions;

function GlobalFrame2earthConvention
  extends Modelica.Icons.Function;
  
  input Modelica.SIunits.Position XG;
  input Modelica.SIunits.Position YG;
  input Modelica.SIunits.Position ZG;
  
  output Modelica.SIunits.Position xEast;
  output Modelica.SIunits.Position xNorth;
  output Modelica.SIunits.Position alt;
algorithm
  xEast:= YG;
  xNorth:= XG;
  alt:= -1.0*ZG;
end GlobalFrame2earthConvention;
