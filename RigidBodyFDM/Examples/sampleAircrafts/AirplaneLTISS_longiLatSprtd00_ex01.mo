within AircraftDynamics.RigidBodyFDM.Examples.sampleAircrafts;

model AirplaneLTISS_longiLatSprtd00_ex01
  extends Modelica.Icons.Example;
  //-----
  //package surrFluid = Modelica.Media.Air.DryAirNasa;
  package surrFluid = AircraftDynamics.Media.DryAirMethaneMixture00;
  //redeclare package Medium = surrFluid
  //-----
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {-50, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-70, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression uSignal_deltaA(y = if time <= 72 then 0 elseif 72 <= time and time <= 73 then -6
   elseif 82 <= time and time <= 83 then 6
   elseif 91 <= time then 0 else 0) annotation(
    Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression uSignal_deltaR(y = if time <= 22 then 0 elseif 22 <= time and time <= 23 then -6
   elseif 42 <= time and time <= 43 then 6
   elseif 51 <= time then 0 else 0) annotation(
    Placement(visible = true, transformation(origin = {-90, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg2 annotation(
    Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.AirplaneLTISS_longiLatSprtd00 AirplaneDyn(redeclare package Medium = surrFluid) annotation(
    Placement(visible = true, transformation(origin = {30, 20}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg3 annotation(
    Placement(visible = true, transformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression uSignal_deltaE(y = if time <= 2 then 0 elseif 2 <= time and time <= 3 then -3
   elseif 7 <= time and time <= 8 then 3
   elseif 31 <= time then 0 else 0) annotation(
    Placement(visible = true, transformation(origin = {-90, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression uSignal_deltaFracT(y = if time <= 2 then 0 elseif 2 <= time and time <= 3 then 0
   elseif 30 <= time and time <= 31 then 0
   elseif 31 <= time then 0 else 0) annotation(
    Placement(visible = true, transformation(origin = {-90, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_Tnominal(k = 50)  annotation(
    Placement(visible = true, transformation(origin = {-50, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(uSignal_deltaFracT.y, gain_Tnominal.u) annotation(
    Line(points = {{-79, 40}, {-70, 40}, {-70, 40}, {-61, 40}, {-61, 40}, {-63, 40}, {-63, 40}, {-63, 40}}, color = {0, 0, 127}));
  connect(gain_Tnominal.y, AirplaneDyn.u_deltaT) annotation(
    Line(points = {{-39, 40}, {-35, 40}, {-35, 32}, {-4, 32}}, color = {0, 0, 127}));
  connect(uSignal_deltaE.y, from_deg1.u) annotation(
    Line(points = {{-79, 80}, {-63, 80}, {-63, 80}, {-63, 80}}, color = {0, 0, 127}));
  connect(from_deg3.y, AirplaneDyn.u_deltaR) annotation(
    Line(points = {{-39, -40}, {-34, -40}, {-34, -40}, {-29, -40}, {-29, 2}, {-17.5, 2}, {-17.5, 2}, {-11.75, 2}, {-11.75, 2}, {-4, 2}}, color = {0, 0, 127}));
  connect(uSignal_deltaR.y, from_deg3.u) annotation(
    Line(points = {{-79, -40}, {-76.5, -40}, {-76.5, -40}, {-72, -40}, {-72, -40}, {-63, -40}, {-63, -40}, {-64, -40}, {-64, -40}, {-63, -40}}, color = {0, 0, 127}));
  connect(from_deg1.y, AirplaneDyn.u_deltaE) annotation(
    Line(points = {{-39, 80}, {-27, 80}, {-27, 44}, {-4, 44}}, color = {0, 0, 127}));
  connect(from_deg2.y, AirplaneDyn.u_deltaA) annotation(
    Line(points = {{-39, 0}, {-38.5, 0}, {-38.5, 0}, {-38, 0}, {-38, 0}, {-35, 0}, {-35, 14}, {-20.5, 14}, {-20.5, 14}, {-4, 14}}, color = {0, 0, 127}));
  connect(uSignal_deltaA.y, from_deg2.u) annotation(
    Line(points = {{-79, 0}, {-61, 0}, {-61, 0}, {-63, 0}, {-63, 0}, {-63, 0}, {-63, 0}, {-63, 0}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -100}, {120, 120}})),
    __OpenModelica_commandLineOptions = "",
    experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.02),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end AirplaneLTISS_longiLatSprtd00_ex01;
