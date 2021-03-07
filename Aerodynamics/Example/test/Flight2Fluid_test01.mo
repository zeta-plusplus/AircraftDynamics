within AircraftDynamics.Aerodynamics.Example.test;

model Flight2Fluid_test01
  extends Modelica.Icons.Example;
  //package atmAir = Modelica.Media.Air.DryAirNasa;
  package atmAir= AircraftDynamics.Media.DryAirMethaneMixture00;
  //----
  
  
  AircraftDynamics.Aerodynamics.Components.Flight2Fluid flight2Fluid1(redeclare package Medium = atmAir) annotation(
    Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  

annotation(
    Icon(coordinateSystem(initialScale = 0.05)),
    Diagram(coordinateSystem(initialScale = 0.05)));


end Flight2Fluid_test01;
