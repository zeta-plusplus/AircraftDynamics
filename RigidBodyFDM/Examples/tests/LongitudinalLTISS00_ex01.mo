within AircraftDynamics.RigidBodyFDM.Examples.tests;

model LongitudinalLTISS00_ex01
  extends Modelica.Icons.Example;
  //-----
  //package surrFluid = Modelica.Media.Air.DryAirNasa;
  package surrFluid= AircraftDynamics.Media.DryAirMethaneMixture00;
  //redeclare package Medium = surrFluid
  //-----
  Modelica.Blocks.Sources.Ramp ramp_deltaE(duration = 0.01, height = 0, offset = -5, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_delta_iH(duration = 0, height = 0, offset = 0, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_deltaC(duration = 0, height = 0, offset = 0, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_deltaT(duration = 0, height = 0, offset = 0, startTime = 30)  annotation(
    Placement(visible = true, transformation(origin = {-90, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {-60, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg2 annotation(
    Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg3 annotation(
    Placement(visible = true, transformation(origin = {-60, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.LongitudinalLTISS00 LongiSS annotation(
    Placement(visible = true, transformation(origin = {10.2, -1.57143}, extent = {{-30.2, -21.5715}, {30.2, 21.5715}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const_S(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {10, 90}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const_m(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {40, 90}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const_Iyy(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const_cBar(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {100, 90}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  AircraftDynamics.Sources.FlightCondition2Fluid00 Flt2Fluid(redeclare package Medium = surrFluid, MN_paramInput = 0.3, alt_paramInput = 0) annotation(
    Placement(visible = true, transformation(origin = {-60, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(from_deg2.y, LongiSS.u_delta_iH) annotation(
    Line(points = {{-48, 0}, {-44, 0}, {-44, 3}, {-22, 3}}, color = {0, 0, 127}));
  connect(from_deg3.y, LongiSS.u_deltaC) annotation(
    Line(points = {{-48, -30}, {-38, -30}, {-38, -6}, {-22, -6}}, color = {0, 0, 127}));
  connect(from_deg1.y, LongiSS.u_deltaE) annotation(
    Line(points = {{-48, 30}, {-28, 30}, {-28, 11}, {-22, 11}}, color = {0, 0, 127}));
  connect(ramp_deltaT.y, LongiSS.u_deltaT) annotation(
    Line(points = {{-78, -60}, {-30, -60}, {-30, -15}, {-22, -15}}, color = {0, 0, 127}));
  connect(const_S.y, LongiSS.par_S) annotation(
    Line(points = {{10, 78}, {10, 22}}, color = {0, 0, 127}));
  connect(const_m.y, LongiSS.par_m) annotation(
    Line(points = {{40, 80}, {40, 56}, {19, 56}, {19, 22}}, color = {0, 0, 127}));
  connect(const_Iyy.y, LongiSS.par_Iyy) annotation(
    Line(points = {{70, 80}, {70, 48}, {27, 48}, {27, 22}}, color = {0, 0, 127}));
  connect(const_cBar.y, LongiSS.par_cBar) annotation(
    Line(points = {{100, 80}, {100, 30}, {36, 30}, {36, 22}}, color = {0, 0, 127}));
  connect(Flt2Fluid.y_V_inf, LongiSS.par_U1) annotation(
    Line(points = {{-49, 66}, {-3, 66}, {-3, 22}}, color = {0, 0, 127}));
  connect(Flt2Fluid.y_qBar, LongiSS.par_q1bar) annotation(
    Line(points = {{-49, 62}, {-11, 62}, {-11, 22}}, color = {0, 0, 127}));
  connect(ramp_deltaC.y, from_deg3.u) annotation(
    Line(points = {{-78, -30}, {-72, -30}, {-72, -30}, {-72, -30}}, color = {0, 0, 127}));
  connect(ramp_delta_iH.y, from_deg2.u) annotation(
    Line(points = {{-78, 0}, {-72, 0}, {-72, 0}, {-72, 0}}, color = {0, 0, 127}));
  connect(ramp_deltaE.y, from_deg1.u) annotation(
    Line(points = {{-78, 30}, {-72, 30}, {-72, 30}, {-72, 30}}, color = {0, 0, 127}));
annotation(
    Diagram(coordinateSystem(extent = {{-100, -100}, {120, 100}})),
    __OpenModelica_commandLineOptions = "",
  experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-6, Interval = 0.1),
  __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
  
end LongitudinalLTISS00_ex01;
