within AircraftDynamics.Aerodynamics.Example.test;

model Flight2Fluid_test01
  extends Modelica.Icons.Example;
  //----
  //package atmAir = Modelica.Media.Air.DryAirNasa;
  package atmAir = AircraftDynamics.Media.DryAirMethaneMixture00;
  //redeclare package Medium=atmAir
  //----
  AircraftDynamics.Sources.FlightCondition2Fluid00 Flt2Fluid(redeclare package Medium = atmAir, alt_paramInput = 0) annotation(
    Placement(visible = true, transformation(origin = {-60, 3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  inner AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

annotation(
    Icon(coordinateSystem(initialScale = 0.05)),
    Diagram(coordinateSystem(initialScale = 0.05)));


end Flight2Fluid_test01;
