within AircraftDynamics.Aerodynamics.Example.test;

model DragObjSimple00_test01
  extends Modelica.Icons.Example;
  //----
  //package atmAir = Modelica.Media.Air.DryAirNasa;
  package atmAir= AircraftDynamics.Media.DryAirMethaneMixture00;
  //----
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium = atmAir, T = 288.15, nPorts = 1, p = 101.3 * 1000)  annotation(
    Placement(visible = true, transformation(origin = {-70, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_Mn(duration = 20, height = 0.7, offset = 0.1, startTime = 30)  annotation(
    Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.DragObjSimple00 dragObj(redeclare package Medium = atmAir) annotation(
    Placement(visible = true, transformation(origin = {9.33333, 0.4}, extent = {{-29.3333, -17.6}, {29.3333, 17.6}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_alpha(duration = 20, height = 0.7, offset = 0.1, startTime = 30) annotation(
    Placement(visible = true, transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(boundary.ports[1], dragObj.port_amb) annotation(
    Line(points = {{-60, 50}, {-17, 50}, {-17, 18}}, color = {0, 127, 255}));
  connect(ramp_Mn.y, dragObj.busFltStates1.Mn) annotation(
    Line(points = {{-79, -30}, {-17, -30}, {-17, -17}}, color = {0, 0, 127}));
  connect(ramp_alpha.y, dragObj.busFltStates1.alpha) annotation(
    Line(points = {{-78, -70}, {-17, -70}, {-17, -17}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
    
    
end DragObjSimple00_test01;
