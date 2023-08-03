within AircraftDynamics.Functions;

function GlobalFrame2earthConvention
  extends Modelica.Icons.Function;
  //
  import units = Modelica.Units.SI;
  
  //
  input units.Position XG;
  input units.Position YG;
  input units.Position ZG;
  
  output units.Position xEast;
  output units.Position xNorth;
  output units.Position alt;
algorithm
  xEast:= YG;
  xNorth:= XG;
  alt:= -1.0*ZG;
end GlobalFrame2earthConvention;
