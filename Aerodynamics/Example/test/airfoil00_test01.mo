within AircraftDynamics.Aerodynamics.Example.test;

model airfoil00_test01
  extends Modelica.Icons.Example;
  AircraftDynamics.Aerodynamics.BaseClasses.AirfoilSimple00 AirfoilSimple00 annotation(
    Placement(visible = true, transformation(origin = {-30, 30}, extent = {{-10, -5}, {10, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 20, height = 7 * 2 * (Modelica.Constants.pi / 180), offset = -7 * (Modelica.Constants.pi / 180), startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ramp1.y, AirfoilSimple00.u_AoA) annotation(
    Line(points = {{-58, 30}, {-40, 30}, {-40, 30}, {-40, 30}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-06, Interval = 0.01),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end airfoil00_test01;
