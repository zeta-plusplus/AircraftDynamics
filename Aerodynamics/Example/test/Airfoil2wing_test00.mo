within AircraftDynamics.Aerodynamics.Example.test;

model Airfoil2wing_test00
  extends Modelica.Icons.Example;
  AircraftDynamics.Aerodynamics.BaseClasses.AirfoilSimple00 airfoilSimple001 annotation(
    Placement(visible = true, transformation(origin = {-30, 40}, extent = {{-10, -8}, {10, 8}}, rotation = 0)));
  AircraftDynamics.Aerodynamics.BaseClasses.Airfoil2WingSimple00 airfoil2WingSimple001 annotation(
    Placement(visible = true, transformation(origin = {10, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 10, height = 7 * 2 * Modelica.Constants.pi / 180, offset = -7 * Modelica.Constants.pi / 180, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-60, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0.3)  annotation(
    Placement(visible = true, transformation(origin = {-60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const.y, airfoil2WingSimple001.signalBus1.Mn) annotation(
    Line(points = {{-48, -20}, {6, -20}, {6, 30}, {6, 30}}, color = {0, 0, 127}));
  connect(airfoilSimple001.signalBus2, airfoil2WingSimple001.signalBus1) annotation(
    Line(points = {{-24, 32}, {-24, 32}, {-24, 16}, {6, 16}, {6, 30}, {6, 30}}, color = {255, 204, 51}, thickness = 0.5));
  connect(ramp1.y, airfoilSimple001.signalBus1.alpha) annotation(
    Line(points = {{-49, 10}, {-34, 10}, {-34, 32}, {-35, 32}}, color = {0, 0, 127}));
  connect(ramp1.y, airfoil2WingSimple001.signalBus1.alpha) annotation(
    Line(points = {{-49, 10}, {6.5, 10}, {6.5, 30}, {5, 30}}, color = {0, 0, 127}));

annotation(
    Icon(coordinateSystem(initialScale = 0.05)),
    Diagram(coordinateSystem(initialScale = 0.05)),
  experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-6, Interval = 0.002),
  __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end Airfoil2wing_test00;