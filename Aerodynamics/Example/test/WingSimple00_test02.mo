within AircraftDynamics.Aerodynamics.Example.test;

model WingSimple00_test02
  extends Modelica.Icons.Example;
  package atmAir = Modelica.Media.Air.DryAirNasa;
  //----
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium = atmAir, T = 288.15, nPorts = 1, p = 101.3 * 1000) annotation(
    Placement(visible = true, transformation(origin = {-70, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.WingSimple00 wingSimple001(redeclare package Medium = atmAir) annotation(
    Placement(visible = true, transformation(origin = {60, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 20, height = -0.5, offset = 0.9, startTime = 30)  annotation(
    Placement(visible = true, transformation(origin = {-80, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp2(duration = 20, height = 40 * Modelica.Constants.pi / 180, offset = -20 * Modelica.Constants.pi / 180, startTime = 30)  annotation(
    Placement(visible = true, transformation(origin = {-60, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Min min1 annotation(
    Placement(visible = true, transformation(origin = {-20, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Max max1 annotation(
    Placement(visible = true, transformation(origin = {20, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 15 * Modelica.Constants.pi / 180)  annotation(
    Placement(visible = true, transformation(origin = {-40, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant const1(k = -15 * Modelica.Constants.pi / 180)  annotation(
    Placement(visible = true, transformation(origin = {0, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PropulsionSystem.Utilities.SetDependent setDependent1(tgtVal = 5000)  annotation(
    Placement(visible = true, transformation(origin = {90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Utilities.SetIndependent setIndependent1(independent(start = 4 * Modelica.Constants.pi / 180))  annotation(
    Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(wingSimple001.y_Lf, setDependent1.dependent_in) annotation(
    Line(points = {{60, 42}, {60, 50}, {79, 50}}, color = {0, 0, 127}));
  connect(boundary.ports[1], wingSimple001.port_amb) annotation(
    Line(points = {{-60, 50}, {52, 50}, {52, 40}}, color = {0, 127, 255}));
  connect(ramp1.y, wingSimple001.u_Mn) annotation(
    Line(points = {{-68, 10}, {-42, 10}, {-42, 28}, {49, 28}}, color = {0, 0, 127}));
  connect(max1.y, wingSimple001.u_alpha) annotation(
    Line(points = {{32, -30}, {36, -30}, {36, 24}, {49, 24}}, color = {0, 0, 127}));
  connect(setIndependent1.independent_out, min1.u1) annotation(
    Line(points = {{-78, -30}, {-76, -30}, {-76, -12}, {-42, -12}, {-42, -24}, {-32, -24}, {-32, -24}}, color = {0, 0, 127}));
  connect(const1.y, max1.u2) annotation(
    Line(points = {{0, -48}, {0, -48}, {0, -36}, {8, -36}, {8, -36}}, color = {0, 0, 127}));
  connect(min1.y, max1.u1) annotation(
    Line(points = {{-8, -30}, {-4, -30}, {-4, -24}, {8, -24}, {8, -24}}, color = {0, 0, 127}));
  connect(const.y, min1.u2) annotation(
    Line(points = {{-40, -48}, {-40, -48}, {-40, -36}, {-32, -36}, {-32, -36}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(initialScale = 0.05)),
    Diagram(coordinateSystem(initialScale = 0.05)),
  experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-6, Interval = 0.002),
  __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
    
end WingSimple00_test02;
