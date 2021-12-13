within AircraftDynamics.RigidBodyFDM.Examples.tests;

model AirplaneLTISS_6DoF00_ex01
  extends Modelica.Icons.Example;
  //-----
  //package surrFluid = Modelica.Media.Air.DryAirNasa;
  package surrFluid = AircraftDynamics.Media.DryAirMethaneMixture00;
  //redeclare package Medium = surrFluid
  //-----
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {10, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-70, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg_cmd_phi annotation(
    Placement(visible = true, transformation(origin = {-160, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg3 annotation(
    Placement(visible = true, transformation(origin = {10, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_Tnominal(k = AirplaneDyn.m_par * 9.81 * 0.2) annotation(
    Placement(visible = true, transformation(origin = {10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable uSignal_deltaE(table = [0, 0; 2, 0; 2, -3; 3, -3; 3, 0; 7, 0; 7, 3; 8, 3; 8, 0; 10, 0; 270, 0; 270, -0.0; 280, -0.0; 300, -0.0; 350, -0.0]) annotation(
    Placement(visible = true, transformation(origin = {-30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable uSignal_deltaFracT(table = [0, 0; 270, 0; 270, 0.0; 350, 0.0; 350, 0.2; 600, 0.2; 600, 0.0; 650, 0.0]) annotation(
    Placement(visible = true, transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable cmd_phi(table = [0, 0; 250, 0; 250, -10.0; 270, -10.0; 270, 0.0; 300, 0.0; 350, 0.0])  annotation(
    Placement(visible = true, transformation(origin = {-190, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable uSignal_deltaR(table = [0, 0; 100, 0; 100, -3.0; 101, -3.0; 101, 0; 110, 0; 110, 2.8; 111, 2.8; 111, 0; 150, 0]) annotation(
    Placement(visible = true, transformation(origin = {-30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter_deltaA(limitsAtInit = true, uMax = 25 * Modelica.Constants.pi / 180.0)  annotation(
    Placement(visible = true, transformation(origin = {0, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.Sensors.BankAngle sensorPhi annotation(
    Placement(visible = true, transformation(origin = {120, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Math.Gain gain(k = 0.5)  annotation(
    Placement(visible = true, transformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum1(nin = 2)  annotation(
    Placement(visible = true, transformation(origin = {-50, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {-130, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimIntegrator limIntegrator1(initType = Modelica.Blocks.Types.Init.NoInit, k = 0.1, outMax = 25 * Modelica.Constants.pi / 180.0)  annotation(
    Placement(visible = true, transformation(origin = {-90, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.AirplaneLTISS_6DoF00 AirplaneDyn(redeclare package Medium = AircraftDynamics.Media.DryAirMethaneMixture00) annotation(
    Placement(visible = true, transformation(origin = {100, -3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(from_deg3.y, AirplaneDyn.u_deltaR) annotation(
    Line(points = {{22, -50}, {50, -50}, {50, -12}, {78, -12}}, color = {0, 0, 127}));
  connect(limiter_deltaA.y, AirplaneDyn.u_deltaA) annotation(
    Line(points = {{12, -10}, {30, -10}, {30, -4}, {78, -4}}, color = {0, 0, 127}));
  connect(gain_Tnominal.y, AirplaneDyn.u_deltaT) annotation(
    Line(points = {{22, 30}, {38, 30}, {38, 8}, {78, 8}}, color = {0, 0, 127}));
  connect(from_deg1.y, AirplaneDyn.u_deltaE) annotation(
    Line(points = {{22, 70}, {48, 70}, {48, 16}, {78, 16}}, color = {0, 0, 127}));
  connect(AirplaneDyn.FltStatesBus1, sensorPhi.FltStatesBus1) annotation(
    Line(points = {{120, -16}, {120, -80}}, color = {255, 204, 51}, thickness = 0.5));
  connect(sensorPhi.y_phi, feedback.u2) annotation(
    Line(points = {{109, -90}, {-130, -90}, {-130, -18}}, color = {0, 0, 127}));
  connect(feedback.y, limIntegrator1.u) annotation(
    Line(points = {{-120, -10}, {-112, -10}, {-112, -40}, {-102, -40}, {-102, -40}}, color = {0, 0, 127}));
  connect(limIntegrator1.y, sum1.u[2]) annotation(
    Line(points = {{-78, -40}, {-72, -40}, {-72, -10}, {-62, -10}, {-62, -10}}, color = {0, 0, 127}));
  connect(uSignal_deltaR.y, from_deg3.u) annotation(
    Line(points = {{-19, -50}, {-5, -50}, {-5, -50}, {-3, -50}}, color = {0, 0, 127}));
  connect(cmd_phi.y, from_deg_cmd_phi.u) annotation(
    Line(points = {{-179, -10}, {-172, -10}}, color = {0, 0, 127}));
  connect(uSignal_deltaFracT.y, gain_Tnominal.u) annotation(
    Line(points = {{-19, 30}, {-3, 30}, {-3, 30}, {-3, 30}}, color = {0, 0, 127}));
  connect(uSignal_deltaE.y, from_deg1.u) annotation(
    Line(points = {{-19, 70}, {-3, 70}, {-3, 70}, {-3, 70}}, color = {0, 0, 127}));
  connect(sum1.y, limiter_deltaA.u) annotation(
    Line(points = {{-38, -10}, {-12, -10}}, color = {0, 0, 127}));
  connect(feedback.y, gain.u) annotation(
    Line(points = {{-120, -10}, {-102, -10}}, color = {0, 0, 127}));
  connect(gain.y, sum1.u[1]) annotation(
    Line(points = {{-78, -10}, {-62, -10}}, color = {0, 0, 127}));
  connect(from_deg_cmd_phi.y, feedback.u1) annotation(
    Line(points = {{-148, -10}, {-138, -10}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -120}, {140, 120}})),
    __OpenModelica_commandLineOptions = "",
    experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 0.05),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end AirplaneLTISS_6DoF00_ex01;
