within AircraftDynamics.RigidBodyFDM.Examples.sampleAircrafts;

model LongitudinalLTISS00_ex01
  extends Modelica.Icons.Example;
  //-----
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1 annotation(
    Placement(visible = true, transformation(origin = {-50, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner AircraftDynamics.SimEnvironment environmentAircraftDynSim annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AircraftDynamics.RigidBodyFDM.Components.LongitudinalLTISS00 FltDynLongiSS(use_u_U1 = false, use_u_q1bar = false)  annotation(
    Placement(visible = true, transformation(origin = {33.0548, 19.8733}, extent = {{-32.2028, -20.1267}, {28.1774, 20.1267}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_Tsteady(k = 50) annotation(
    Placement(visible = true, transformation(origin = {-50, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.To_deg to_deg1 annotation(
    Placement(visible = true, transformation(origin = {90, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator1 annotation(
    Placement(visible = true, transformation(origin = {90, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression uSignal_deltaE(y = if time <= 2 then 0 elseif 2 <= time and time <= 3 then -3 elseif 7 <= time and time <= 8 then 3    elseif 31 <= time then 0 else 0)  annotation(
    Placement(visible = true, transformation(origin = {-90, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression uSignal_deltaFracT(y = if time <= 2 then 0 elseif 2 <= time and time <= 3 then 0    elseif 30 <= time and time <= 31 then 0
   elseif 31 <= time then 0 else 0)  annotation(
    Placement(visible = true, transformation(origin = {-90, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(gain_Tsteady.y, FltDynLongiSS.u_deltaT) annotation(
    Line(points = {{-39, -20}, {-22, -20}, {-22, 8}, {-2, 8}}, color = {0, 0, 127}));
  connect(FltDynLongiSS.y_q, to_deg1.u) annotation(
    Line(points = {{62, 12}, {70, 12}, {70, 16}, {78, 16}}, color = {0, 0, 127}));
  connect(FltDynLongiSS.y_q, integrator1.u) annotation(
    Line(points = {{62, 12}, {70, 12}, {70, -20}, {78, -20}}, color = {0, 0, 127}));
  connect(from_deg1.y, FltDynLongiSS.u_deltaE) annotation(
    Line(points = {{-39, 20}, {-30, 20}, {-30, 32}, {-2, 32}}, color = {0, 0, 127}));
  connect(uSignal_deltaE.y, from_deg1.u) annotation(
    Line(points = {{-78, 20}, {-62, 20}}, color = {0, 0, 127}));
  connect(uSignal_deltaFracT.y, gain_Tsteady.u) annotation(
    Line(points = {{-78, -20}, {-62, -20}, {-62, -20}, {-62, -20}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -100}, {120, 120}})),
    __OpenModelica_commandLineOptions = "",
    experiment(StartTime = 0, StopTime = 120, Tolerance = 1e-06, Interval = 0.01),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
end LongitudinalLTISS00_ex01;
