within AircraftDynamics.RigidBodyFDM.Examples.tests;

model LongitudinalLTISS00_ex01
  extends Modelica.Icons.Example;
  //-----
  //package surrFluid = Modelica.Media.Air.DryAirNasa;
  package surrFluid= AircraftDynamics.Media.DryAirMethaneMixture00;
  //redeclare package Medium = surrFluid
  //-----
  Modelica.Blocks.Sources.Ramp ramp_deltaE(duration = 5, height = 0, offset = -1, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-90, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_delta_iH(duration = 0, height = 0, offset = 0, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_deltaC(duration = 0, height = 0, offset = 0, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-90, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_deltaT(duration = 0, height = 0, offset = 0, startTime = 30)  annotation(
    Placement(visible = true, transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {-60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg2 annotation(
    Placement(visible = true, transformation(origin = {-60, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg3 annotation(
    Placement(visible = true, transformation(origin = {-60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const_S(k = 16.165129)  annotation(
    Placement(visible = true, transformation(origin = {10, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const_m(k = 1202.01978)  annotation(
    Placement(visible = true, transformation(origin = {40, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const_Iyy(k = 1824.9309607)  annotation(
    Placement(visible = true, transformation(origin = {70, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const_cBar(k = 1.49352)  annotation(
    Placement(visible = true, transformation(origin = {100, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  AircraftDynamics.Sources.FlightCondition2Fluid00 Flt2Fluid(redeclare package Medium = surrFluid, MN_paramInput = 0.201, alt_paramInput = 1524) annotation(
    Placement(visible = true, transformation(origin = {-70, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.LongitudinalLTISS00 LongiSS(alpha0 = 0)  annotation(
    Placement(visible = true, transformation(origin = {33.0548, 19.8733}, extent = {{-32.2028, -20.1267}, {28.1774, 20.1267}}, rotation = 0)));
equation
  connect(from_deg1.y, LongiSS.u_deltaE) annotation(
    Line(points = {{-49, 20}, {-44, 20}, {-44, 32}, {-2, 32}}, color = {0, 0, 127}));
  connect(ramp_deltaE.y, from_deg1.u) annotation(
    Line(points = {{-79, 20}, {-73, 20}, {-73, 20}, {-73, 20}}, color = {0, 0, 127}));
  connect(ramp_delta_iH.y, from_deg2.u) annotation(
    Line(points = {{-79, -10}, {-73, -10}, {-73, -10}, {-73, -10}}, color = {0, 0, 127}));
  connect(from_deg2.y, LongiSS.u_delta_iH) annotation(
    Line(points = {{-49, -10}, {-40, -10}, {-40, 24}, {-2, 24}}, color = {0, 0, 127}));
  connect(ramp_deltaC.y, from_deg3.u) annotation(
    Line(points = {{-79, -40}, {-73, -40}, {-73, -40}, {-73, -40}}, color = {0, 0, 127}));
  connect(from_deg3.y, LongiSS.u_deltaC) annotation(
    Line(points = {{-49, -40}, {-34, -40}, {-34, 16}, {-2, 16}}, color = {0, 0, 127}));
  connect(ramp_deltaT.y, LongiSS.u_deltaT) annotation(
    Line(points = {{-79, -70}, {-22, -70}, {-22, 8}, {-2, 8}}, color = {0, 0, 127}));
  connect(const_cBar.y, LongiSS.par_cBar) annotation(
    Line(points = {{100, 100}, {100, 68}, {56, 68}, {56, 42}}, color = {0, 0, 127}));
  connect(const_Iyy.y, LongiSS.par_Iyy) annotation(
    Line(points = {{70, 100}, {70, 88}, {48, 88}, {48, 42}}, color = {0, 0, 127}));
  connect(const_m.y, LongiSS.par_m) annotation(
    Line(points = {{40, 100}, {40, 42}}, color = {0, 0, 127}));
  connect(const_S.y, LongiSS.par_S) annotation(
    Line(points = {{10, 100}, {10, 90}, {32, 90}, {32, 42}}, color = {0, 0, 127}));
  connect(LongiSS.par_U1, Flt2Fluid.y_V_inf) annotation(
    Line(points = {{12, 42}, {14, 42}, {14, 56}, {-58, 56}}, color = {0, 0, 127}));
  connect(Flt2Fluid.y_qBar, LongiSS.par_q1bar) annotation(
    Line(points = {{-58, 52}, {4, 52}, {4, 42}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -100}, {120, 120}})),
    __OpenModelica_commandLineOptions = "",
  experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-6, Interval = 0.1),
  __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
  
end LongitudinalLTISS00_ex01;
