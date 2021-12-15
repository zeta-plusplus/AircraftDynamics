within AircraftDynamics.Aerodynamics.Example.test;

model Airfoil2wing_test00
  extends Modelica.Icons.Example;
  AircraftDynamics.Aerodynamics.BaseClasses.AirfoilSimple00 airfoilSimple001 annotation(
    Placement(visible = true, transformation(origin = {-40.75, 43.6}, extent = {{-20.75, -16.6}, {20.75, 16.6}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.BaseClasses.Airfoil2WingSimple00 airfoil2WingSimple001 annotation(
    Placement(visible = true, transformation(origin = {30, 50}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 10, height = 7 * 2 * Modelica.Constants.pi / 180, offset = -7 * Modelica.Constants.pi / 180, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-80, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0.3)  annotation(
    Placement(visible = true, transformation(origin = {-80, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const.y, airfoil2WingSimple001.signalBus1.Mn) annotation(
    Line(points = {{-69, -20}, {15, -20}, {15, 20}}, color = {0, 0, 127}));
  connect(airfoilSimple001.signalBus2, airfoil2WingSimple001.signalBus1) annotation(
    Line(points = {{-30, 27}, {-30, 8}, {15, 8}, {15, 20}}, color = {255, 204, 51}, thickness = 0.5));
  connect(ramp1.y, airfoilSimple001.signalBus1.alpha) annotation(
    Line(points = {{-69, 10}, {-52, 10}, {-52, 27}, {-51, 27}}, color = {0, 0, 127}));

annotation(
    Icon(coordinateSystem(initialScale = 0.05)),
    Diagram(coordinateSystem(initialScale = 0.05)),
  experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-6, Interval = 0.002),
  __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end Airfoil2wing_test00;
