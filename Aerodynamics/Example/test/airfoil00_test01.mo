within AircraftDynamics.Aerodynamics.Example.test;

model airfoil00_test01
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp ramp1(duration = 20, height = 7 * 2 * (Modelica.Constants.pi / 180), offset = -7 * (Modelica.Constants.pi / 180), startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-70, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.BaseClasses.AirfoilSimple00 airfoilSimple001 annotation(
    Placement(visible = true, transformation(origin = {-40.25, 30.2}, extent = {{-12.25, -9.8}, {12.25, 9.8}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1 annotation(
    Placement(visible = true, transformation(origin = {10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-30, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const.y, add1.u1) annotation(
    Line(points = {{-19, 60}, {-10, 60}, {-10, 16}, {-2, 16}}, color = {0, 0, 127}));
  connect(airfoilSimple001.signalBus2.Cl, add1.u2) annotation(
    Line(points = {{-34, 20}, {-34, 20}, {-34, 4}, {-2, 4}, {-2, 4}}, color = {0, 0, 127}));
  connect(ramp1.y, airfoilSimple001.signalBus1.alpha) annotation(
    Line(points = {{-58, 10}, {-46, 10}, {-46, 20}, {-46, 20}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-06, Interval = 0.01),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end airfoil00_test01;