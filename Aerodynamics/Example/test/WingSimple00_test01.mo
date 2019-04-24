within AircraftDynamics.Aerodynamics.Example.test;

model WingSimple00_test01
  extends Modelica.Icons.Example;
  package engineAir = Modelica.Media.Air.DryAirNasa;
  //----
  
  
  AircraftDynamics.Aerodynamics.Components.Flight2Fluid flight2Fluid1(redeclare package Medium = engineAir) annotation(
    Placement(visible = true, transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.WingSimple00 wingSimple001(redeclare package Medium = engineAir) annotation(
    Placement(visible = true, transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 20, height = 0, offset = 0.3, startTime = 30)  annotation(
    Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp2(duration = 20, height = 0, offset = 5.0 * Modelica.Constants.pi / 180, startTime = 30) annotation(
    Placement(visible = true, transformation(origin = {-90, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ramp2.y, wingSimple001.u_alpha) annotation(
    Line(points = {{-78, -20}, {-30, -20}, {-30, 4}, {-20, 4}, {-20, 4}}, color = {0, 0, 127}));
  connect(flight2Fluid1.u_Mn, ramp1.y) annotation(
    Line(points = {{-60, 16}, {-69.5, 16}, {-69.5, 30}, {-79, 30}}, color = {0, 0, 127}));
  connect(flight2Fluid1.y_Mn, wingSimple001.u_Mn) annotation(
    Line(points = {{-39, 8}, {-23, 8}, {-23, 8}, {-21, 8}, {-21, 8}, {-21, 8}}, color = {0, 0, 127}));
  connect(flight2Fluid1.port_fluidAmb, wingSimple001.port_amb) annotation(
    Line(points = {{-50, 20}, {-50, 23}, {-50, 23}, {-50, 26}, {-18, 26}, {-18, 23}, {-18, 23}, {-18, 20}}, color = {0, 127, 255}));
  annotation(
    Icon(coordinateSystem(initialScale = 0.05)),
    Diagram(coordinateSystem(initialScale = 0.05)));

end WingSimple00_test01;