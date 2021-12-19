within AircraftDynamics.Visualizers.Examples.Samples;

model visAtt_LateralLTISS00_ex01
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
  Modelica.Blocks.Math.UnitConversions.To_deg to_deg_r annotation(
    Placement(visible = true, transformation(origin = {90, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const_Izz(k = 2666.89390765) annotation(
    Placement(visible = true, transformation(origin = {70, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const_Ixz(k = 0) annotation(
    Placement(visible = true, transformation(origin = {100, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  AircraftDynamics.RigidBodyFDM.Components.LateralLTISS00 FltDynLateralSS annotation(
    Placement(visible = true, transformation(origin = {30, -10}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  AircraftDynamics.Visualizers.AnimRigidBodyAircraftAttitude00 AnimAircraft annotation(
    Placement(visible = true, transformation(origin = {70, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(FltDynLateralSS.VisInfoOut, AnimAircraft.VisInfoIn) annotation(
    Line(points = {{50, -40}, {50, -40}, {50, -70}, {60, -70}, {60, -70}}, color = {95, 95, 95}));
  connect(uSignal_deltaA.y, from_deg1.u) annotation(
    Line(points = {{-79, 0}, {-63, 0}}, color = {0, 0, 127}));
  connect(uSignal_deltaR.y, from_deg2.u) annotation(
    Line(points = {{-79, -40}, {-63, -40}, {-63, -40}, {-63, -40}}, color = {0, 0, 127}));
  connect(FltDynLateralSS.y_p, to_deg_p.u) annotation(
    Line(points = {{62, 6}, {70, 6}, {70, 10}, {78, 10}}, color = {0, 0, 127}));
  connect(FltDynLateralSS.y_r, to_deg_r.u) annotation(
    Line(points = {{62, -2}, {66, -2}, {66, -20}, {78, -20}}, color = {0, 0, 127}));
  connect(Flt2Fluid.y_qBar, FltDynLateralSS.u_q1bar) annotation(
    Line(points = {{-58, 54}, {-16, 54}, {-16, 2}, {-2, 2}}, color = {0, 0, 127}));
  connect(Flt2Fluid.y_V_inf, FltDynLateralSS.u_U1) annotation(
    Line(points = {{-58, 58}, {-10, 58}, {-10, 14}, {-2, 14}}, color = {0, 0, 127}));
  connect(const_S.y, FltDynLateralSS.u_S) annotation(
    Line(points = {{-50, 100}, {-50, 78}, {6, 78}, {6, 22}}, color = {0, 0, 127}));
  connect(const_m.y, FltDynLateralSS.u_m) annotation(
    Line(points = {{-20, 100}, {-20, 84}, {14, 84}, {14, 22}}, color = {0, 0, 127}));
  connect(const_b.y, FltDynLateralSS.u_b) annotation(
    Line(points = {{10, 100}, {10, 90}, {22, 90}, {22, 22}}, color = {0, 0, 127}));
  connect(const_Ixx.y, FltDynLateralSS.u_Ixx) annotation(
    Line(points = {{40, 100}, {40, 82}, {30, 82}, {30, 22}}, color = {0, 0, 127}));
  connect(const_Izz.y, FltDynLateralSS.u_Izz) annotation(
    Line(points = {{70, 100}, {70, 70}, {38, 70}, {38, 22}}, color = {0, 0, 127}));
  connect(const_Ixz.y, FltDynLateralSS.u_Ixz) annotation(
    Line(points = {{100, 100}, {100, 60}, {46, 60}, {46, 22}}, color = {0, 0, 127}));
  connect(from_deg1.y, FltDynLateralSS.u_deltaA) annotation(
    Line(points = {{-38, 0}, {-24, 0}, {-24, -14}, {-2, -14}}, color = {0, 0, 127}));
  connect(from_deg2.y, FltDynLateralSS.u_deltaR) annotation(
    Line(points = {{-38, -40}, {-16, -40}, {-16, -26}, {-2, -26}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -100}, {120, 120}})),
    __OpenModelica_commandLineOptions = "",
    experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-06, Interval = 0.01),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end visAtt_LateralLTISS00_ex01;
