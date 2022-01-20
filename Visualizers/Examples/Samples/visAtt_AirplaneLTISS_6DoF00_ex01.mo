within AircraftDynamics.Visualizers.Examples.Samples;

model visAtt_AirplaneLTISS_6DoF00_ex01
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
  AircraftDynamics.RigidBodyFDM.Components.AirplaneLTISS_6DoF00 AirplaneDyn(redeclare package Medium = surrFluid) annotation(
    Placement(visible = true, transformation(origin = {30, -10}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg3 annotation(
    Placement(visible = true, transformation(origin = {-50, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_Tnominal(k = AirplaneDyn.m_par * 9.81 * 0.2) annotation(
    Placement(visible = true, transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Visualizers.AnimRigidBodyAircraftAttitude00 AnimAircraft annotation(
    Placement(visible = true, transformation(origin = {70, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable uSignal_deltaE(fileName = Modelica.Utilities.Files.loadResource("modelica://AircraftDynamics/Visualizers/Examples/Samples/uSignals001_AirplaneLTISS_longiLatSprtd00_ex02.txt"), tableName = "deltaE", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable uSignal_deltaFracT(fileName = Modelica.Utilities.Files.loadResource("modelica://AircraftDynamics/Visualizers/Examples/Samples/uSignals001_AirplaneLTISS_longiLatSprtd00_ex02.txt"), tableName = "deltaFracT", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable uSignal_deltaA(fileName = Modelica.Utilities.Files.loadResource("modelica://AircraftDynamics/Visualizers/Examples/Samples/uSignals001_AirplaneLTISS_longiLatSprtd00_ex02.txt"), tableName = "deltaA", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable uSignal_deltaR(fileName = Modelica.Utilities.Files.loadResource("modelica://AircraftDynamics/Visualizers/Examples/Samples/uSignals001_AirplaneLTISS_longiLatSprtd00_ex02.txt"), tableName = "deltaR", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(uSignal_deltaR.y[1], from_deg3.u) annotation(
    Line(points = {{-79, -70}, {-62, -70}}, color = {0, 0, 127}));
  connect(uSignal_deltaFracT.y[1], gain_Tnominal.u) annotation(
    Line(points = {{-79, 10}, {-62, 10}}, color = {0, 0, 127}));
  connect(uSignal_deltaA.y[1], from_deg2.u) annotation(
    Line(points = {{-79, -30}, {-62, -30}}, color = {0, 0, 127}));
  connect(uSignal_deltaE.y[1], from_deg1.u) annotation(
    Line(points = {{-79, 50}, {-62, 50}}, color = {0, 0, 127}));
  connect(AirplaneDyn.VisInfoOut, AnimAircraft.VisInfoIn) annotation(
    Line(points = {{57, 20}, {57, 50}, {60, 50}}, color = {95, 95, 95}));
  connect(from_deg3.y, AirplaneDyn.u_deltaR) annotation(
    Line(points = {{-38, -70}, {-30, -70}, {-30, -20}, {-2, -20}}, color = {0, 0, 127}));
  connect(from_deg2.y, AirplaneDyn.u_deltaA) annotation(
    Line(points = {{-38, -30}, {-36, -30}, {-36, -13}, {-2, -13}}, color = {0, 0, 127}));
  connect(gain_Tnominal.y, AirplaneDyn.u_deltaT) annotation(
    Line(points = {{-38, 10}, {-36, 10}, {-36, -3}, {-2, -3}}, color = {0, 0, 127}));
  connect(from_deg1.y, AirplaneDyn.u_deltaE) annotation(
    Line(points = {{-38, 50}, {-28, 50}, {-28, 3}, {-2, 3}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -120}, {120, 120}})),
    __OpenModelica_commandLineOptions = "",
    experiment(StartTime = 0, StopTime = 150, Tolerance = 1e-06, Interval = 0.01),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end visAtt_AirplaneLTISS_6DoF00_ex01;
