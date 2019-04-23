within AircraftDynamics.Aerodynamics.Example.test;

model WingSimple00_test01
  extends Modelica.Icons.Example;
  package engineAir = Modelica.Media.Air.DryAirNasa;
  //----
  
  
  AircraftDynamics.Aerodynamics.Components.Flight2Fluid flight2Fluid1 annotation(
    Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.WingSimple00 wingSimple001 annotation(
    Placement(visible = true, transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(flight2Fluid1.port_fluidAmb, wingSimple001.port_amb) annotation(
    Line(points = {{-90, 20}, {-90, 26}, {-58, 26}, {-58, 20}}, color = {0, 127, 255}));
  annotation(
    Icon(coordinateSystem(initialScale = 0.05)),
    Diagram(coordinateSystem(initialScale = 0.05)));

end WingSimple00_test01;