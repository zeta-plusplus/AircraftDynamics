within AircraftDynamics.RigidBodyFDM.Examples.tests;

model airplaneLTISS_longiLatSprtd00_ex01
  extends Modelica.Icons.Example;
  //-----
  //package surrFluid = Modelica.Media.Air.DryAirNasa;
  package surrFluid = AircraftDynamics.Media.DryAirMethaneMixture00;
  //redeclare package Medium = surrFluid
  //-----
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {-50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression uSignal_deltaA(y = if time <= 2 then 0 elseif 2 <= time and time <= 3 then 0
   elseif 22 <= time and time <= 23 then 0
   elseif 31 <= time then 0 else 0) annotation(
    Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression uSignal_deltaR(y = if time <= 2 then 0 elseif 2 <= time and time <= 3 then -6
   elseif 22 <= time and time <= 23 then 6
   elseif 31 <= time then 0 else 0) annotation(
    Placement(visible = true, transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg2 annotation(
    Placement(visible = true, transformation(origin = {-50, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.airplaneLTISS_longiLatSprtd00 AirplaneDyn annotation(
    Placement(visible = true, transformation(origin = {20,-10}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
equation
  connect(uSignal_deltaA.y, from_deg1.u) annotation(
    Line(points = {{-79, -30}, {-63, -30}}, color = {0, 0, 127}));
  connect(uSignal_deltaR.y, from_deg2.u) annotation(
    Line(points = {{-79, -70}, {-63, -70}, {-63, -70}, {-63, -70}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -100}, {120, 120}})),
    __OpenModelica_commandLineOptions = "",
    experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-06, Interval = 0.01),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end airplaneLTISS_longiLatSprtd00_ex01;
