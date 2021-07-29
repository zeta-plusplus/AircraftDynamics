within AircraftDynamics.RigidBodyFDM.Examples.sampleAircrafts;

model AirplaneLTISS_longiLatSprtd00_ex02
  extends Modelica.Icons.Example;
  //-----
  //package surrFluid = Modelica.Media.Air.DryAirNasa;
  package surrFluid = AircraftDynamics.Media.DryAirMethaneMixture00;
  //redeclare package Medium = surrFluid
  //-----
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {-50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-70, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg2 annotation(
    Placement(visible = true, transformation(origin = {-50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.AirplaneLTISS_longiLatSprtd00 AirplaneDyn(redeclare package Medium = surrFluid) annotation(
    Placement(visible = true, transformation(origin = {30,-10}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg3 annotation(
    Placement(visible = true, transformation(origin = {-50, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_Tnominal(k = AirplaneDyn.m_par * 9.81 * 0.2)  annotation(
    Placement(visible = true, transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable uSignal_deltaE(table = [0, 0; 2, 0; 2, -3; 3, -3; 3, 0; 7, 0; 7, 3; 8, 3; 8, 0; 10, 0; 270, 0; 270, -1.0; 280, -1.5; 300, -1.5; 350, -1.5])  annotation(
    Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable uSignal_deltaFracT(table = [0, 0; 270, 0; 270, 0.0; 300, 0.0; 300, 0; 350, 0; 500, 0; 500, 0.4; 550, 0.4; 550, 0.0; 600, 0.0])  annotation(
    Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable uSignal_deltaA(table = [0, 0; 250, 0; 250, -3.2; 251, -3.2; 251, -0.05; 260, -0.05; 260, 3.25; 261, 3.25; 261, 0.0; 300, 0.0; 350, 0.0])  annotation(
    Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable uSignal_deltaR(table = [0, 0; 50, 0; 50, -0; 51, -0; 51, 0; 60, 0; 60, 0.0; 61, 0.0; 61, 0; 70, 0])  annotation(
    Placement(visible = true, transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(uSignal_deltaR.y, from_deg3.u) annotation(
    Line(points = {{-78, -70}, {-64, -70}, {-64, -70}, {-62, -70}}, color = {0, 0, 127}));
  connect(uSignal_deltaA.y, from_deg2.u) annotation(
    Line(points = {{-78, -30}, {-62, -30}, {-62, -30}, {-62, -30}}, color = {0, 0, 127}));
  connect(uSignal_deltaFracT.y, gain_Tnominal.u) annotation(
    Line(points = {{-78, 10}, {-62, 10}, {-62, 10}, {-62, 10}}, color = {0, 0, 127}));
  connect(uSignal_deltaE.y, from_deg1.u) annotation(
    Line(points = {{-78, 50}, {-62, 50}, {-62, 50}, {-62, 50}}, color = {0, 0, 127}));
  connect(from_deg3.y, AirplaneDyn.u_deltaR) annotation(
    Line(points = {{-38, -70}, {-30, -70}, {-30, -28}, {-3, -28}}, color = {0, 0, 127}));
  connect(from_deg2.y, AirplaneDyn.u_deltaA) annotation(
    Line(points = {{-38, -30}, {-36, -30}, {-36, -16}, {-3, -16}}, color = {0, 0, 127}));
  connect(gain_Tnominal.y, AirplaneDyn.u_deltaT) annotation(
    Line(points = {{-38, 10}, {-36, 10}, {-36, 2}, {-3, 2}}, color = {0, 0, 127}));
  connect(from_deg1.y, AirplaneDyn.u_deltaE) annotation(
    Line(points = {{-38, 50}, {-28, 50}, {-28, 14}, {-3, 14}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -100}, {120, 120}})),
    __OpenModelica_commandLineOptions = "",
    experiment(StartTime = 0, StopTime = 700, Tolerance = 1e-06, Interval = 0.056),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end AirplaneLTISS_longiLatSprtd00_ex02;
