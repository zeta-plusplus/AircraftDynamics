within AircraftDynamics.RigidBodyFDM.Examples.sampleAircrafts;

model LongitudinalLTISS00_ex03
  extends Modelica.Icons.Example;
  //-----
  //package surrFluid = Modelica.Media.Air.DryAirNasa;
  package surrFluid = AircraftDynamics.Media.DryAirMethaneMixture00;
  //redeclare package Medium = surrFluid
  //-----
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {-50, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const_S(k = 16.165129) annotation(
    Placement(visible = true, transformation(origin = {10, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const_m(k = 1202.01978) annotation(
    Placement(visible = true, transformation(origin = {40, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const_Iyy(k = 1824.9309607) annotation(
    Placement(visible = true, transformation(origin = {70, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const_cBar(k = 1.49352) annotation(
    Placement(visible = true, transformation(origin = {100, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  AircraftDynamics.Sources.FlightCondition2Fluid00 Flt2Fluid(redeclare package Medium = surrFluid, MN_paramInput = 0.201, alt_paramInput = 1524) annotation(
    Placement(visible = true, transformation(origin = {-70, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.LongitudinalLTISS00 FltDynLongiSS(use_u_Iyy = true, use_u_S = true, use_u_U1 = true, use_u_cBar = true, use_u_m = true, use_u_q1bar = true)  annotation(
    Placement(visible = true, transformation(origin = {32.0548, 19.8733}, extent = {{-32.2028, -20.1267}, {28.1774, 20.1267}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_Tsteady(k = FltDynLongiSS.m_par * 9.81 * 0.2) annotation(
    Placement(visible = true, transformation(origin = {-50, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.To_deg to_deg1 annotation(
    Placement(visible = true, transformation(origin = {90, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator1 annotation(
    Placement(visible = true, transformation(origin = {90, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression uSignal_deltaE(y = if time <= 2 then 0 elseif 2 <= time and time <= 3 then -3 elseif 7 <= time and time <= 8 then 3    elseif 31 <= time then 0 else 0)  annotation(
    Placement(visible = true, transformation(origin = {-90, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression uSignal_deltaFracT(y = if time <= 250 then 0 elseif 250 <= time and time <= 300 then 0.2    elseif 350 <= time and time <= 400 then 0
   elseif 400 <= time then 0 else 0)  annotation(
    Placement(visible = true, transformation(origin = {-90, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Flt2Fluid.y_qBar, FltDynLongiSS.u_q1bar) annotation(
    Line(points = {{-58, 52}, {4, 52}, {4, 42}}, color = {0, 0, 127}));
  connect(FltDynLongiSS.u_U1, Flt2Fluid.y_V_inf) annotation(
    Line(points = {{12, 42}, {12, 56}, {-58, 56}}, color = {0, 0, 127}));
  connect(const_S.y, FltDynLongiSS.u_S) annotation(
    Line(points = {{10, 100}, {10, 90}, {32, 90}, {32, 42}}, color = {0, 0, 127}));
  connect(const_m.y, FltDynLongiSS.u_m) annotation(
    Line(points = {{40, 100}, {40, 42}}, color = {0, 0, 127}));
  connect(const_Iyy.y, FltDynLongiSS.u_Iyy) annotation(
    Line(points = {{70, 100}, {70, 88}, {48, 88}, {48, 42}}, color = {0, 0, 127}));
  connect(const_cBar.y, FltDynLongiSS.u_cBar) annotation(
    Line(points = {{100, 100}, {100, 68}, {56, 68}, {56, 42}}, color = {0, 0, 127}));
  connect(gain_Tsteady.y, FltDynLongiSS.u_deltaT) annotation(
    Line(points = {{-39, -20}, {-8, -20}, {-8, 8}, {-2, 8}}, color = {0, 0, 127}));
  connect(FltDynLongiSS.y_q, to_deg1.u) annotation(
    Line(points = {{62, 26}, {70, 26}, {70, 16}, {78, 16}}, color = {0, 0, 127}));
  connect(FltDynLongiSS.y_q, integrator1.u) annotation(
    Line(points = {{62, 26}, {70, 26}, {70, -20}, {78, -20}}, color = {0, 0, 127}));
  connect(from_deg1.y, FltDynLongiSS.u_deltaE) annotation(
    Line(points = {{-39, 20}, {-30, 20}, {-30, 32}, {-2, 32}}, color = {0, 0, 127}));
  connect(uSignal_deltaE.y, from_deg1.u) annotation(
    Line(points = {{-78, 20}, {-62, 20}}, color = {0, 0, 127}));
  connect(uSignal_deltaFracT.y, gain_Tsteady.u) annotation(
    Line(points = {{-78, -20}, {-62, -20}, {-62, -20}, {-62, -20}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -100}, {120, 120}})),
    __OpenModelica_commandLineOptions = "",
    experiment(StartTime = 0, StopTime = 350, Tolerance = 1e-06, Interval = 0.01),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end LongitudinalLTISS00_ex03;
