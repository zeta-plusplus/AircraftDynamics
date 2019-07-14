within AircraftDynamics.Aerodynamics.Example.test;

model FuselageSimple00_test01
  extends Modelica.Icons.Example;
  package atmAir = Modelica.Media.Air.DryAirNasa;
  //----
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium = atmAir, T = 288.15, nPorts = 1, p = 101.3 * 1000)  annotation(
    Placement(visible = true, transformation(origin = {-70, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 20, height = 0.7, offset = 0.1, startTime = 30)  annotation(
    Placement(visible = true, transformation(origin = {-90, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.DragObjSimple00 dragObjSimple001(redeclare package Medium = atmAir) annotation(
    Placement(visible = true, transformation(origin = {50, -50}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
equation
  connect(boundary.ports[1], dragObjSimple001.port_amb) annotation(
    Line(points = {{-60, 50}, {23, 50}, {23, -32}}, color = {0, 127, 255}));
  connect(ramp1.y, dragObjSimple001.busFltStates1.Mn) annotation(
    Line(points = {{-79, -80}, {-25, -80}, {-25, -68}, {23, -68}}, color = {0, 0, 127}));  
annotation(
    experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
    
    
end FuselageSimple00_test01;
