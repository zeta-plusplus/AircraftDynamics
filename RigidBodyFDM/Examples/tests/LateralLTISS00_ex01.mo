within AircraftDynamics.RigidBodyFDM.Examples.tests;

model LateralLTISS00_ex01
  extends Modelica.Icons.Example;
  //-----
  //package surrFluid = Modelica.Media.Air.DryAirNasa;
  package surrFluid = AircraftDynamics.Media.DryAirMethaneMixture00;
  //redeclare package Medium = surrFluid
  //-----
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const_S(k = 16.165129) annotation(
    Placement(visible = true, transformation(origin = {-50, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const_m(k = 1202.01978) annotation(
    Placement(visible = true, transformation(origin = {-20, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const_Ixx(k = 1285.3154166) annotation(
    Placement(visible = true, transformation(origin = {40, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const_b(k = 10.9728) annotation(
    Placement(visible = true, transformation(origin = {10, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  AircraftDynamics.Sources.FlightCondition2Fluid00 Flt2Fluid(redeclare package Medium = surrFluid, MN_paramInput = 0.201, alt_paramInput = 1524) annotation(
    Placement(visible = true, transformation(origin = {-70, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.To_deg to_deg_p annotation(
    Placement(visible = true, transformation(origin = {90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression uSignal_deltaA(y = if time <= 2 then 0 elseif 2 <= time and time <= 3 then 0
   elseif 22 <= time and time <= 23 then 0
   elseif 31 <= time then 0 else 0) annotation(
    Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression uSignal_deltaR(y = if time <= 2 then 0 elseif 2 <= time and time <= 3 then -6
   elseif 22 <= time and time <= 23 then 6
   elseif 31 <= time then 0 else 0) annotation(
    Placement(visible = true, transformation(origin = {-90, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg2 annotation(
    Placement(visible = true, transformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.LateralLTISS00 FltDynLateralSS annotation(
    Placement(visible = true, transformation(origin = {30, -3.3333}, extent = {{-30, -23.3333}, {30, 23.3333}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.To_deg to_deg_r annotation(
    Placement(visible = true, transformation(origin = {90, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const_Izz(k = 2666.89390765) annotation(
    Placement(visible = true, transformation(origin = {70, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const_Ixz(k = 0) annotation(
    Placement(visible = true, transformation(origin = {100, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(FltDynLateralSS.y_p, to_deg_p.u) annotation(
    Line(points = {{61.6667, 6.66669}, {69.6667, 6.66669}, {69.6667, 10.6667}, {77.6667, 10.6667}, {77.6667, 10.6667}}, color = {0, 0, 127}));
  connect(uSignal_deltaA.y, from_deg1.u) annotation(
    Line(points = {{-79, 0}, {-63, 0}}, color = {0, 0, 127}));
  connect(from_deg1.y, FltDynLateralSS.u_deltaA) annotation(
    Line(points = {{-39, 0}, {-25, 0}, {-25, 10}, {-3, 10}}, color = {0, 0, 127}));
  connect(uSignal_deltaR.y, from_deg2.u) annotation(
    Line(points = {{-79, -40}, {-63, -40}, {-63, -40}, {-63, -40}}, color = {0, 0, 127}));
  connect(FltDynLateralSS.y_r, to_deg_r.u) annotation(
    Line(points = {{61.6667, 2.88827e-05}, {69.6667, 2.88827e-05}, {69.6667, -19.9996}, {77.6667, -19.9996}, {77.6667, -19.9996}}, color = {0, 0, 127}));
  connect(const_Ixz.y, FltDynLateralSS.par_Ixz) annotation(
    Line(points = {{100, 100}, {100, 50}, {57, 50}, {57, 22}}, color = {0, 0, 127}));
  connect(const_Izz.y, FltDynLateralSS.par_Izz) annotation(
    Line(points = {{70, 100}, {70, 70}, {50, 70}, {50, 22}}, color = {0, 0, 127}));
  connect(const_Ixx.y, FltDynLateralSS.par_Ixx) annotation(
    Line(points = {{40, 100}, {40, 76}, {43, 76}, {43, 22}}, color = {0, 0, 127}));
  connect(const_b.y, FltDynLateralSS.par_b) annotation(
    Line(points = {{10, 99}, {10, 76}, {37, 76}, {37, 22}}, color = {0, 0, 127}));
  connect(const_m.y, FltDynLateralSS.par_m) annotation(
    Line(points = {{-20, 99}, {-20, 72}, {30, 72}, {30, 22}}, color = {0, 0, 127}));
  connect(const_S.y, FltDynLateralSS.par_S) annotation(
    Line(points = {{-50, 99}, {-50, 68}, {23, 68}, {23, 22}}, color = {0, 0, 127}));
  connect(Flt2Fluid.y_qBar, FltDynLateralSS.par_q1bar) annotation(
    Line(points = {{-58, 52}, {3, 52}, {3, 22}}, color = {0, 0, 127}));
  connect(Flt2Fluid.y_V_inf, FltDynLateralSS.par_U1) annotation(
    Line(points = {{-58, 56}, {10, 56}, {10, 22}}, color = {0, 0, 127}));
  connect(from_deg2.y, FltDynLateralSS.u_deltaR) annotation(
    Line(points = {{-39, -40}, {-15, -40}, {-15, 0}, {-3, 0}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -100}, {120, 120}})),
    __OpenModelica_commandLineOptions = "",
    experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-06, Interval = 0.01),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end LateralLTISS00_ex01;
