within AircraftDynamics.Aerodynamics.Example.test;

model WingSimple00_test02
  extends Modelica.Icons.Example;
  package atmAir = Modelica.Media.Air.DryAirNasa;
  //redeclare package Medium = atmAir
  //----
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium = atmAir, T = 288.15, nPorts = 1, p = 101.3 * 1000) annotation(
    Placement(visible = true, transformation(origin = {-50, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 80, height = -0.6, offset = 0.9, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-80, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Min min1 annotation(
    Placement(visible = true, transformation(origin = {-50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Max max1 annotation(
    Placement(visible = true, transformation(origin = {-10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 14 * Modelica.Constants.pi / 180) annotation(
    Placement(visible = true, transformation(origin = {-70, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant const1(k = -14 * Modelica.Constants.pi / 180) annotation(
    Placement(visible = true, transformation(origin = {-30, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PropulsionSystem.Utilities.SetDependent setDependent1(tgtVal = 5000) annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Utilities.SetIndependent setIndependent1(independent(start = 4 * Modelica.Constants.pi / 180)) annotation(
    Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.Components.WingSimple00 wing annotation(
    Placement(visible = true, transformation(origin = {32.463, 40.3796}, extent = {{-11.4316, -40.0104}, {11.4316, 40.0104}}, rotation = 0)));
equation
  connect(boundary.ports[1], wing.port_amb) annotation(
    Line(points = {{-40, 90}, {-8, 90}, {-8, 80}, {26, 80}}, color = {0, 127, 255}));
  connect(ramp1.y, wing.busFltStates1.Mn) annotation(
    Line(points = {{-68, 10}, {-21, 10}, {-21, 0}, {26, 0}}, color = {0, 0, 127}));
  connect(wing.y_Lf, setDependent1.dependent_in) annotation(
    Line(points = {{40, 82}, {40, 90}, {79, 90}}, color = {0, 0, 127}));
  connect(max1.y, wing.busFltStates1.alpha) annotation(
    Line(points = {{1, -30}, {1, -30.5}, {26, -30.5}, {26, 0}}, color = {0, 0, 127}));
  connect(const1.y, max1.u2) annotation(
    Line(points = {{-30, -49}, {-30, -36}, {-22, -36}}, color = {0, 0, 127}));
  connect(const.y, min1.u2) annotation(
    Line(points = {{-70, -49}, {-70, -36}, {-62, -36}}, color = {0, 0, 127}));
  connect(setIndependent1.independent_out, min1.u1) annotation(
    Line(points = {{-78, -30}, {-76, -30}, {-76, -24}, {-62, -24}}, color = {0, 0, 127}));
  connect(min1.y, max1.u1) annotation(
    Line(points = {{-38, -30}, {-34, -30}, {-34, -24}, {-22, -24}, {-22, -24}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(initialScale = 0.05)),
    Diagram(coordinateSystem(initialScale = 0.05), graphics = {Text(origin = {-91, -43}, extent = {{-9, 3}, {9, -3}}, textString = "AoA"), Text(origin = {-81, -7}, extent = {{-9, 3}, {9, -3}}, textString = "Mn")}),
    experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.02),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end WingSimple00_test02;
