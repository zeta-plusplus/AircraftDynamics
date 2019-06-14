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
  AircraftDynamics.Aerodynamics.Components.DragObjSimple00 dragObjSimple001(redeclare package Medium = atmAir) annotation(
    Placement(visible = true, transformation(origin = {20, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ramp1.y, dragObjSimple001.busFltStates1.Mn) annotation(
    Line(points = {{-58, 10}, {-12, 10}, {-12, 4}, {12, 4}, {12, 4}}, color = {0, 0, 127}));
  connect(boundary.ports[2], dragObjSimple001.port_amb) annotation(
    Line(points = {{-60, 50}, {12, 50}, {12, 24}, {12, 24}}, color = {0, 127, 255}));
  connect(ramp1.y, fuselageSimple001.busFltStates1.Mn) annotation(
    Line(points = {{-58, 10}, {-38, 10}, {-38, 20}, {-36, 20}}, color = {0, 0, 127}));
  connect(boundary.ports[1], fuselageSimple001.port_amb) annotation(
    Line(points = {{-60, 50}, {-38, 50}, {-38, 40}, {-38, 40}}, color = {0, 127, 255}));
  
annotation(
    experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
    
    
end FuselageSimple00_test01;
