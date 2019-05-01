within AircraftDynamics.Aerodynamics.Example.test;

model FuselageSimple00_test01
  extends Modelica.Icons.Example;
  package atmAir = Modelica.Media.Air.DryAirNasa;
  //----
  
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium = atmAir, T = 288.15, nPorts = 2, p = 101.3 * 1000)  annotation(
    Placement(visible = true, transformation(origin = {-70, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.FuselageSimple00 fuselageSimple001(redeclare package Medium = atmAir) annotation(
    Placement(visible = true, transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 20, height = 0.7, offset = 0.1, startTime = 30)  annotation(
    Placement(visible = true, transformation(origin = {-70, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.DragObjSimple00 dragObjSimple001(redeclare package Medium = atmAir) annotation(
    Placement(visible = true, transformation(origin = {-10, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(boundary.ports[2], dragObjSimple001.port_amb) annotation(
    Line(points = {{-60, 50}, {-18, 50}, {-18, 0}, {-18, 0}}, color = {0, 127, 255}));
  connect(ramp1.y, dragObjSimple001.u_Mn) annotation(
    Line(points = {{-58, 10}, {-36, 10}, {-36, -10}, {-22, -10}, {-22, -12}}, color = {0, 0, 127}));
  connect(ramp1.y, fuselageSimple001.u_Mn) annotation(
    Line(points = {{-58, 10}, {-48, 10}, {-48, 30}, {-42, 30}, {-42, 28}}, color = {0, 0, 127}));
  connect(boundary.ports[1], fuselageSimple001.port_amb) annotation(
    Line(points = {{-60, 50}, {-38, 50}, {-38, 40}, {-38, 40}}, color = {0, 127, 255}));
  
annotation(
    experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
    
    
end FuselageSimple00_test01;
