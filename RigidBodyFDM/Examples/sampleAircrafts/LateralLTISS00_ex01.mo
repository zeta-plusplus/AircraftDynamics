within AircraftDynamics.RigidBodyFDM.Examples.sampleAircrafts;

model LateralLTISS00_ex01
  extends Modelica.Icons.Example;
  //-----
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
  AircraftDynamics.RigidBodyFDM.Components.LateralLTISS00 FltDynLateralSS(use_u_U1 = false, use_u_q1bar = false)  annotation(
    Placement(visible = true, transformation(origin = {30, -3.3333}, extent = {{-30, -23.3333}, {30, 23.3333}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.To_deg to_deg_r annotation(
    Placement(visible = true, transformation(origin = {90, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
  connect(from_deg2.y, FltDynLateralSS.u_deltaR) annotation(
    Line(points = {{-39, -40}, {-15, -40}, {-15, 0}, {-3, 0}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -100}, {120, 120}})),
    __OpenModelica_commandLineOptions = "",
    experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-06, Interval = 0.01),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end LateralLTISS00_ex01;
